
" open-browser {{{
let g:netrw_nogx = 1
nmap gx <Plug>(openbrowser-smart-search)
vmap gx <Plug>(openbrowser-smart-search)
let g:openbrowser_open_rules = { 'w3m': '{browser} {shellescape(uri)} ', }
" }}}
