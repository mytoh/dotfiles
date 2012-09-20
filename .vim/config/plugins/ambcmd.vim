
" ambicmd {{{
if isdirectory(expand('$VIMBUNDLE_DIR/vim-ambicmd'))
	cnoremap <expr> <Space> ambicmd#expand("\<Space>")
	cnoremap <expr> <CR>    ambicmd#expand("\<CR>")
<
" Mapping <C-f> to <Right> with ambicmd.
>
	cnoremap <expr> <C-f> ambicmd#expand("\<Right>")
endif
" }}}
