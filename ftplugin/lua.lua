local map = vim.keymap.set

local tmux = require("tmux")
map("n", "m", function()
  vim.cmd.write()
  -- absolute: the REPL pane's cwd is independent of this instance's
  tmux.send('dofile("' .. vim.fn.expand("%:p") .. '")')
end, { buffer = true, silent = true })
