local map = vim.keymap.set

local bo = vim.bo
bo.autoindent  = true
bo.softtabstop = 2
bo.shiftwidth  = 2

vim.cmd("set syntax=tex")
vim.cmd([[
  syntax region orgHeader    start="^\*"     end="$"
  syntax region orgSubheader start="^\*\*"   end="$"
  syntax region orgSubsub    start="^\*\*\*" end="$"
  syntax region orgBold      start="\*[^\*]" end="\*"  keepend oneline
  syntax region orgItal      start="\s/[^/]" end="/\s" keepend oneline
  syntax region orgItal      start="\s/[^/]" end="/$"  keepend oneline
  syntax region orgItal      start="^/[^/]"  end="/\s" keepend oneline
  syntax region orgItal      start="^/[^/]"  end="/$"  keepend oneline
  syntax region orgMono      start="=[^=]"   end="="   keepend oneline
  hi orgHeader    ctermfg=5
  hi orgSubheader ctermfg=3
  hi orgSubsub    ctermfg=11
  hi orgBold      ctermfg=14
  hi orgItal      ctermfg=6
  hi orgMono      ctermfg=4
]])

map("n", "go", "o- ", { buffer = true })
map("n", "gO", "O- ", { buffer = true })
