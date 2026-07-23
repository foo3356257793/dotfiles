-- ============================================================================
-- LSP
-- ============================================================================

-- Server definitions live in dotfiles/lsp/*.lua, symlinked to
-- ~/.config/nvim/lsp/ so they land on the runtimepath, which is where
-- vim.lsp.enable() looks them up.  This file is the other half: which of them
-- to turn on, and how they behave once attached.

-- ============================================================================
-- ENABLE
-- ============================================================================

-- The servers are NOT installed by anything here; each machine gets them by
-- hand.  On Ubuntu that is apt for clangd, gopls and texlab, npm for pyright,
-- and the upstream release tarballs for rust-analyzer and lua-language-server
-- (neither is packaged).
--
-- A missing binary fails completely silently -- no error, no message, no
-- client, just nothing happening.  :checkhealth vim.lsp is the way to see it:
-- it lists every enabled configuration and reports
--   '<cmd>' is not executable. Configuration will not be used.
-- Run it first whenever LSP "isn't working".

vim.lsp.enable({
  "clangd",
  "gopls",
  "lua_ls",
  "pyright",
  "rust_analyzer",
  "texlab",
})

-- ============================================================================
-- DIAGNOSTICS
-- ============================================================================

-- Defaults otherwise: signs and underline, nothing inline.  Read the message
-- under the cursor with <C-w>d, walk them with [d and ]d.
--
-- severity_sort makes a line holding both an error and a hint show the error.
vim.diagnostic.config({ severity_sort = true })

-- 'signcolumn' defaults to "auto", which appears the moment a diagnostic
-- arrives and vanishes when it clears, shifting the text sideways under you.
-- One permanently reserved column is cheaper than that.
vim.o.signcolumn = "yes"

-- ============================================================================
-- COMPLETION
-- ============================================================================

-- menuone so the popup still appears when there is exactly one match.
--
-- Deliberately NOT adding noselect, which :help lsp-completion suggests: it
-- would also change how the existing <Tab> keyword completion in init.lua
-- feels in every buffer, LSP or not.
vim.opt.completeopt:append("menuone")

-- ============================================================================
-- ATTACH
-- ============================================================================

vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("Lsp", { clear = true }),
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if not client then return end

    -- vim.lsp sets 'formatexpr' on attach, which quietly redefines gq: in a
    -- buffer served by clangd or lua_ls it stops rewrapping the paragraph to
    -- 'textwidth' and asks the server to reformat the range instead -- but
    -- only for servers that support rangeFormatting, so gq would mean one
    -- thing in C and another in Python.  Hand gq back its usual meaning;
    -- <leader>cf (conform, falling back to LSP) is the format key.
    vim.bo[args.buf].formatexpr = ""

    -- Completion through <C-x><C-o>, which vim.lsp wires to 'omnifunc' on
    -- attach, and through <Tab> via the mapping in init.lua.  No autotrigger:
    -- the popup appears when asked for, not while typing.
    if client:supports_method("textDocument/completion") then
      vim.lsp.completion.enable(true, client.id, args.buf)
    end
  end,
})

-- ============================================================================
-- KEYMAPS
-- ============================================================================

-- Neovim already binds the LSP verbs, and those defaults are kept as-is:
--
--   grn        rename                     K       hover
--   gra        code action (n and v)      CTRL-]  definition (via 'tagfunc')
--   grx        run codelens               i_CTRL-S signature help
--   <C-w>d     diagnostics under cursor   [d ]d   previous/next diagnostic
--
-- Only the ones that produce a *list* are repointed, at Telescope, so LSP
-- results are browsed the same way as <leader>b, <leader>f and <leader>/
-- rather than in a bare quickfix window.
--
-- These are global rather than set on attach, which matters for gO: the tex,
-- markdown, org and txt ftplugins map gO buffer-locally to open an \item or a
-- list bullet, and help and man buffers map it to their own table of
-- contents.  A buffer-local mapping beats a global one, so all of those keep
-- working; setting these on LspAttach would instead clobber them, since
-- attachment happens after the ftplugin has run.  The cost is that gO in a
-- tex buffer inserts \item and never reaches texlab's document symbols --
-- vimtex's :VimtexTocOpen is the better outline there anyway.

local builtin = function(picker)
  return function() require("telescope.builtin")[picker]() end
end

local map = vim.keymap.set

map("n", "grr", builtin("lsp_references"),       { desc = "LSP references" })
map("n", "gri", builtin("lsp_implementations"),  { desc = "LSP implementations" })
map("n", "grt", builtin("lsp_type_definitions"), { desc = "LSP type definitions" })
map("n", "gO",  builtin("lsp_document_symbols"), { desc = "LSP document symbols" })
