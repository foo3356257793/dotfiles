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

-- ============================================================================
-- TREESITTER
-- ============================================================================

require("nvim-treesitter.configs").setup({
  ensure_installed = {
    "c", "cpp", "go", "julia", "lua", "markdown", "markdown_inline",
    "python", "rust", "vim", "vimdoc",
  },
  highlight = { enable = true },
  indent    = { enable = true },
})

-- ============================================================================
-- TELESCOPE
-- ============================================================================

require("telescope").setup()

-- ============================================================================
-- CONFORM
-- ============================================================================

require("conform").setup({
  formatters_by_ft = {
    python = { "black" },
    lua    = { "stylua" },
  },
})

vim.keymap.set({ "n", "v" }, "<leader>cf",
  function() require("conform").format({ async = true, lsp_fallback = true }) end,
  { desc = "Format buffer" })

-- ============================================================================
-- LSP
-- ============================================================================

-- Requires the respective language servers to be installed on the system:
--   clangd, gopls, lua-language-server, pyright, rust-analyzer
vim.lsp.enable("clangd")
vim.lsp.enable("gopls")
vim.lsp.enable("lua_ls")
vim.lsp.enable("pyright")
vim.lsp.enable("rust_analyzer")
