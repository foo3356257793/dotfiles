" carry over config files from vim
set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath
source ~/.vimrc

" bookmark to this file
" settings that are specific to nvim only

nnoremap <leader>h :tabprevious<cr>

" markdown {{{
au FileType markdown syntax region markdownH1Line start="^#" end="$"
au FileType markdown syntax region markdownH2Line start="^##" end="$"
au FileType markdown syntax region markdownH3Line start="^###" end="$"
au FileType markdown syntax region markdownH4Line start="^####" end="$"
au FileType markdown syntax region markdownH5Line start="^#####" end="$"
au FileType markdown syntax region markdownH6Line start="^######" end="$"
hi markdownH1Line cterm=bold ctermbg=2 ctermfg=0
hi markdownH2Line cterm=bold ctermbg=11 ctermfg=0
hi markdownH3Line cterm=bold ctermbg=1 ctermfg=7
hi markdownH4Line cterm=bold ctermfg=2 ctermbg=none
hi markdownH5Line cterm=bold ctermfg=11 ctermbg=none
hi markdownH6Line cterm=bold ctermfg=1 ctermbg=none
" }}}

" " vim-plug {{{
" " have to call :PlugInstall to install the plugins
" call plug#begin(stdpath('data') . '/plugged')
" 
" :Plug 'neovim/nvim-lsp'
" :Plug 'neovim/nvim-lspconfig'
" :Plug 'nvim-lua/completion-nvim'
" 
" call plug#end()
" " }}}

" python language server {{{

" :lua << END
" require'lspconfig'.pyls.setup{on_attach=require'completion'.on_attach}
" END

" :lua << END
" require'lspconfig'.pyls.setup{}
" END

" " completion-nvim settings
" :inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
" :inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
" 
" " Set completeopt to have a better completion experience
" set completeopt=menuone,noinsert,noselect
" 
" " Avoid showing message extra message when using completion
" set shortmess+=c

" nnoremap <silent> gd    <cmd>lua vim.lsp.buf.declaration()<CR>
" nnoremap <silent> <c-]> <cmd>lua vim.lsp.buf.definition()<CR>
" nnoremap <silent> K     <cmd>lua vim.lsp.buf.hover()<CR>
" nnoremap <silent> gD    <cmd>lua vim.lsp.buf.implementation()<CR>
" nnoremap <silent> <c-k> <cmd>lua vim.lsp.buf.signature_help()<CR>
" nnoremap <silent> 1gD   <cmd>lua vim.lsp.buf.type_definition()<CR>
" nnoremap <silent> gr    <cmd>lua vim.lsp.buf.references()<CR>
" nnoremap <silent> g0    <cmd>lua vim.lsp.buf.document_symbol()<CR>
" nnoremap <silent> gW    <cmd>lua vim.lsp.buf.workspace_symbol()<CR>

" }}}


" TODO {{{
" vim-highlightedyank
"
" if has("nvim")
"   set termguicolors
" else
"   set t_Co=256
" endif

" autocomplete
" live preview of markdown
" rainbow parens
" nvim gui?
" nvim to replace tmux?
"   - better tmux copy and paste would fix this
"   - there are plugins to make nvim work well
" }}}
