
" paredit {{{
let g:paredit_leader = '\'
let g:paredit_mode = 1

command! PEtoggle call PareditToggle()
autocmd filetype scheme call PareditInitBuffer()
" }}}
