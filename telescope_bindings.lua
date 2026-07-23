require("telescope").setup()

local map = vim.keymap.set

map("n", "<leader>b", function() require("telescope.builtin").buffers() end, opts)
map("n", "<leader>f", function() require("telescope.builtin").find_files() end, opts)
map("n", "<leader>/", function() require("telescope.builtin").live_grep() end,  opts)

-- Resolve `dirpart` (the leading, already-typed directory portion of the path
-- token) to an absolute directory, relative to the edited file's directory and
-- expanding a leading `~`.
local function resolve_base(filedir, dirpart)
  if dirpart == "" then return filedir end
  local d = dirpart
  if d:sub(1, 1) == "~" then
    d = vim.fn.expand("~") .. d:sub(2)
  end
  if d:sub(1, 1) ~= "/" then
    d = filedir .. "/" .. d
  end
  return vim.fn.fnamemodify(d, ":p")
end

-- Directory basenames pruned from path completion (matched at any depth).
-- Generic build/cache/VCS junk plus machine-specific heavyweights that would
-- otherwise dominate a home-directory search (in ~ these cut ~400k entries down
-- to ~13k).  Add big local trees here if completion feels slow; remove ".local"
-- if you complete ~/.local paths often.
local EXCLUDE_DIRS = {
  ".git", ".svn", ".hg",
  "node_modules", "__pycache__", ".venv", "venv",
  ".mypy_cache", ".pytest_cache", ".tox",
  ".cache", ".npm", ".cargo", ".rustup", ".gradle", ".m2", ".local",
  "miniforge3", "miniconda3", "anaconda3", "flint-builds",
}

-- Recursive listing command for the picker.  We want *both* files and
-- directories (so `github/` is itself a pickable suggestion), which rules out
-- `rg --files` / `fd --type f`.  Prefer fd (fast, gitignore-aware, hidden);
-- fall back to a `find` that prunes EXCLUDE_DIRS.
local function find_command()
  if vim.fn.executable("fd") == 1 or vim.fn.executable("fdfind") == 1 then
    local bin = vim.fn.executable("fd") == 1 and "fd" or "fdfind"
    local cmd = { bin, "--strip-cwd-prefix", "--hidden" }
    for _, d in ipairs(EXCLUDE_DIRS) do
      table.insert(cmd, "--exclude")
      table.insert(cmd, d)
    end
    return cmd
  else
    local cmd = { "find", ".", "-mindepth", "1", "(" }
    for i, d in ipairs(EXCLUDE_DIRS) do
      if i > 1 then table.insert(cmd, "-o") end
      table.insert(cmd, "-name")
      table.insert(cmd, d)
    end
    vim.list_extend(cmd, { ")", "-prune", "-o", "-print" })
    return cmd
  end
end

local telescope_fzf_path_complete = function()
  local builtin      = require("telescope.builtin")
  local actions      = require("telescope.actions")
  local action_state = require("telescope.actions.state")

  -- Capture the *exact* window/buffer we're editing, plus the cursor and line,
  -- so the insertion later targets them explicitly rather than "whatever is
  -- focused" once Telescope closes.
  local win  = vim.api.nvim_get_current_win()
  local buf  = vim.api.nvim_get_current_buf()
  local row, col = unpack(vim.api.nvim_win_get_cursor(win)) -- col is bytes left of cursor
  local line = vim.api.nvim_get_current_line()

  -- Extract the filename prefix to the left of the cursor.  Grab the full
  -- non-whitespace token (e.g. `src="foo`), then keep only the part after the
  -- last quote or paren so attribute/markdown syntax like src="" or ![](
  -- doesn't leak into the search text.
  local word   = string.match(line:sub(1, col), "(%S+)$") or ""
  local prefix = string.match(word, "[\"'(]([^\"'(]*)$") or word

  -- Split the line into the part before the prefix and the part from the
  -- cursor onward (which keeps any closing quote/paren intact).
  local left  = line:sub(1, col - #prefix)
  local right = line:sub(col + 1)

  local filedir = vim.fn.expand("%:p:h")

  -- Split the typed prefix into a directory part (kept verbatim, trailing slash
  -- included) and a tail.  The directory part scopes the recursive search
  -- (so `~/foo/bar` and absolute paths work); the tail seeds the fuzzy prompt.
  local dirpart, tail = prefix:match("^(.*/)([^/]*)$")
  if not dirpart then dirpart, tail = "", prefix end

  local base = resolve_base(filedir, dirpart)

  builtin.find_files({
    prompt_title = "Insert Path Completion",
    cwd = base,
    find_command = find_command(),
    default_text = tail,

    attach_mappings = function(prompt_bufnr)
      actions.select_default:replace(function()
        local selection = action_state.get_selected_entry()
        actions.close(prompt_bufnr)
        if not selection then return end

        -- Defer until after Telescope has finished closing, then restore focus
        -- to the original window explicitly so the edit can't land on the wrong
        -- buffer on a cold first invocation.
        vim.schedule(function()
          local rel  = selection.value:gsub("^%./", "") -- strip find/fd's leading ./
          -- Reattach the verbatim directory prefix the user already typed, and
          -- append a trailing slash when the pick is itself a directory.
          local text = dirpart .. rel
          if vim.fn.isdirectory(base .. "/" .. rel) == 1 then
            text = text .. "/"
          end

          vim.api.nvim_buf_set_lines(buf, row - 1, row, false, { left .. text .. right })

          if vim.api.nvim_win_is_valid(win) then
            vim.api.nvim_set_current_win(win)
            if #right == 0 then
              -- Appending at end of line: A-style insert.
              vim.api.nvim_win_set_cursor(win, { row, 0 })
              vim.cmd("startinsert!")
            else
              -- Inside quotes/parens: place the cursor right after the inserted
              -- path (i.e. on the first char of `right`) and insert before it.
              vim.api.nvim_win_set_cursor(win, { row, #left + #text })
              vim.cmd("startinsert")
            end
          end
        end)
      end)
      return true
    end,
  })
end

-- Map it to your preferred shortcut in Insert Mode
vim.keymap.set("i", "<C-x><C-f>", telescope_fzf_path_complete, { desc = "FZF-style inline path completion" })
