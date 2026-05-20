-- Package management
local github = function(repo)
    return "https://github.com/" .. repo
end

vim.pack.add({
    github("tpope/vim-fugitive"),
    github("godlygeek/tabular"),
    github("lervag/vimtex"),
    github("kien/rainbow_parentheses.vim"),
    github("christoomey/vim-tmux-navigator"),
    github("Dru89/vim-adventurous"), -- Adventure Time color scheme

    {
        src = github("averms/black-nvim"),
        version = "master",
    },
})

-- Configure keymaps for vim-tmux-navigator manually
vim.keymap.set("n", "<C-h>", "<cmd>TmuxNavigateLeft<cr>", { silent = true, desc = "Navigate Left to Tmux" })
vim.keymap.set("n", "<C-j>", "<cmd>TmuxNavigateDown<cr>", { silent = true, desc = "Navigate Down to Tmux" })
vim.keymap.set("n", "<C-k>", "<cmd>TmuxNavigateUp<cr>", { silent = true, desc = "Navigate Up to Tmux" })
vim.keymap.set("n", "<C-l>", "<cmd>TmuxNavigateRight<cr>", { silent = true, desc = "Navigate Right to Tmux" })
vim.keymap.set("n", "<C-\\>", "<cmd>TmuxNavigatePrevious<cr>", { silent = true, desc = "Navigate Previous to Tmux" })

-- Create an autocommand group to handle theme overrides
local custom_theme_group = vim.api.nvim_create_augroup("ThemeOverrides", { clear = true })

-- Bridge old Vim theme links to modern Neovim Tree-sitter highlight groups
vim.api.nvim_create_autocmd("ColorScheme", {
  pattern = "*",
  group = custom_theme_group,
  callback = function()

    -- Target all interface elements that control background colors
    local hl_groups = {
      "Normal",       -- Core editor window background
      "NormalNC",     -- Non-current (inactive) window backgrounds
      "NormalFloat",  -- Floating windows (popups, completions)
      "SignColumn",   -- Gutter where git signs/diagnostics live
      "LineNr",       -- Line numbers column
      "CursorLineNr", -- Current line number
      "Folded",       -- Folded text sections
    }

    for _, group in ipairs(hl_groups) do
      vim.api.nvim_set_hl(0, group, { bg = None })
    end
  end,
})

-- Now safe to activate the scheme; the autocommand above will instantly intercept it
vim.cmd("colorscheme adventurous")
