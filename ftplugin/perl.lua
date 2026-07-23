local map = vim.keymap.set

local bo = vim.bo
bo.softtabstop = 4
bo.shiftwidth  = 2
bo.expandtab   = true
bo.autoindent  = true
bo.textwidth   = 80
bo.autowrite   = true
vim.g.perl_fold = 1

local b = { buffer = true }
map("n", "<localleader>=",  "gg=G<C-o><C-o> ", b)
map("n", "<localleader>cx", [[80A <Esc>d80|r#<Esc>]], b)
map("n", "<localleader>k",  ":! perl %<CR>", b)
map("o", "in(",   [[:<C-u>normal!f(vi(<CR>]], b)
map("o", "ip(",   [[:<C-u>normal!f(vi(<CR>]], b)
map("o", "in{",   [[:<C-u>normal!f{vi{<CR>]], b)
map("o", "ip{",   [[:<C-u>normal!F{vi{<CR>]], b)
map("i", "{<CR>", "{<CR>}<Esc>O", b)
