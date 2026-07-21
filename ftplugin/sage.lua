-- loaded for python.sage compound filetype, after python.lua
local map = vim.keymap.set

local tmux = require("tmux")
local b  = { buffer = true, silent = true }
local bl = { buffer = true }

map("n", "m", function()
  vim.cmd.write()
  -- absolute: the REPL pane's cwd is independent of this instance's
  tmux.send('load("' .. vim.fn.expand("%:p") .. '")')
end, b)

map("n", "<localleader>lp",
  "vap:!$HOME/.vim/py_var_to_print.py<CR>:Tabularize /=/<CR>", bl)
map("v", "<localleader>lp",
  ":!$HOME/.vim/py_var_to_print.py<CR>:Tabularize /=/<CR>", bl)
