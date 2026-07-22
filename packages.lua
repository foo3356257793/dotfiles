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
  github("HiPhish/rainbow-delimiters.nvim"),
  github("christoomey/vim-tmux-navigator"),
  github("nvim-lua/plenary.nvim"),
  github("nvim-telescope/telescope.nvim"),
  github("folke/zen-mode.nvim"),
  github("stevearc/conform.nvim"),

  {
    src     = github("nvim-treesitter/nvim-treesitter"),
    version = "main",
  },
})

-- ============================================================================
-- RAINBOW DELIMITERS
-- ============================================================================

-- Uses vim.treesitter directly, so this only needs the parsers, not
-- nvim-treesitter. Queries ship for 82 languages and every language with a
-- query is on by default, including markdown/vimdoc/latex; whitelist the code
-- languages only.
require("rainbow-delimiters.setup").setup({
  whitelist = { "c", "cpp", "go", "julia", "lua", "python", "rust", "vim" },
})

-- ============================================================================
-- TREESITTER
-- ============================================================================

require("nvim-treesitter").setup()

-- Asynchronous; parsers already present are skipped.
require("nvim-treesitter").install({
  "c", "cpp", "go", "julia", "lua", "markdown", "markdown_inline",
  "python", "rust", "vim", "vimdoc",
})

-- The main branch has no highlight/indent options: highlighting is started per
-- buffer instead, for every filetype resolving to an installed parser.
-- rainbow-delimiters also needs a live parser, so it only draws where this has
-- run. Resolving the language rather than matching on filetype keeps the
-- compound filetypes from init.lua working: sage files are "python.sage".
vim.api.nvim_create_autocmd("FileType", {
  group = vim.api.nvim_create_augroup("Treesitter", { clear = true }),
  callback = function(args)
    local lang = vim.treesitter.language.get_lang(vim.bo[args.buf].filetype)
    if not lang then return end
    -- Fails when the parser is absent or still installing.
    if not pcall(vim.treesitter.start, args.buf, lang) then return end
    vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
  end,
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
