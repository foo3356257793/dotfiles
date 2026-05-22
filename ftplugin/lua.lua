local map = vim.keymap.set

vim.opt_local.formatoptions:remove("o")

local tmux = require("tmux")
map("n", "m", function()
  vim.cmd.write()
  tmux.send('dofile("' .. vim.fn.expand("%") .. '")')
end, { buffer = true, silent = true })
