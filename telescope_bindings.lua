local map = vim.keymap.set

map("n", "<leader>b", function() require("telescope.builtin").buffers() end, opts)
map("n", "<leader>f", function() require("telescope.builtin").find_files() end, opts)
map("n", "<leader>/", function() require("telescope.builtin").live_grep() end,  opts)

local telescope_fzf_path_complete = function()
  local builtin = require("telescope.builtin")
  local actions = require("telescope.actions")
  local action_state = require("telescope.actions.state")

  -- 1. Grab the current cursor position and the current line text
  local row, col = unpack(vim.api.nvim_win_get_cursor(0))
  local line = vim.api.nvim_get_current_line()

  -- 2. Extract the word directly to the left of the cursor
  -- This pattern looks for the string of characters ending at the cursor
  local prefix = string.match(line:sub(1, col), "(%S+)$") or ""

  builtin.find_files({
    prompt_title = "Insert Path Completion",
    search_file = prefix, -- Presets Telescope's search with your typed string

    attach_mappings = function(prompt_bufnr, map)
      actions.select_default:replace(function()
        local selection = action_state.get_selected_entry()
        actions.close(prompt_bufnr)

        if selection then
          local path = selection.value

          -- 3. If the user typed a prefix (e.g., "foo"), delete it from the line first
          if #prefix > 0 then
            -- Replace the prefix chunk with an empty string, keeping everything else
            local new_line = line:sub(1, col - #prefix) .. line:sub(col + 1)
            vim.api.nvim_set_current_line(new_line)
            -- Readjust cursor position backward by the length of the deleted prefix
            vim.api.nvim_win_set_cursor(0, { row, col - #prefix })
          end

          -- 4. Paste the path exactly where the prefix used to be
          vim.api.nvim_put({ path }, "c", true, true)

          -- 5. Force Neovim back into Insert Mode right after the inserted text
          vim.cmd("startinsert")
        end
      end)
      return true
    end,
  })
end

-- Map it to your preferred shortcut in Insert Mode
vim.keymap.set("i", "<C-x><C-f>", telescope_fzf_path_complete, { desc = "FZF-style inline path completion" })
