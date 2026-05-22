-- loaded for markdown.twiki compound filetype, after markdown.lua
vim.cmd([[
  syn region math start=/\$\$/ end=/\$\$/
  syn match  math '\$[^$].\{-}\$'
  hi link math Statement
]])
