
" ambicmd {{{
if neobundle#is_installed('vim-ambicmd')
  cnoremap <expr> <Space> ambicmd#expand("\<Space>")
  cnoremap <expr> <CR>    ambicmd#expand("\<CR>")
<
" Mapping <C-f> to <Right> with ambicmd.
>
  cnoremap <expr> <C-f> ambicmd#expand("\<Right>")
endif
" }}}
