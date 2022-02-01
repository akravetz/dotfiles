" begin Vundle setup
set nocompatible
filetype off

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'
Plugin 'joshdick/onedark.vim'
Plugin 'itchyny/lightline.vim'
Plugin 'mengelbrecht/lightline-bufferline'

call vundle#end()
filetype plugin indent on
" end Vundle setup

syntax on
if !empty(glob("~/.vim/bundle/onedark.vim"))
  colorscheme onedark
endif
 
set nu rnu
set nowrap
set encoding=utf-8 " set utf8 encoding
set noswapfile " no swap files
set nobackup " no backup files
set nowritebackup " no writing backup  files when overwriting
set hidden " dont complain when switching buffers without saving
set background=dark " use dark background

" tab/shift+tab to switch buffers
nnoremap <Tab> :bnext<CR>
nnoremap <S-Tab> :bprevious<CR>

" file explorer shortcut
nnoremap - :Explore<CR>

let g:syntastic_mode_map = {"mode": "passive", "active_filetypes": [], "passive_filetypes": [] }

" indent/outdent
vmap < <gv
vmap > >gv
nnoremap <C-w> :bd<CR>
set laststatus=2 " use the statusline
set showtabline=2 " use the tabline for buffers
let g:lightline = {
      \ 'colorscheme': 'one',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ], [ 'readonly', 'filename', 'modified' ] ]
      \ },
      \ 'tabline': {
      \   'left': [ ['buffers'] ],
      \   'right': [ ['close'] ]
      \ },
      \ 'component_expand': {
      \   'buffers': 'lightline#bufferline#buffers'
      \ },
      \ 'component_type': {
      \   'buffers': 'tabsel'
      \ }
      \ }
