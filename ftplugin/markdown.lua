local map = vim.keymap.set

local bo = vim.bo
bo.softtabstop = 2
bo.shiftwidth  = 2
bo.textwidth   = 0
vim.wo.foldlevel = 99

vim.cmd([[
  syntax region markdownH1Line start="^#"      end="$"
  syntax region markdownH2Line start="^##"     end="$"
  syntax region markdownH3Line start="^###"    end="$"
  syntax region markdownH4Line start="^####"   end="$"
  syntax region markdownH5Line start="^#####"  end="$"
  syntax region markdownH6Line start="^######" end="$"
  hi markdownH1Line cterm=bold ctermbg=2  ctermfg=0
  hi markdownH2Line cterm=bold ctermbg=11 ctermfg=0
  hi markdownH3Line cterm=bold ctermbg=1  ctermfg=7
  hi markdownH4Line cterm=bold ctermfg=2
  hi markdownH5Line cterm=bold ctermfg=11
  hi markdownH6Line cterm=bold ctermfg=1
]])

local b = { buffer = true }
map("n", "go",         "o* ", b)
map("n", "gO",         "O* ", b)
map("i", "$$<CR>",     "$$<CR>$$<Esc>O", b)
map("n", "<leader>lc", "o```python<CR>```<Esc>O", b)
map("n", "<localleader>lp",
  "vap:!$HOME/.vim/py_var_to_print.py<CR>:Tabularize /=/<CR>", b)
map("v", "<localleader>lp",
  ":!$HOME/.vim/py_var_to_print.py<CR>:Tabularize /=/<CR>", b)

local tmux = require("tmux")
map("n", "<leader>m", function()
  vim.cmd.write()
  tmux.send('codeblock_eval("' .. vim.fn.expand("%") .. '",' .. vim.fn.line(".") .. ')')
end, vim.tbl_extend("force", b, { silent = true }))
map("n", "<leader>M", function()
  vim.cmd.write()
  tmux.send('codeblock_eval("' .. vim.fn.expand("%") .. '")')
end, vim.tbl_extend("force", b, { silent = true }))
