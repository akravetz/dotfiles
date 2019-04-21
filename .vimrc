try
  source ~/.vimrc.devoted
catch  " No such file? No problem; just ignore it.
 endtry
set nu rnu
set nowrap

let g:syntastic_mode_map = {"mode": "passive", "active_filetypes": [], "passive_filetypes": [] }

" indent/outdent
vmap < <gv
vmap > >gv
