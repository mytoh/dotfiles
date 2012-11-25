
" paredit {{{
let g:paredit_leader = '\'
let g:paredit_mode = 1

execute 'nnoremap <buffer> <silent> ' . g:paredit_leader.'t  :<C-U>call PareditToggle()<cr>'
autocmd filetype scheme call PareditInitBuffer()
" }}}
