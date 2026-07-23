-- ============================================================================
-- PACKAGES
-- ============================================================================

local github = function(repo)
  return "https://github.com/" .. repo
end

-- Pinned to a major (or, below 1.0, a minor) range rather than left tracking
-- the default branch: the lockfile already makes installs reproducible, but it
-- pins whatever happened to be HEAD at install time. A range means an update
-- can pick up fixes without silently crossing a breaking release.
local range = vim.version.range

vim.pack.add({
  { src = github("tpope/vim-fugitive"),              version = range("3")    },
  { src = github("godlygeek/tabular"),               version = range("1")    },
  { src = github("lervag/vimtex"),                   version = range("2")    },
  { src = github("nvim-lua/plenary.nvim"),           version = range("0.1")  },
  { src = github("nvim-telescope/telescope.nvim"),   version = range("0.2")  },
  { src = github("folke/zen-mode.nvim"),             version = range("1")    },
  { src = github("HiPhish/rainbow-delimiters.nvim"), version = range("0.12") },
  { src = github("stevearc/conform.nvim"),           version = range("9")    },

  -- Branch, NOT a version range. nvim-treesitter's tags (v0.10.0 and older)
  -- all sit on the legacy master line and are not ancestors of main; a range
  -- here would quietly drag this back to the pre-rewrite API and break the
  -- setup()/install() calls below. main is unreleased and moves, so this is
  -- the one plugin where an update genuinely needs reading the changelog.
  { src = github("nvim-treesitter/nvim-treesitter"), version = "main" },
  { src = github("nvim-treesitter/nvim-treesitter-textobjects"), version = "main" },
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

    -- Folding follows the syntax tree rather than indentation. This autocmd is
    -- registered after 'filetypeplugin', so it runs *after* ftplugin/*.lua and
    -- would otherwise clobber the deliberate choices there -- python's indent
    -- folds, vim's marker folds. Claiming 'foldmethod' only while it is still
    -- "manual" leaves those alone and takes the filetypes nobody spoke for.
    for _, win in ipairs(vim.fn.win_findbuf(args.buf)) do
      if vim.wo[win].foldmethod == "manual" then
        vim.wo[win].foldmethod = "expr"
        vim.wo[win].foldexpr   = "v:lua.vim.treesitter.foldexpr()"
        -- Open files fully folded-out; zc/zM fold on demand.
        vim.wo[win].foldlevel  = 99
      end
    end
  end,
})

-- ============================================================================
-- TREESITTER TEXTOBJECTS
-- ============================================================================

-- lookahead jumps forward to the next textobject when the cursor is not inside
-- one, so `dif` works without first navigating into the function.
require("nvim-treesitter-textobjects").setup({
  select = { lookahead = true },
})

-- Queries ship for every language whitelisted for rainbow-delimiters above.
-- Coverage is not uniform: cpp has no @conditional, lua and vim have no
-- @class. A missing capture is a no-op, not an error.
local textobjects = {
  ["af"] = "@function.outer",    ["if"] = "@function.inner",
  ["ac"] = "@class.outer",       ["ic"] = "@class.inner",
  ["aa"] = "@parameter.outer",   ["ia"] = "@parameter.inner",
  ["ai"] = "@conditional.outer", ["ii"] = "@conditional.inner",
  ["al"] = "@loop.outer",        ["il"] = "@loop.inner",
}

for lhs, query in pairs(textobjects) do
  vim.keymap.set({ "x", "o" }, lhs, function()
    require("nvim-treesitter-textobjects.select").select_textobject(query, "textobjects")
  end, { silent = true, desc = "textobject " .. query })
end

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
