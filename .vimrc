try
  source ~/.vimrc.devoted
catch 
  " No such file? No problem; just ignore it.
endtry

" begin Vundle setup
set nocompatible
filetype off

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'
Plugin 'joshdick/onedark.vim'

call vundle#end()
filetype plugin indent on
" end Vundle setup

syntax on
if !empty(glob("~/.vim/bundle/onedark.vim"))
  colorscheme onedark
endif
 
set nu rnu
set nowrap

let g:syntastic_mode_map = {"mode": "passive", "active_filetypes": [], "passive_filetypes": [] }

" indent/outdent
vmap < <gv
vmap > >gv
nnoremap <C-w> :bd<CR>
