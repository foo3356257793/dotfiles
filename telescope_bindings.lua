require("telescope").setup()

local map = vim.keymap.set

map("n", "<leader>b", function() require("telescope.builtin").buffers() end, opts)
map("n", "<leader>f", function() require("telescope.builtin").find_files() end, opts)
map("n", "<leader>/", function() require("telescope.builtin").live_grep() end,  opts)

local telescope_fzf_path_complete = function()
  local builtin = require("telescope.builtin")
  local actions = require("telescope.actions")
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

  builtin.find_files({
    prompt_title = "Insert Path Completion",
    cwd = vim.fn.expand("%:p:h"),
    default_text = prefix,

    attach_mappings = function(prompt_bufnr, map)
      actions.select_default:replace(function()
        local selection = action_state.get_selected_entry()
        actions.close(prompt_bufnr)

        if not selection then return end

        -- Defer until after Telescope has finished closing, then restore focus
        -- to the original window explicitly so the edit can't land on the wrong
        -- buffer on a cold first invocation.
        vim.schedule(function()
          local path = selection.value:gsub("^%./", "") -- strip fd's leading ./

          local new_line = left .. path .. right
          vim.api.nvim_buf_set_lines(buf, row - 1, row, false, { new_line })

          if vim.api.nvim_win_is_valid(win) then
            vim.api.nvim_set_current_win(win)
            if #right == 0 then
              -- Appending at end of line: A-style insert.
              vim.api.nvim_win_set_cursor(win, { row, 0 })
              vim.cmd("startinsert!")
            else
              -- Inside quotes/parens: place cursor right after the inserted
              -- path (i.e. on the first char of `right`) and insert before it.
              vim.api.nvim_win_set_cursor(win, { row, #left + #path })
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
