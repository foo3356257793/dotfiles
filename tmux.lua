-- Bridge to a REPL running in a sibling tmux pane.
--
-- The target is resolved once to a concrete pane id and cached per buffer, so
-- it survives later layout changes. This matters for safety as much as for
-- convenience: tmux resolves a relative target like "right" to the *sending*
-- pane when nothing lies that way, so an unguarded send with no split open
-- types the payload into nvim itself as normal-mode keystrokes.

local M = {}

local function tmux(args, input)
  return vim.fn.system(vim.list_extend({ "tmux" }, args), input)
end

-- ============================================================================
-- TARGET
-- ============================================================================

local function pane_alive(id)
  local out = tmux({ "list-panes", "-a", "-F", "#{pane_id}" })
  return ("\n" .. out):find("\n" .. id .. "\n", 1, true) ~= nil
end

local directions = { left = true, right = true, up = true, down = true }

-- Finds the neighbouring pane in a direction, by geometry, within our own
-- window.
--
-- tmux cannot be asked this directly: a relative target like "right" (or
-- "{right-of}") is resolved against the session's *current* window, not
-- against the calling pane. An nvim in any window that is not the current one
-- therefore resolves "right" to a pane in some other window entirely -- and
-- since that pane is a live, plausible REPL, the code would just go to the
-- wrong place with no error. list-panes -t <pane id>, by contrast, is scoped
-- to that pane's own window.
local function pane_toward(dir)
  local me = vim.env.TMUX_PANE
  if not me then return nil end

  local out = tmux({ "list-panes", "-t", me, "-F",
    "#{pane_id} #{pane_left} #{pane_right} #{pane_top} #{pane_bottom}" })
  if vim.v.shell_error ~= 0 then return nil end

  local panes, mine = {}, nil
  for line in out:gmatch("[^\n]+") do
    local id, left, right, top, bottom = line:match("^(%%%d+) (%d+) (%d+) (%d+) (%d+)$")
    if id then
      local pane = {
        id     = id,
        left   = tonumber(left),
        right  = tonumber(right),
        top    = tonumber(top),
        bottom = tonumber(bottom),
      }
      panes[#panes + 1] = pane
      if id == me then mine = pane end
    end
  end
  if not mine then return nil end

  -- Nearest pane that lies beyond us in `dir` and overlaps us on the other
  -- axis; ties go to the first tmux listed, which is the lowest pane index.
  local best, best_dist = nil, nil
  for _, pane in ipairs(panes) do
    if pane.id ~= me then
      local beyond, dist
      if dir == "right" then
        beyond = pane.left > mine.right
        dist   = pane.left
      elseif dir == "left" then
        beyond = pane.right < mine.left
        dist   = -pane.right
      elseif dir == "down" then
        beyond = pane.top > mine.bottom
        dist   = pane.top
      else
        beyond = pane.bottom < mine.top
        dist   = -pane.bottom
      end

      local overlaps
      if dir == "left" or dir == "right" then
        overlaps = pane.top <= mine.bottom and pane.bottom >= mine.top
      else
        overlaps = pane.left <= mine.right and pane.right >= mine.left
      end

      if beyond and overlaps and (not best_dist or dist < best_dist) then
        best, best_dist = pane.id, dist
      end
    end
  end

  return best
end

-- Returns a concrete pane id (%12), or nil after reporting why not.
function M.target()
  if not vim.env.TMUX then
    vim.notify("tmux: not inside a tmux session", vim.log.levels.WARN)
    return nil
  end

  local id = vim.b.tmux_target
  if id and pane_alive(id) then
    return id
  end

  -- A direction is resolved by geometry; anything else is handed to tmux as a
  -- literal target, so an explicit "%7" or "work:1.2" still works.
  local want = vim.g.tmux_target or "right"
  if directions[want] then
    id = pane_toward(want)
  else
    local out = tmux({ "display-message", "-p", "-t", want, "#{pane_id}" })
    if vim.v.shell_error ~= 0 then
      out = ""
    end
    id = vim.trim(out)
  end

  -- For a literal target tmux falls back to the calling pane rather than
  -- failing, so an unresolved target is indistinguishable from "us".
  if not id or id == "" or id == vim.env.TMUX_PANE then
    vim.notify("tmux: no REPL pane at '" .. want .. "'", vim.log.levels.WARN)
    return nil
  end

  vim.b.tmux_target = id
  return id
end

-- Forget the cached pane and resolve again, optionally against a new target.
-- Bound to :TmuxTarget in init.lua.
function M.retarget(want)
  if want and want ~= "" then
    vim.g.tmux_target = want
  end
  vim.b.tmux_target = nil

  local id = M.target()
  if id then
    vim.notify("tmux: target is " .. id)
  end
end

-- ============================================================================
-- SEND
-- ============================================================================

-- Unconditional -X cancel errors with "not in a mode" on every ordinary send.
local function leave_copy_mode(target)
  local mode = tmux({ "display-message", "-p", "-t", target, "#{pane_in_mode}" })
  if vim.trim(mode) == "1" then
    tmux({ "send", "-t", target, "-X", "cancel" })
  end
end

-- A single line, typed at the prompt and executed.
function M.send(cmd)
  local target = M.target()
  if not target then return end
  leave_copy_mode(target)
  tmux({ "send-keys", "-t", target, cmd, "Enter" })
end

-- Arbitrary text, delivered as one bracketed paste so the REPL takes it
-- atomically and skips autoindent.
--
-- The named buffer is not optional: tmux_fix.lua makes the tmux buffer stack
-- the nvim '+' register, so an unnamed load-buffer would silently overwrite
-- the clipboard on every send.
--
-- The newlines go outside the paste, and there are two of them: the first ends
-- the final line, the second closes a trailing compound statement. With only
-- one, a block ending in a def/for/if leaves the REPL sitting in continuation
-- state with the code buffered but unrun. At an already-empty prompt the
-- second newline is a no-op.
function M.send_text(lines)
  local target = M.target()
  if not target then return end

  lines = vim.deepcopy(lines)
  while #lines > 0 and lines[#lines]:match("^%s*$") do
    table.remove(lines)
  end
  if #lines == 0 then return end

  leave_copy_mode(target)
  tmux({ "load-buffer", "-b", "nvim_send", "-" }, table.concat(lines, "\n"))
  tmux({ "paste-buffer", "-d", "-p", "-b", "nvim_send", "-t", target })
  tmux({ "send-keys", "-t", target, "Enter", "Enter" })
end

-- ============================================================================
-- REGIONS
-- ============================================================================

function M.send_selection()
  local s, e = vim.fn.getpos("'<"), vim.fn.getpos("'>")
  local lines = vim.fn.getline(s[2], e[2])
  if #lines == 0 then return end

  -- Charwise only: trim the partial first and last lines. Order matters when
  -- the selection is confined to one line.
  if vim.fn.visualmode() == "v" then
    lines[#lines] = lines[#lines]:sub(1, e[3])
    lines[1] = lines[1]:sub(s[3])
  end

  M.send_text(lines)
end

-- Walks fences from the top of the buffer rather than scanning outward from
-- the cursor, so a cursor resting on a closing fence isn't mistaken for one
-- resting on an opening fence.
local function fence_region()
  local cur = vim.fn.line(".")
  local lines = vim.fn.getline(1, "$")
  local open = nil

  for i, line in ipairs(lines) do
    if line:match("^%s*```") then
      if open then
        if cur >= open and cur <= i then
          if i == open + 1 then return nil end
          return vim.list_slice(lines, open + 1, i - 1)
        end
        open = nil
      else
        open = i
      end
    end
  end

  return nil
end

local function paragraph_region()
  local cur, last = vim.fn.line("."), vim.fn.line("$")
  if vim.fn.getline(cur):match("^%s*$") then return nil end

  local top = cur
  while top > 1 and not vim.fn.getline(top - 1):match("^%s*$") do
    top = top - 1
  end

  local bot = cur
  while bot < last and not vim.fn.getline(bot + 1):match("^%s*$") do
    bot = bot + 1
  end

  return vim.fn.getline(top, bot)
end

function M.send_region()
  local markdown = vim.bo.filetype:match("markdown") ~= nil
  local region = markdown and fence_region() or paragraph_region()

  if not region then
    vim.notify("tmux: no " .. (markdown and "code fence" or "paragraph") ..
               " under the cursor", vim.log.levels.WARN)
    return
  end

  M.send_text(region)
end

-- ============================================================================
-- ERRORS
-- ============================================================================

-- LSP already covers static errors; these are the runtime ones, which exist
-- only because the code actually ran, and only in the pane.
local traceback = {
  python = {
    start = "^Traceback %(most recent call last%)",
    efm   = table.concat({
      [[%A  File "%f"\, line %l\,%m]],
      [[%A  File "%f"\, line %l]],
      [[%C    %.%#]],
      [[%Z%[%^ ]%\@=%m]],
    }, ","),
  },
  julia = {
    start = "^ERROR:",
    efm   = [[%.%#@ %f:%l,%.%#at %f:%l]],
  },
}

function M.errors()
  local target = M.target()
  if not target then return end

  local kind = vim.bo.filetype:match("julia") and traceback.julia or traceback.python
  -- -J rejoins lines the pane hard-wrapped at its own width. Without it a
  -- traceback whose path is wider than the pane is split mid-line and the
  -- errorformat never sees "File ..., line N" as one line.
  local lines = vim.split(
    tmux({ "capture-pane", "-p", "-J", "-S", "-2000", "-t", target }), "\n")

  local first = nil
  for i = #lines, 1, -1 do
    if lines[i]:match(kind.start) then
      first = i
      break
    end
  end

  if not first then
    vim.notify("tmux: no traceback in the pane's output", vim.log.levels.WARN)
    return
  end

  vim.fn.setqflist({}, " ", {
    title = "tmux REPL",
    lines = vim.list_slice(lines, first, #lines),
    efm   = kind.efm,
  })

  -- The capture runs to the bottom of the pane, so the prompt and every blank
  -- row below the traceback parse as unmatched noise. Keep just the frames.
  local frames = vim.tbl_filter(
    function(e) return e.valid == 1 end, vim.fn.getqflist())

  if vim.tbl_isempty(frames) then
    vim.notify("tmux: found a traceback but no file/line in it", vim.log.levels.WARN)
    return
  end

  vim.fn.setqflist({}, "r", { title = "tmux REPL", items = frames })

  -- Last frame, not first: that is where the exception was actually raised.
  vim.cmd("clast")
end

return M
