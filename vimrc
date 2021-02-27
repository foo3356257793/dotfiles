" General config  {{{
" Misc. Settings {{{
set nocompatible   " turns off compatibility with vi
"runtime bundle/vim-pathogen/autoload/pathogen.vim
execute pathogen#infect()
filetype plugin on
filetype indent on
set notitle
set smarttab        " in sensible.vim
set complete-=i     " in sensible.vim
"set title          " title bar of the terminal will display document title
"set number         " show line numbers
"set relativenumber
" set foldcolumn=1
" highlight FoldColumn ctermbg=None
set t_Co=256
set background=dark
"set showcmd
set hidden         " if you open new file, the old one is just 'hidden'
set ttyfast        " scrolling speed acceptable
"set ruler
set history=1000   " store lots of :cmdline history
set ignorecase     " ignore the case on searches unless...
set smartcase      " ...there is an uppercase letter in the search
if !&scrolloff
  set scrolloff=5    " keep some lines visible above and below the cursor
endif
if !&sidescrolloff
  set sidescrolloff=5
endif
syntax enable
if version >= 703
	set undofile       " saves undo history
	set undoreload=10000
endif
"syntax on          " sytax highlighting is on
set gdefault       " default replace is g (g then turns it off)
set backspace=indent,eol,start " backspace unindents
set autowrite
set autoread
set linebreak
set whichwrap+=<,>,h,l,[,]      " left and right at ends of line wrap around
set expandtab
set splitbelow     " split is now more intuitive
set splitright     " vsplit is now more intuitive
set autochdir      " automatically change to the same dir as file
set wrap " I believe this makes it so lines are wrapped
set nolist
set lazyredraw     " needed to make macros run without lag
set display+=lastline " no @ characters if line too long at bottom
set tabstop=4
set shiftwidth=4
set encoding=utf-8 " unicode
if &listchars ==# 'eol:$'
  set listchars=tab:>\ ,trail:-,extends:>,precedes:<,nbsp:+
endif
if v:version > 703 || v:version == 703 && has("patch541")
  set formatoptions+=j " Delete comment character when joining commented lines
endif
set shell=/usr/bin/zsh
set rtp+=/usr/bin/fzf "use fzf
if &tabpagemax < 50
  set tabpagemax=50
endif
set sessionoptions-=options
set viewoptions-=options
" }}}
" make space the leader {{{
let mapleader="\<Space>"
" }}}
" omnicomplete options {{{
set omnifunc=syntaxcomplete#Complete
" }}}
" search options {{{
set hlsearch
set incsearch
set showmatch
set matchtime=3 " tenths of a second to show matching parens
" }}}
" file shortcuts {{{
"nnoremap <leader>1 :tabnew $MYVIMRC<cr>
"nnoremap <leader>2 :tabnew $MYGVIMRC<cr>
" nnoremap <leader>1 :tabnew $HOME/dotfiles/vimrc<cr>
" nnoremap <leader>2 :tabnew $HOME/dotfiles/gvimrc<cr>

" Idea to do use a bookmarks file
source $HOME/.vim/bookmarks.vim
nnoremap M :let @f = expand('%:p')<cr>:tabnew $HOME/.vim/bookmarks.vim<cr>Go<cr>nnoremap <lt>leader>9 :e <esc>"fpa<lt>cr><esc>0EEs
" }}}
" Save when losing focus {{{
"augroup autosave
"	au!
"	au FocusLost * :silent! wall
"	au InsertLeave * :write
"augroup END
" }}}
" Allow mouse in terminal {{{
" set mouse=a        " allow the mouse to be used in the terminal
" vnoremap <c-C> "+y
" }}}
" line return: make sure Vim returns to the same line upon reopen {{{
augroup line_return
    au!
    au BufReadPost *
        \ if line("'\"") > 0 && line("'\"") <= line("$") |
        \     execute 'normal! g`"zvzz' |
        \ endif
augroup END
" }}}
" Backups {{{
set backup                        " enable backups
set noswapfile

set undodir=~/.vim/.tmp/undo//     " undo files
set backupdir=~/.vim/.tmp/backup// " backups
set directory=~/.vim/.tmp/swap//   " swap files

" Make those folders automatically if they don't already exist.
if !isdirectory(expand(&undodir))
	call mkdir(expand(&undodir), "p")
endif
if !isdirectory(expand(&backupdir))
	call mkdir(expand(&backupdir), "p")
endif
if !isdirectory(expand(&directory))
	call mkdir(expand(&directory), "p")
endif
" }}}
" wildmenu: displays matches on tab completion {{{
set wildmenu              " turns on the wildmenu
set wildmode=longest,list " first press expands to longest possible
													" second press brings up menu
set wildignorecase        " case insensitive tab completion
set wildignore+=*.aux,*.out,*.toc,*.pdf        " LaTeX intermediate files
set wildignore+=*.jpg,*.bmp,*.gif,*.png,*.jpeg " binary images
" }}}
" Always show the status lines {{{
set laststatus=2
"set statusline=%f\ %=\ %l\ /\ %L
set statusline=%{expand('%:p')}
" }}}
" Get rid of annoying delay with <esc>O by disabling esckeys {{{
if !has('nvim') && &ttimeoutlen == -1
  set ttimeout
  set ttimeoutlen=100
endif
" set noesckeys
" }}}
" Highlight end of line whitespace. {{{
highlight default link EndOfLineSpace ErrorMsg
match EndOfLineSpace / \+$/
" we want to turn it off in insert mode so that I don't go crazy
augroup trailing
	au!
	au InsertEnter * hi link EndOfLineSpace Normal
	au InsertLeave * hi link EndOfLineSpace ErrorMsg
augroup END
" }}}
" Up down over visual lines {{{
nnoremap j gj
nnoremap k gk
" }}}
" Rainbow parens {{{
" au VimEnter * RainbowParenthesesToggle
" au Syntax * RainbowParenthesesLoadRound    " ()
" au Syntax * RainbowParenthesesLoadSquare   " []
" au Syntax * RainbowParenthesesLoadBraces   " {}
" au Syntax * RainbowParenthesesLoadChevrons " <>
let g:rainbow_active = 1
" }}}
" Use clipboard {{{
set clipboard=unnamedplus
" }}}
" no error bells {{{
set noeb vb t_vb=
" }}}
" }}}
" General shortcuts {{{
" Make is m {{{
nnoremap m :w<cr>:!make<cr>
" }}}
" Comment boxes {{{
"vnoremap <leader>cb !perl ~/Documents/perl_stuff/comment_box.pl<cr>
"nnoremap <leader>cb Vip !perl ~/Documents/perl_stuff/comment_box.pl<cr>
" }}}
" Align equals signs {{{
"vnoremap <leader>a= !perl ~/Documents/perl_stuff/align_equals.pl<cr>
"nnoremap <leader>a= Vip!perl ~/Documents/perl_stuff/align_equals.pl<cr>
" }}}
" Omni complete is Tab {{{
" inoremap <nul> <c-n>
function! InsertTabWrapper()
    let col = col('.') - 1
    if !col || getline('.')[col - 1] !~ '\k'
        return "\<tab>"
    else
        return "\<c-p>"
    endif
endfunction

"inoremap <tab> <c-r>=InsertTabWrapper()<cr>
" }}}
" Make the arrow keys useful {{{
" function! s:swap_lines(n1, n2)
" 	let line1 = getline(a:n1)
" 	let line2 = getline(a:n2)
" 	call setline(a:n1, line2)
" 	call setline(a:n2, line1)
" endfunction
" 
" function! s:swap_up()
" 	let n = line('.')
" 	if n == 1
" 			return
" 	endif
" 
" 	call s:swap_lines(n, n - 1)
" 	exec n - 1
" endfunction
" 
" function! s:swap_down()
" 	let n = line('.')
" 	if n == line('$')
" 			return
" 	endif
" 
" 	call s:swap_lines(n, n + 1)
" 	exec n + 1
" endfunction
" 
" noremap <silent> <s-up> :call <SID>swap_up()<cr>
" noremap <silent> <s-down> :call <SID>swap_down()<cr>
" }}}
" Get rid of annoying highlighting {{{
nnoremap <leader><space> :noh<cr>
" }}}
" convert a word to all caps {{{
inoremap <c-u> <esc>vawUea
" }}}
" scroll the viewport faster {{{
nnoremap <c-e> 3<c-e>
nnoremap <c-y> 3<c-y>
" }}}
" shortcut to toggle numbering {{{
" function! g:ToggleNuMode()
" 	if(&relativenumber == 1)
" 		set number
" 	else
" 		set relativenumber
" 	endif
" endfunc

" if version >= 703
" 	nnoremap <leader>n :call g:ToggleNuMode()<cr>
" endif

nnoremap <leader>n :set invnumber<cr>

" }}}
" open split windows easy {{{

"nnoremap <leader>s <c-w>s
"nnoremap <leader>v <c-w>v

nnoremap _ <c-w>s
nnoremap \| <c-w>v

" }}}
" remove trailing whitespace {{{
nnoremap <leader>r :%s/\v\s+$//<cr>``:noh<cr>
" }}}
" Smart way to move between windows {{{
nnoremap <c-j> <c-W>j
nnoremap <c-k> <c-W>k
nnoremap <c-h> <c-W>h
nnoremap <c-l> <c-W>l

imap <c-j> <esc><c-j>
imap <c-k> <esc><c-k>
imap <c-h> <esc><c-h>
imap <c-l> <esc><c-l>
" }}}
" Autoformat text when pasting and go to end {{{
nnoremap p p=`]
nnoremap <c-p> p
nnoremap P P=`]
nnoremap <c-P> P
" }}}
" option to toggle on/off paste mode {{{
set pastetoggle=<F2>
inoremap <c-v> <c-O>:set paste<Enter><c-R>+<c-O>:set nopaste<Enter>
" }}}
" Shortcut for saving file {{{
nnoremap <leader>w  :w<cr>
" }}}
" Shortcut for resizing windows {{{
"nnoremap <silent> + :vertical resize +5<cr>
"nnoremap <silent> - :vertical resize -5<cr>
" radical solution: repurpose arrow keys
nnoremap <silent> <up> :resize +5<cr>
nnoremap <silent> <down> :resize -5<cr>
nnoremap <silent> <left> :vertical resize +5<cr>
nnoremap <silent> <right> :vertical resize -5<cr>
" }}}
" Open the previous buffer in a vertical split window {{{
"nnoremap <leader>s :execute "rightbelow vsplit " . bufname("#")<cr>
" }}}
" Align stuff with tabular {{{
vnoremap <leader>a= :Tabularize /=/<cr>
nnoremap <leader>a= :Tabularize /=/<cr>
vnoremap <leader>A= :Tabularize /\S*=\S*/<cr>gv:Tabularize /=\S*/l0l1l0<cr>
nnoremap <leader>A= :Tabularize /\S*=\S*/<cr>:Tabularize /=\S*/l0l1l0<cr>
" }}}
" Copy and paste from clipboard {{{
"vnoremap <Leader>y "+y
"vnoremap <Leader>d "+d
"onoremap <Leader>y "+y
"onoremap <Leader>d "+y
"nnoremap <Leader>p "+p
"nnoremap <Leader>P "+P
"vnoremap <Leader>p "+p
"vnoremap <Leader>P "+P
" }}}
" Headlines {{{
nnoremap <Leader>h= yypVr=
nnoremap <Leader>h- yypVr-
nnoremap <Leader>h# yypVr#
nnoremap <Leader>h* yypVr*
nnoremap <Leader>H= yyPVr=yyjp
nnoremap <Leader>H- yyPVr-yyjp
nnoremap <Leader>H# yyPVr#yyjp
nnoremap <Leader>H* yyPVr*yyjp
" }}}
" navigate tabs {{{
"nnoremap <leader>n :tabnew<CR>
"nnoremap <leader>, :tabnext<CR>
"nnoremap <leader>. :tabprevious<CR>
":set showtabline=0
"nnoremap <leader>q :wqa<cr>
" }}}
" Make Y sensible {{{
nnoremap Y y$
" }}}
" expand and split {{{
nnoremap <silent> <leader>+ :set columns=160 <CR>:vsplit<CR>
nnoremap <silent> <leader>- :set columns=80 <CR>
" }}}
" fix syntax highlighting in file {{{
nnoremap <leader>x :syntax sync fromstart<cr>
nnoremap <F10> :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<'
      \ . synIDattr(synID(line("."),col("."),0),"name") . "> lo<"
      \ . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>
" }}}
" Goyo {{{
"nnoremap <leader>f :Goyo<CR>
"nnoremap <leader>f :set columns=75<cr>
"nnoremap <leader>F :set columns=150<cr>
" }}}
" fzf {{{
"nnoremap <leader>F :FZF <cr>
"nnoremap <leader>f :cd %:p:h<cr>:Files <cr>
nnoremap <leader>f :Files <cr>
"nnoremap <leader>F :Files ~<cr>

imap <c-x><c-f> <plug>(fzf-complete-path)

nnoremap <leader>l :!$HOME/Documents/time_logger/get_tags.py \| fzf \| $HOME/Documents/time_logger/log_time.py<cr>
" }}}
" Command mode shortcuts (typo fixing) {{{
" cnoremap Q q
" }}}
" terminal mode {{{
tnoremap <C-s> <C-w>N
tnoremap <c-j> <c-W>j
tnoremap <c-k> <c-W>k
tnoremap <c-h> <c-W>h
tnoremap <c-l> <c-W>l
"nnoremap <leader>t :tabnew<CR>:ter ++curwin<CR>
"nnoremap <leader>T :vert term<CR>
" }}}
" buffer movement {{{
" pretty nice one-liner
"nnoremap <leader>b :ls<cr>:b<Space>
" fzf version
nnoremap <leader>b :Buffers<cr>
nnoremap - :bp<cr>
nnoremap + :bn<cr>
" }}}
" clipboard {{{
" use a file to pass around stuff (works)
vnoremap <leader>y "cy:call writefile(getreg('c',1,1),'/home/dad/.clipboard.txt')<cr>
noremap <leader>p :let @c = system('cat /home/dad/.clipboard.txt')<cr>"cp
" Note: alt-v in tmux also is pretty useful for pasting

" interact directly with tmux buffers (doesn't work if tmux buffers haven't
" been initialized!)
" (replace \" with ")
" vnoremap <leader>y \"cy:call system('tmux set-buffer \"' . @c . '"')<cr>
" noremap <leader>p :let @c = system('tmux show-buffer ')<cr>"cp
" }}}
" time logger {{{
augroup time_log
  au!
  au BufNewFile,BufRead time_log*yaml set ft=yaml.timelog
  au FileType yaml.timelog :nnoremap <buffer> m :!process_time_log.py %<cr>
  au FileType yaml.timelog let maplocalleader="\<Space>"
  au FileType yaml.timelog :nnoremap <buffer> <localleader>g o-<space><esc>"=strftime("%Y-%m-%d %H:%M:%S")<cr>p
augroup END
" }}}
" }}}
" ===== Perl =====  {{{
" Settings  {{{
augroup perlSettings
  au!
  au bufnewfile *.pl 0r /home/cnelson125/.vim/perl_header.txt
"   :map <up> ddkP
  au bufnewfile *.pl exe ':5'
  au FileType perl setlocal softtabstop=4|set shiftwidth=2|set expandtab
  au FileType perl setlocal autoindent|set smartindent
  au FileType perl setlocal tw=80 " good coding practice
augroup END
let perl_fold=1
" }}}
" Perl Shortcuts  {{{
augroup perlShortcuts
  au!
  au FileType perl let maplocalleader="\<Space>"
  au FileType perl :nnoremap <buffer> <localleader>= gg=G<c-o><c-o><space>
  au FileType perl :nnoremap <buffer> <localleader>cx 80A <esc>d80<bar>r#<esc><cr>
  "au FileType perl :nnoremap <buffer> <localleader>he yyp^v$r#yykPjj
  au FileType perl :onoremap <buffer> in( :<c-u>normal!f(vi(<cr>
  au FileType perl :onoremap <buffer> ip( :<c-u>normal!f(vi(<cr>
  au FileType perl :onoremap <buffer> in{ :<c-u>normal!f{vi{<cr>
  au FileType perl :onoremap <buffer> ip{ :<c-u>normal!F{vi{<cr>
  au FileType perl :inoremap <buffer> {<cr> {<cr>}<esc>O
augroup END
" }}}
" check perl code with :make  {{{
augroup perlMake
  au!
  au FileType perl setlocal makeprg=perl\ -c\ %\ $*
  au FileType perl setlocal errorformat=%f:%l:%m
  au FileType perl setlocal autowrite
  au FileType perl :noremap <buffer> <localleader>k :! perl %<cr>
  "let g:syntastic_enable_perl_checker = 1
  "let g:syntastic_perl_lib_path = [ '/usr/bin' ]
augroup END
" }}}
" }}}
" ===== tex =====  {{{
" settings  {{{
augroup texSettings
  au!
  au BufNewFile *.tex 0r ~/.vim/latex_template.tex
	au Bufread *.tex setlocal ft=tex
	au BufNewFile *.tex setlocal ft=tex
  au FileType tex setlocal tw=68 " good for readability
  au FileType tex setlocal tabstop=2|set shiftwidth=2|set softtabstop=2
  au FileType tex setlocal autoindent|set smartindent
  au FileType tex :nnoremap <buffer> <leader>a {gq}<c-o><c-o>
  "au FileType tex :setlocal spell spelllang=en_us
augroup END
" }}}
" shortcuts  {{{
augroup texShortcuts
  au!
  au FileType tex let maplocalleader="\<Space>"
  au FileType tex :nnoremap <buffer> <localleader>" viW<esc>a''<esc>hBi``<esc>lEl
  au FileType tex :inoremap <buffer> \[<cr> \[<cr>\]<esc>O
  au FileType tex :inoremap <buffer> $$<cr> $$<cr>$$<esc>O
  au FileType tex :nnoremap <buffer> <localleader>li i\begin{itemize}<cr>\end{itemize}<esc>O\item<space>
  au FileType tex :nnoremap <buffer> <localleader>le i\begin{enumerate}<cr>\end{enumerate}<esc>O\item<space>
  au FileType tex :nnoremap <buffer> <localleader>la i\begin{align*}<cr>\end{align*}<esc>O
  au FileType tex :nnoremap <buffer> <localleader>lb i\begin{bmatrix}<cr>\end{bmatrix}<esc>O
  au FileType tex :nnoremap <buffer> <localleader>ls i\section{}<esc>i
  au FileType tex :nnoremap <buffer> <localleader>lS i\subsection{}<esc>i
  au FileType tex :nnoremap <buffer> <localleader>lB i\subsubsection{}<esc>i
  au FileType tex :nnoremap <buffer> <localleader>lp i\paragraph{}<esc>i
  au FileType tex :nnoremap <buffer> go o\item<space>
  au FileType tex :nnoremap <buffer> gO O\item<space>
augroup END
" }}}
" journal should automatically put * before subsections  {{{
augroup texJournal
  au BufNewFile,Bufread ~/Dropbox/Documents/journal/*.tex :nnoremap <buffer> <localleader>d "=strftime("%B %-d, %Y")<cr>PI\subsection*{<esc>A}<enter><enter><esc>
  au BufNewFile,Bufread ~/Dropbox/Documents/journal/*.tex :nnoremap <buffer> <localleader>yd "=strftime("%B %-d, %Y")<cr>PF,h<c-x>I\subsection*{<esc>A}<enter><enter><esc>
  au BufNewFile,Bufread ~/Dropbox/Documents/journal/*.tex :nnoremap <buffer> <localleader>od "=strftime("%B %d, %Y")<cr>PF,h<c-x>I\subsection*{<esc>A}<esc>F,h
augroup END
" }}}
" synctex  {{{
"function! SyncTexForward()
"	 let execstr = "silent !okular --unique %:p:r.pdf\#src:".line(".")."%:p &"
"	 exec execstr
"endfunction
"augroup synctex
"  au!
"  au FileType tex :nnoremap <buffer> <localleader>f :call SyncTexForward()<CR>
"augroup END
" }}}
" }}}
" ===== Python ===== {{{
" Settings  {{{
function GetGooglePythonIndent(lnum)

  " Indent inside parens.
  " Align with the open paren unless it is at the end of the line.
  " E.g.
  "   open_paren_not_at_EOL(100,
  "                         (200,
  "                          300),
  "                         400)
  "   open_paren_at_EOL(
  "       100, 200, 300, 400)
  call cursor(a:lnum, 1)
  let [par_line, par_col] = searchpairpos('(\|{\|\[', '', ')\|}\|\]', 'bW',
        \ "line('.') < " . (a:lnum - s:maxoff) . " ? dummy :"
        \ . " synIDattr(synID(line('.'), col('.'), 1), 'name')"
        \ . " =~ '\\(Comment\\|String\\)$'")
  if par_line > 0
    call cursor(par_line, 1)
    if par_col != col("$") - 1
      return par_col
    endif
  endif

  " Delegate the rest to the original function.
  return GetPythonIndent(a:lnum)
  
endfunction
augroup pythonSettings
  au!
  au bufnewfile *.py 0r $HOME/.vim/python_template.py
  au bufnewfile *.py exe 'normal G'
  au bufnewfile,Bufread Sconstruct :set ft=python
  au FileType python setlocal softtabstop=4|set shiftwidth=4|set expandtab
  au FileType python setlocal autoindent|set smartindent
  au FileType python setlocal tw=80 " good coding practice
  au FileType python setlocal foldmethod=indent
  au FileType python setlocal foldlevel=99
  let g:python_target = "right"
  au FileType python :nnoremap <silent> <buffer> m :w<cr>:call system('tmux send -t ' . g:python_target . ' -X cancel')<cr>:call system('tmux send-keys -t ' . g:python_target . ' "%run ' . expand('%') . '" Enter')<cr>

  au FileType python setlocal indentexpr=GetGooglePythonIndent(v:lnum)
  au FileType python let s:maxoff = 50 " maximum number of lines to look backwards.
	au FileType python let pyindent_nested_paren="&sw*2"
  au FileType python let pyindent_open_paren="&sw*2"
augroup END
" }}}
" Python Leaders  {{{
augroup pythonShortcuts
  au!
  au FileType python let maplocalleader="\<Space>"
  au FileType python :nnoremap <buffer> <localleader>cx 80A <esc>d80<bar>r#<esc><cr>
  "au FileType python :nnoremap <buffer> <localleader>he yyp^v$r#yykPjj
augroup END
  au FileType python :nnoremap <buffer> <localleader>lt ostart_tm = time.perf_counter()<cr><cr>end_tm = time.perf_counter()<cr>tot_tm = end_tm-start_tm<cr>print("TIME = %.3lf" % tot_tm)<esc>
" }}}
" }}}
" {{{ ==== Sage ====
augroup sageSettings
  au!
  au bufnewfile *.sage,*.spyx 0r $HOME/.vim/sage_template.sage
  au bufnewfile,Bufread *.sage,*.spyx setfiletype python.sage
  " make a window with sage in it load the current file

  " default is sage pane to the right
  " change this by setting this variable
  let g:sage_target = "right"

  " function to send the correct keys
  "au FileType python :nnoremap <silent> <buffer> <leader>m :w<cr>:call system('tmux send-keys -t ' . g:sage_target . ' "load(\"' . expand('%') . '\")" Enter')<cr>
  au FileType python.sage :nnoremap <silent> <buffer> m :w<cr>:call system('tmux send -t ' . g:sage_target . ' -X cancel')<cr>:call system('tmux send-keys -t ' . g:sage_target . ' "load(\"' . expand('%') . '\")" Enter')<cr>
augroup END
" running commands in a tmux session {{{
augroup sageShell
  au!
  au FileType python :nnoremap <buffer> <localleader>T :!tmux new -d -s sage_session<CR>!tmux send-keys "sage" ENTER<cr>
  " au FileType python :nnoremap <buffer> <localleader>S :split .terminal.buffer.sage<CR>:resize 10<CR>
  " au FileType python :nnoremap <buffer> <localleader>t V:call SendToTmux()<CR><C-w>jggdG:r!tmux show-buffer<CR>?:<CR>^dG
  " au FileType python :vnoremap <buffer> <localleader>t :call SendToTmux()<CR><C-w>jggdG:r!tmux show-buffer<CR>?:<CR>^dG
augroup END
" }}}
" }}}
" ===== c =====  {{{
" Settings  {{{
augroup cSettings
  au!
  au bufnewfile *.c 0r $HOME/.vim/c_template.c
  au bufnewfile *.cpp 0r $HOME/.vim/cpp_template.cpp
  au bufnewfile *.c exe 'normal 5G'
  au bufnewfile *.cpp exe 'normal 10G'
  au bufnewfile,bufread *.cuh setlocal ft=cpp
  au FileType c,cpp setlocal softtabstop=2|set shiftwidth=2|set expandtab
  au FileType c,cpp setlocal autoindent|set smartindent
  au FileType c,cpp setlocal tw=80 " good coding practice
  au FileType c,cpp setlocal cinkeys-=0#
  au FileType c,cpp setlocal comments-=:// comments+=f://
  "let g:syntastic_c_checkers=['']
augroup END
" }}}
" c Shortcuts  {{{
augroup cShortcuts
  au!
  au FileType c,cpp let maplocalleader="\<Space>"
  au FileType c,cpp :nnoremap <buffer> <localleader>= gg=G<c-o><c-o><space>
  au FileType c,cpp :nnoremap <buffer> <localleader>cx 80A <esc>d80<bar>r#<esc><cr>
  au FileType c,cpp :onoremap <buffer> in( :<c-u>normal!f(vi(<cr>
  au FileType c,cpp :onoremap <buffer> ip( :<c-u>normal!f(vi(<cr>
  au FileType c,cpp :onoremap <buffer> in{ :<c-u>normal!f{vi{<cr>
  au FileType c,cpp :onoremap <buffer> ip{ :<c-u>normal!F{vi{<cr>
  au FileType c,cpp :inoremap <buffer> {<cr> {<cr>}<esc>O
  au FileType c,cpp :nnoremap <buffer> <localleader>d oDEBUG(<esc>"=printf("%d",line('.'))<c-M>pa,);<esc>hi
augroup END
" }}}
" }}}
" ===== go ===== {{{
augroup goSettings
  au!
  au bufnewfile *.go 0r $HOME/.vim/template.go
  au bufnewfile *.go exe 'normal 9G'
augroup END
augroup goShortcuts
  au!
  au FileType go :inoremap <buffer> {<cr> {<cr>}<esc>O
augroup END
" }}}
" ===== rust ===== {{{
augroup rustSettings
  au!
  au bufnewfile *.rs 0r $HOME/.vim/rust_template.rs
  au bufnewfile *.rs exe 'normal 2G'
  au FileType rust setlocal softtabstop=4|set shiftwidth=4|set expandtab
  au FileType rust setlocal autoindent|set smartindent
  au FileType rust setlocal tw=80 " good coding practice
  au FileType rust setlocal cinkeys-=0#
  au FileType rust setlocal comments-=:// comments+=f://
  au FileType rust :inoremap <buffer> {<cr> {<cr>}<esc>O
  au FileType rust :nnoremap <silent> <buffer> m :w<cr>:!cargo build<cr>
augroup END
" }}}
" ===== txt ======  {{{
augroup txtSettings
  au!
  au Bufread *.txt setlocal ft=txt
  au BufNewFile *.txt setlocal ft=txt
  au FileType txt setlocal tw=68 " good for readability
  au FileType txt setlocal autoindent|set softtabstop=4|set shiftwidth=4
augroup END
" }}}
" ===== vim ===== {{{
" .vim file settings
augroup filetypeVim
	au!
	au FileType vim setlocal foldmethod=marker
	au FileType vim setlocal tabstop=2|setlocal shiftwidth=2
	au FileType vim setlocal formatoptions-=r formatoptions-=o
augroup END
" }}}
" ===== csv ===== {{{
augroup csvSettings
  au!
  au bufnewfile,Bufread *.csv set ft=csv
  au FileType csv setlocal noautoindent
  au FileType csv nnoremap p p
  au FileType csv nnoremap P P
augroup END
" }}}
" ===== org ===== {{{
augroup orgSettings
  au!
  au BufRead,BufNewFile *.org setlocal ft=org
  au FileType org setlocal autoindent
  au FileType org setlocal softtabstop=2|set shiftwidth=2
  "TODO: make my own syntax file
  au FileType org set syntax=tex
  au FileType org syntax region orgHeader start="^\*" end="$"
  au FileType org syntax region orgSubheader start="^\*\*" end="$"
  au FileType org syntax region orgSubsubheader start="^\*\*\*" end="$"
  au FileType org syntax region orgBold start="\*[^\*]" end="\*" keepend oneline
  au FileType org syntax region orgItal start="\s/[^/]" end="/\s" keepend oneline
  au FileType org syntax region orgItal start="\s/[^/]" end="/$" keepend oneline
  au FileType org syntax region orgItal start="^/[^/]" end="/\s" keepend oneline
  au FileType org syntax region orgItal start="^/[^/]" end="/$" keepend oneline
  au FileType org syntax region orgMono start="=[^=]" end="=" keepend oneline
  hi orgHeader ctermfg=5
  hi orgSubheader ctermfg=3
  hi orgSubsubheader ctermfg=11
  hi orgBold ctermfg=14
  hi orgItal ctermfg=6
  hi orgMono ctermfg=4
  au FileType org,txt nnoremap <buffer> go o-<space>
  au FileType org,txt nnoremap <buffer> gO O-<space>
augroup END
" }}}
" === markdown === {{{
augroup markdownSettings
  au!
  au BufRead,BufNewFile *.md setlocal ft=markdown
  au BufRead,BufNewFile *.md :syntax sync fromstart
  au FileType markdown setlocal autoindent
  au FileType markdown setlocal softtabstop=2|set shiftwidth=2
  "au FileType markdown setlocal tw=68 " good for readability
  au FileType markdown setlocal tw=0 " seems to be bad in bulleted lists
  au FileType markdown let maplocalleader="\<Space>"
  au FileType markdown setlocal foldlevel=99
  au FileType markdown nnoremap <buffer> go o*<space>
  au FileType markdown nnoremap <buffer> gO O*<space>
  let g:markdown_fenced_languages = ['html', 'python', 'bash=sh', 'c', 'cpp', 'vim', 'yaml', 'julia']
  " fixes highlighting issue with breaking up items in a list
  au FileType markdown :syn clear markdownCodeBlock
  hi markdownH1 cterm=bold ctermbg=2 ctermfg=0
  hi markdownH1Delimiter cterm=bold ctermbg=2 ctermfg=0
  hi markdownH2 cterm=bold ctermbg=11 ctermfg=0
  hi markdownH2Delimiter cterm=bold ctermbg=11 ctermfg=0
  hi markdownH3 cterm=bold ctermbg=1 ctermfg=7
  hi markdownH3Delimiter cterm=bold ctermbg=1 ctermfg=7
  hi markdownH4 cterm=bold ctermbg=4 ctermfg=0
  hi markdownH4Delimiter cterm=bold ctermbg=4 ctermfg=0
  hi markdownItalic cterm=bold ctermfg=6
  hi markdownItalicDelimiter cterm=bold ctermfg=6
  hi markdownBold cterm=bold ctermfg=11
  hi markdownBoldDelimiter cterm=bold ctermfg=11
  hi markdownBoldItalic cterm=bold ctermfg=9
  hi markdownBoldItalicDelimiter cterm=bold ctermfg=9
  hi markdownCode ctermfg=12
  hi markdownCodeBlock ctermfg=12
  hi markdownCodeDelimiter ctermfg=12
  "hi markdownOrderedListMarker ctermfg=6
  hi markdownListMarker ctermfg=6
  hi markdownAutomaticLink ctermfg=12
  " hi markdownUrl ctermfg=10
  hi htmlTag ctermfg=15
  au FileType markdown :inoremap <buffer> $$<cr> $$<cr>$$<esc>O
  au FileType markdown :vnoremap <buffer> <localleader>k :!add_numbers_in_string.py<cr>
augroup END

" LaTeX: {{{
augroup markdownTeX
  au!
  au FileType markdown unlet b:current_syntax
  au FileType markdown syn include @LATEX syntax/tex.vim
  au FileType markdown syn region pandocLaTeXInlineMath start=/\v\\@<!\$\S@=/ end=/\v\\@<!\$\d@!/ keepend contains=@LATEX
  au FileType markdown syn region pandocLaTeXInlineMath start=/\\\@<!\\(/ end=/\\\@<!\\)/ keepend contains=@LATEX
  au FileType markdown syn match pandocEscapedDollar /\\\$/ conceal cchar=$
  au FileType markdown syn match pandocProtectedFromInlineLaTeX /\\\@<!\${.*}\(\(\s\|[[:punct:]]\)\([^$]*\|.*\(\\\$.*\)\{2}\)\n\n\|$\)\@=/ display
  au FileType markdown " contains=@LATEX
  au FileType markdown syn region pandocLaTeXMathBlock start=/\$\$/ end=/\$\$/ keepend contains=@LATEX
  au FileType markdown syn region pandocLaTeXMathBlock start=/\\\@<!\\\[/ end=/\\\@<!\\\]/ keepend contains=@LATEX
  au FileType markdown syn match pandocLaTeXCommand /\\[[:alpha:]]\+\(\({.\{-}}\)\=\(\[.\{-}\]\)\=\)*/ contains=@LATEX
  au FileType markdown syn region pandocLaTeXRegion start=/\\begin{\z(.\{-}\)}/ end=/\\end{\z1}/ keepend contains=@LATEX
  au FileType markdown " we rehighlight sectioning commands, because otherwise tex.vim captures all
  au FileType markdown " text until EOF or a new sectioning command
  au FileType markdown syn region pandocLaTexSection start=/\\\(part\|chapter\|\(sub\)\{,2}section\|\(sub\)\=paragraph\)\*\=\(\[.*\]\)\={/ end=/\}/ keepend
  au FileType markdown syn match pandocLaTexSectionCmd /\\\(part\|chapter\|\(sub\)\{,2}section\|\(sub\)\=paragraph\)/ contained containedin=pandocLaTexSection
  au FileType markdown syn match pandocLaTeXDelimiter /[[\]{}]/ contained containedin=pandocLaTexSection
augroup END
" }}}

" }}}
" === julia ==== {{{
augroup juliaSettings
  au!
  au bufnewfile *.jl 0r $HOME/.vim/julia_template.jl
  let g:julia_target = "right"
  au FileType julia :nnoremap <silent> <buffer> m :w<cr>:call system('tmux send -t ' . g:sage_target . ' -X cancel')<cr>:call system('tmux send-keys -t ' . g:julia_target . ' "include(\"' . expand('%') . '\")" Enter')<cr>

  au FileType julia let maplocalleader="\<Space>"
  au FileType julia :nnoremap <buffer> <localleader>lt ofunction TEST_XXX()<cr>@testset "TEST XXX" begin<CR>end<CR>end<esc>{=apvap:s/XXX/
  au FileType julia :nnoremap <buffer> <localleader>lf ofunction<cr>end<esc>kA<space>
augroup END
" }}}
" === Makefile === {{{
augroup makefileSettings
  au!
  au bufnewfile Makefile 0r /home/dad/.vim/Makefile_for_tex
augroup END
" }}}
" ===== abbrev =====  {{{
" use these for txt too
augroup abbreviations
  au!
  au FileType tex,txt :iabbrev <buffer> teh the
  au FileType tex,txt :iabbrev <buffer> hte the
  au FileType tex,txt :iabbrev <buffer> taht that
	au FileType tex,txt :iabbrev <buffer> htat that
  au FileType tex,txt :iabbrev <buffer> thigns things
  au FileType tex,txt :iabbrev <buffer> adn and
  au FileType tex,txt :iabbrev <buffer> waht what
  au FileType tex,txt :iabbrev <buffer> somewaht somewhat
  au FileType tex,txt :iabbrev <buffer> tehn then
  au FileType tex,txt :iabbrev <buffer> sucess success
  au FileType tex,txt :iabbrev <buffer> succes success
  au FileType tex,txt :iabbrev <buffer> sucessful successful
  au FileType tex,txt :iabbrev <buffer> succesful successful
  au FileType tex,txt :iabbrev <buffer> worte wrote
  au FileType tex,txt :iabbrev <buffer> htem them
	au FileType tex,txt :iabbrev <buffer> wsa was
	au FileType tex,txt :iabbrev <buffer> ot to
	au FileType tex,txt :iabbrev <buffer> mroe more
augroup END
" }}}
" ===== wishlist ===== {{{
" bookmarks:
"   - I map these to <leader>num currently
"   - command to pull up a list of all the bookmarks (parse this file...)
"   - write my own fzf command to manage bookmarks (or use a plugin...)
"     - call it and it lists bookmarks which are accessible
"   - keeping a tmux session open has made me use these less
" autocomplete:
"   - youcompleteme: needs npm
"   - COC: needs node
" olivetti-mode
"   - Goyo does this, but it doesn't seem as robust as olivetti mode
"   - maybe I don't need it??
" vim-markdown
"   - at home probably don't need
"   - with vim-slime (or own code??) could achieve something like a notebook in markdown?
"   - only feature which doesn't work out of the box would be images
"   - If I really wanted, could include some kind of LaTeX/html compilation to
"     make something really interesting
" }}}
" === tried, don't want === {{{
" stuff from emacs that I have tried out but I don't want here
" - vim-dispatch
"     cool, but I am happier with fullscreen make
"     or with keeping a tmux window/pane open
" - server mode?
"     don't need because opening a new Vim instance is so fast
"     tmux works nicely
" - window resize hydra
"     I redefined arrow keys to do what I want; faster than a hydra
" - zoom in text
"     this could be done:
"     https://vim.fandom.com/wiki/Change_font_size_quickly
"     don't really need it?
" - buffer move (necessary?)
"     recall that this rearranges splits
"     the built in C-w r, C-w R do window moving
" - smartparens
"     there is a plugin in to do this (autopairs)
"     I don't like it, however (is weird when I want to edit a line with
"     parens)
" - do I need surround?
"     I installed it just in case I want it later
" - vim-startify: didn't use the recently used: shifting to bookmarking
" }}}
