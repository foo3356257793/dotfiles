-- ============================================================================
-- PACKAGES
-- ============================================================================

local github = function(repo)
  return "https://github.com/" .. repo
end

vim.pack.add({
  github("tpope/vim-fugitive"),
  github("godlygeek/tabular"),
  github("lervag/vimtex"),
  github("kien/rainbow_parentheses.vim"),
  github("christoomey/vim-tmux-navigator"),
  github("nvim-lua/plenary.nvim"),
  github("nvim-telescope/telescope.nvim"),
  github("folke/zen-mode.nvim"),

  {
    src     = github("averms/black-nvim"),
    version = "master",
  },
})

-- ============================================================================
-- TMUX NAVIGATOR
-- ============================================================================

vim.keymap.set("n", "<C-h>",  "<cmd>TmuxNavigateLeft<cr>",     { silent = true, desc = "Navigate left"     })
vim.keymap.set("n", "<C-j>",  "<cmd>TmuxNavigateDown<cr>",     { silent = true, desc = "Navigate down"     })
vim.keymap.set("n", "<C-k>",  "<cmd>TmuxNavigateUp<cr>",       { silent = true, desc = "Navigate up"       })
vim.keymap.set("n", "<C-l>",  "<cmd>TmuxNavigateRight<cr>",    { silent = true, desc = "Navigate right"    })
vim.keymap.set("n", "<C-\\>", "<cmd>TmuxNavigatePrevious<cr>", { silent = true, desc = "Navigate previous" })
