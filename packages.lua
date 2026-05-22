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
  github("Dru89/vim-adventurous"),

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
-- COLORSCHEME
-- ============================================================================

local theme_group = vim.api.nvim_create_augroup("ThemeOverrides", { clear = true })

vim.api.nvim_create_autocmd("ColorScheme", {
  group    = theme_group,
  pattern  = "*",
  callback = function()
    local groups = {
      "Normal", "NormalNC", "NormalFloat",
      "SignColumn", "LineNr", "CursorLineNr",
      "Folded",
    }
    for _, group in ipairs(groups) do
      vim.api.nvim_set_hl(0, group, { bg = "NONE" })
    end
  end,
})

vim.cmd("colorscheme adventurous")
