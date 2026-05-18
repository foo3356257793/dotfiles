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
