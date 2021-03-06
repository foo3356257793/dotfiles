:set guioptions-=m  "remove menu bar
:set guioptions-=T  "remove toolbar
:set guioptions-=r  "remove right-hand scroll bar
:set guioptions-=L  "remove left-hand scroll bar

set foldcolumn=1
augroup foldcolumn
    au!
    autocmd Colorscheme * highlight FoldColumn guifg=bg guibg=bg
augroup END

set background=light
colorscheme solarized
"colorscheme fairyfloss
"colorscheme gruvbox

set lines=40 columns=80

nnoremap <leader>t1 :set background=light<cr>:colorscheme solarized<cr>
nnoremap <leader>t2 :set background=dark<cr>:colorscheme solarized<cr>
nnoremap <leader>t3 :set background=light<cr>:colorscheme PaperColor<cr>
nnoremap <leader>t4 :colorscheme C64<cr>
nnoremap <leader>t5 :set background=light<cr>:colorscheme gruvbox<cr>
nnoremap <leader>t6 :colorscheme fairyfloss<cr>
nnoremap <leader>t7 :colorscheme badwolf<cr>

"colorscheme badwolf

":set guifont=Monospace\ 14
":set guifont=Inconsolata\ 16
"set guifont=Cousine\ 14
set guifont=JetBrains\ Mono\ 14

set vb t_vb=
