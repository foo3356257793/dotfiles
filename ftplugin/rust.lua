local map = vim.keymap.set

local bo = vim.bo
bo.softtabstop = 4
bo.shiftwidth  = 4
bo.expandtab   = true
bo.autoindent  = true
bo.textwidth   = 80

local b = { buffer = true, silent = true }
map("n", "m",     ":w<CR>:!cargo build<CR>", b)
map("i", "{<CR>", "{<CR>}<Esc>O", b)
