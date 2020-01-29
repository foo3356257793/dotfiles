" General config  {{{
" Misc. Settings {{{
set nocompatible   " turns off compatibility with vi
"runtime bundle/vim-pathogen/autoload/pathogen.vim
execute pathogen#infect()
filetype plugin on
filetype indent on
"set title          " title bar of the terminal will display document title
"set number         " show line numbers
"set relativenumber
"set foldcolumn=1
"set showcmd
set hidden         " if you open new file, the old one is just 'hidden'
set ttyfast        " scrolling speed acceptable
"set ruler
set history=1000   " store lots of :cmdline history
set ignorecase     " ignore the case on searches unless...
set smartcase      " ...there is an uppercase letter in the search
set scrolloff=5    " keep some lines visible above and below the cursor
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
nnoremap <leader>1 :tabnew $MYVIMRC<cr>
nnoremap <leader>2 :tabnew $MYGVIMRC<cr>
nnoremap <leader>3 :tabnew $MYGVIMRC<cr>
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

set undodir=~/.vim/tmp/undo//     " undo files
set backupdir=~/.vim/tmp/backup// " backups
set directory=~/.vim/tmp/swap//   " swap files

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
set statusline=%f
" }}}
" Get rid of annoying delay with <esc>O by disabling esckeys {{{
set ttimeoutlen=100
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
"au Syntax * RainbowParenthesesLoadChevrons " <>
" }}}
" Use clipboard {{{
set clipboard=unnamedplus
" }}}
" }}}
" General shortcuts {{{
" Comment boxes {{{
vnoremap <leader>cb !perl ~/Documents/perl_stuff/comment_box.pl<cr>
nnoremap <leader>cb Vip !perl ~/Documents/perl_stuff/comment_box.pl<cr>
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
function! s:swap_lines(n1, n2)
	let line1 = getline(a:n1)
	let line2 = getline(a:n2)
	call setline(a:n1, line2)
	call setline(a:n2, line1)
endfunction

function! s:swap_up()
	let n = line('.')
	if n == 1
			return
	endif

	call s:swap_lines(n, n - 1)
	exec n - 1
endfunction

function! s:swap_down()
	let n = line('.')
	if n == line('$')
			return
	endif

	call s:swap_lines(n, n + 1)
	exec n + 1
endfunction

noremap <silent> <s-up> :call <SID>swap_up()<cr>
noremap <silent> <s-down> :call <SID>swap_down()<cr>
" }}}
" Rewrap a paragraph {{{
nnoremap <leader>q gwip
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
" shortcut to toggle relative line numbering {{{
function! g:ToggleNuMode()
	if(&relativenumber == 1)
		set number
	else
		set relativenumber
	endif
endfunc

if version >= 703
	"set relativenumber
	noremap <leader>n :call g:ToggleNuMode()<cr>
endif
" }}}
" open split windows easy {{{
nnoremap <leader>s <c-w>s
nnoremap <leader>v <c-w>v
" }}}
" remove trailing whitespace {{{
nnoremap <leader>r :%s/\v\s+$//<cr>``:noh<cr>
" }}}
" Smart way to move between windows {{{
nnoremap <c-j> <c-W>j
nnoremap <c-k> <c-W>k
nnoremap <c-h> <c-W>h
nnoremap <c-l> <c-W>l
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
nnoremap <silent> + :vertical resize +5<cr>
nnoremap <silent> - :vertical resize -5<cr>
" radical solution: repurpose arrow keys
nnoremap <silent> <up> :resize +5<cr>
nnoremap <silent> <down> :resize -5<cr>
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
" }}}
" cycle through buffers {{{
nnoremap <leader>b :bp<CR>
nnoremap <leader>B :bn<CR>
" }}}
" }}}
" Command mode shortcuts (typo fixing) {{{
" cnoremapd Q q
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
  au FileType perl :nnoremap <buffer> <localleader>he yyp^v$r#yykPjj
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
  au FileType perl :noremap <buffer> <localleader>m :make<cr>
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
  au FileType tex :setlocal spell spelllang=en_us
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
" check tex code with :make  {{{
augroup texMake
  au!
  " au FileType tex setlocal makeprg=xelatex\ %\ -synctex=1
  " au FileType tex setlocal errorformat=%f:%l:%m
  " au FileType tex setlocal autowrite
  " au FileType tex :noremap <buffer> <localleader>m :lcd %:p:h<cr>:make<cr>
  " set up a Makefile
  command! -nargs=* -complete=shellcmd Rsplit execute "new | r! <args>"
  au FileType tex :noremap <buffer> <localleader>m :w<cr>:!make<cr>
  "au FileType tex :noremap <buffer> <localleader>m :w<cr>:Rsplit make<cr>
augroup END
" }}}
" synctex  {{{
function! SyncTexForward()
	 let execstr = "silent !okular --unique %:p:r.pdf\#src:".line(".")."%:p &"
	 exec execstr
endfunction
augroup synctex
  au!
  au FileType tex :nnoremap <buffer> <localleader>f :call SyncTexForward()<CR>
augroup END
" }}}
" }}}
" ===== Python ===== {{{
" Settings  {{{
augroup pythonSettings
  au!
  au bufnewfile *.py 0r $HOME/.vim/python.template
  au bufnewfile *.py exe 'normal G'
  au FileType python setlocal softtabstop=4|set shiftwidth=4|set expandtab
  au FileType python setlocal autoindent|set smartindent
  au FileType python setlocal tw=80 " good coding practice
augroup END
" }}}
" Python Leaders  {{{
augroup pythonShortcuts
  au!
  au FileType python let maplocalleader="\<Space>"
  au FileType python :vnoremap <buffer> <localleader>cb !perl ~/Documents/perl_stuff/comment_box.pl<cr>
  au FileType python :nnoremap <buffer> <localleader>cx 80A <esc>d80<bar>r#<esc><cr>
  au FileType python :nnoremap <buffer> <localleader>he yyp^v$r#yykPjj
augroup END
" }}}
" check python code with :make  {{{
augroup pythonMake
  au!
  au FileType python setlocal makeprg=python\ -c\ \"import\ py_compile,sys;\ sys.stderr=sys.stdout;\ py_compile.compile(r'%')\"
set efm=%C\ %.%#,%A\ \ File\ \"%f\"\\,\ line\ %l%.%#,%Z%[%^\ ]%\\@=%m
  au FileType python setlocal errorformat=%f:%l:%m
  au FileType python setlocal autowrite
  au FileType python :noremap <buffer> <localleader>m :make<cr>
  au FileType python :noremap <buffer> <localleader>k :w<cr>:! python3 %<cr>
augroup END
" }}}
" }}}
" {{{ === Sage ===
augroup sageSettings
  au!
  au bufnewfile *.sage 0r $HOME/.vim/sage.template
  au bufnewfile,Bufread *.sage set ft=python
augroup END
" }}}
" ===== c =====  {{{
" Settings  {{{
augroup cSettings
  au!
  au bufnewfile *.c 0r /home/cnelson125/.vim/c.template
  au bufnewfile *.c exe 'normal 5G'
  au bufnewfile,bufread *.cuh setlocal ft=cpp
  au FileType c setlocal softtabstop=4|set shiftwidth=4|set expandtab
  au FileType c setlocal autoindent|set smartindent
  au FileType c setlocal tw=80 " good coding practice
  au FileType c setlocal cinkeys-=0#
  au FileType c setlocal comments-=:// comments+=f://
  "let g:syntastic_c_checkers=['']
augroup END
" }}}
" c Shortcuts  {{{
augroup cShortcuts
  au!
  au FileType c let maplocalleader="\<Space>"
  au FileType c :nnoremap <buffer> <localleader>= gg=G<c-o><c-o><space>
  au FileType c :nnoremap <buffer> <localleader>cx 80A <esc>d80<bar>r#<esc><cr>
  au FileType c :nnoremap <buffer> <localleader>he yyp^v$r#yykPjj
  au FileType c :onoremap <buffer> in( :<c-u>normal!f(vi(<cr>
  au FileType c :onoremap <buffer> ip( :<c-u>normal!f(vi(<cr>
  au FileType c :onoremap <buffer> in{ :<c-u>normal!f{vi{<cr>
  au FileType c :onoremap <buffer> ip{ :<c-u>normal!F{vi{<cr>
  au FileType c :inoremap <buffer> {<cr> {<cr>}<esc>O
augroup END
" }}}
" check c code with :make  {{{
augroup cMake
  au!
    au FileType c :nnoremap <buffer> <localleader>k :w<cr>:make clean<cr>
    au FileType c :nnoremap <buffer> <localleader>m :w<cr>:!make<cr>
  " au FileType c setlocal makeprg=c\ -c\ %\ $*
  " au FileType c setlocal errorformat=%f:%l:%m
  " au FileType c setlocal autowrite
  " au FileType c :noremap <buffer> <localleader>m :make<cr>
  " au FileType c :noremap <buffer> <localleader>k :! c %<cr>
augroup END
" }}}
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
" ===== org ===== {{{
augroup orgSettings
  au!
  syntax region orgHeader start="^\*" end = "$"
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
" folding?
" I'm fine with autocomplete?
" show what I would sub in dynamically
" zoom in text
" spacemacs theme
" olivetti-mode (I think goyo is a plugin which does this)
"   I have usually just sized the window properly (instead of maximizing)
" do I want quick system commands in a buffer? 
"   you can open a buffer and do r!cmd
" do I need surround?
"   I have always done well surrounding by hand; not sure it saves so many
"   keystrokes
" buffer hydra : don't need?
"   space-b is pretty fast (prob faster than what I'm doing in emacs)
"   :b <tab> is also a thing I didn't know about
" window resize hydra
"   I redefined arrow keys to do what I want; faster than a hydra
" buffer move (necessary?)
"   it's kind of niche, and less necessary in vim than emacs
" smartparens
"   I am not sure this really saves that many keystrokes
" opening an empty buffer does bad things: never have an empty buffer?
"   I could set a shortcut to open a fixed buffer; I don't care about this
"   issue that much though
" server mode?
"   don't need because already so fast
"   I don't really need every single buffer across workspaces
" }}}
