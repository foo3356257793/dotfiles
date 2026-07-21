local map = vim.keymap.set

vim.opt_local.formatoptions:remove("o")

local tmux = require("tmux")
map("n", "m", function()
  vim.cmd.write()
  -- absolute: the REPL pane's cwd is independent of this instance's
  tmux.send('dofile("' .. vim.fn.expand("%:p") .. '")')
end, { buffer = true, silent = true })
