" bookmark this file, of course
nnoremap <leader>0 :tabnew $HOME/.vim/bookmarks.vim<cr>

" config files: open in new tab
nnoremap <leader>1 :tabnew $HOME/dotfiles/vimrc<cr>
nnoremap <leader>2 :tabnew $HOME/dotfiles/gvimrc<cr>
nnoremap <leader>3 :tabnew $HOME/dotfiles/tmux.conf<cr>
nnoremap <leader>4 :tabnew $HOME/dotfiles/zshrc<cr>

" bookmarked directory
nnoremap <leader>5 :FZF $HOME/dotfiles/dotvim<cr>

" current projects: open directly
nnoremap <leader>9 :e $HOME/Documents/notes_20200718.md<cr>

nnoremap <leader> :e /home/foo/Documents/notes_neovim_build.md<cr>
