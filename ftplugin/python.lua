local map = vim.keymap.set

local bo = vim.bo
bo.softtabstop = 4
bo.shiftwidth  = 4
bo.expandtab   = true
bo.autoindent  = true
bo.textwidth   = 80
vim.wo.foldmethod = "indent"
vim.wo.foldlevel  = 99

local tmux = require("tmux")
local b  = { buffer = true, silent = true }
local bl = { buffer = true }

map("n", "m", function()
  vim.cmd.write()
  tmux.send("%run " .. vim.fn.expand("%"))
end, b)

map("n", "<localleader>lp",
  "vap:!$HOME/.vim/py_var_to_print.py<CR>:Tabularize /=/<CR>", bl)
map("v", "<localleader>lp",
  ":!$HOME/.vim/py_var_to_print.py<CR>:Tabularize /=/<CR>", bl)
map("n", "<localleader>lt",
  "ostart_tm = time.perf_counter()<CR><CR>end_tm = time.perf_counter()<CR>" ..
  "tot_tm = end_tm-start_tm<CR>print('TIME = %.3lf' % tot_tm)<Esc>", bl)
