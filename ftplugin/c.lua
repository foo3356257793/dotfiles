local map = vim.keymap.set

local bo = vim.bo
bo.softtabstop = 2
bo.shiftwidth  = 2
bo.expandtab   = true
bo.autoindent  = true
bo.textwidth   = 80
vim.opt_local.cinkeys:remove("0#")

local b = { buffer = true }
map("n", "<localleader>=",  "gg=G<C-o><C-o> ", b)
map("n", "<localleader>cx", [[80A <Esc>d80|r#<Esc>]], b)
map("o", "in(",   [[:<C-u>normal!f(vi(<CR>]], b)
map("o", "ip(",   [[:<C-u>normal!f(vi(<CR>]], b)
map("o", "in{",   [[:<C-u>normal!f{vi{<CR>]], b)
map("o", "ip{",   [[:<C-u>normal!F{vi{<CR>]], b)
map("i", "{<CR>", "{<CR>}<Esc>O", b)

local tmux = require("tmux")
map("n", "M", function()
  vim.cmd.write()
  tmux.send("make")
end, vim.tbl_extend("force", b, { silent = true }))
