local map = vim.keymap.set

local tmux = require("tmux")
map("n", "m", function()
  vim.cmd.write()
  tmux.send('dofile("' .. vim.fn.expand("%") .. '")')
end, { buffer = true, silent = true })
