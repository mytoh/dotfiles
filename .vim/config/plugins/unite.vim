
" unite{{{

let g:unite_enable_start_insert=1
let g:unite_split_rule = "belowright"
" fnamemodify() format
" :help filename-modifiers
let g:unite_source_file_mru_filename_format = ''
let g:unite_source_file_mru_time_format = ''
let g:unite_cursor_line_highlight = 'uniteTabLineSel'
let g:unite_source_file_mru_limit = 1000
" let g:unite_abbr_highlight = 'TabLine'
highlight uniteTabLineSel cterm=bold   ctermbg=235

" auto session loading
" let g:unite_source_session_enable_auto_save = 1
" autocmd VimEnter * UniteSessionLoad


" unite keymappings {{{
nnoremap [unite] <Nop>
nmap     <localleader>u [unite]
nnoremap <silent> [unite]a :<C-u>UniteWithBufferDir -buffer-name=files buffer file_mru bookmark file<CR>
nnoremap <silent> [unite]b :<c-u>Unite buffer<cr>
nnoremap <silent> [unite]c :<c-u>UniteWithCurrentDir -buffer-name=files buffer file file/new<CR>
nnoremap <silent> [unite]d :<c-u>Unite menu:directory<cr>
nnoremap <silent> [unite]f :<c-u>UniteWithBufferDir -buffer-name=files -prompt=%\  file file/new<CR>
nnoremap <silent> [unite]k :<c-u>Unite bookmark<cr>
" nnoremap <silent> [unite]r :<c-u>Unite launcher<cr>
nnoremap <silent> [unite]m :<c-u>Unite -buffer-name=files file_mru<cr>
nnoremap <silent> [unite]o :<c-u>Unite outline<cr>
noremap  <silent> [unite]p :<c-u>call <SID>unite_project('-start-insert')<cr>
noremap  <silent> [unite]s :<c-u>Unite ack --nogroup<cr>
nnoremap <silent> [unite]t :<c-u>Unite tab<cr>
nnoremap <silent> [unite]/ :<c-u>Unite -buffer-name=search line -start-insert<CR>
" }}}

function! s:unite_project(...)
  let opts = (a:0 ? join(a:000, ' ') : '')
  let dir  = unite#util#path2project_directory(expand('%'))
  execute 'Unite' opts 'file_rec:' . dir
endfunction

augroup unite_my_settings
autocmd  FileType unite call s:unite_my_settings()
augroup end
function! s:unite_my_settings() "{{{
  " Overwrite settings.
  imap <buffer> <c-w>     <plug>(unite_delete_backward_path)
  imap <buffer> <c-j>     <plug>(unite_exit)
  imap <buffer> <localleader><localleader>  <c-u>~/
  imap <buffer> <localleader>/  <c-u>/
  imap <buffer> <localleader>kv         <c-u>~/local/repo/panna/kirjasto/kaava/
  imap <buffer> <localleader>pk         <c-u>~/local/repo/pikkukivi/
  " <C-l>: manual neocomplcache completion.
  inoremap <buffer> <C-l>  <C-x><C-u><C-p><Down>
  imap     <buffer> <c-w> <plug>(unite_delete_backward_path)
  " vimfiler
  nnoremap <silent><buffer><expr> f unite#smart_map('f', unite#do_action('vimfiler'))
  inoremap <silent><buffer><expr> f unite#smart_map('f', unite#do_action('vimfiler'))
  call unite#custom_default_action('file', 'tabopen')
  call unite#custom_default_action('bookmark', 'tabopen')
  " call unite#custom_default_action('directory', 'tabvimfiler')
  call unite#custom_default_action('directory_mru', 'vimfiler')
endfunction "}}}

" unite-menu {{{
if !exists("g:unite_source_menu_menus")
  let g:unite_source_menu_menus = {}
endif

" menu description
let s:commands = {
      \   'description' : 'directory shortcut',
      \ }
" set commands
let s:commands.candidates = {
      \   "quatre" : "VimFiler /mnt/quatre",
      \   "deskstar" : "VimFiler /mnt/deskstar",
      \   "mypassport" : "VimFiler /mnt/mypassport",
      \ }

" register function
function s:commands.map(key, value)
  return {
        \   'word' : a:key,
        \   'kind' : 'command',
        \   'action__command' : a:value,
        \ }
endfunction

let g:unite_source_menu_menus["directory"] = deepcopy(s:commands)
unlet s:commands

" }}}

" unite-launch {{{
let g:unite_launch_apps = [
      \ 'rake',
      \ 'make',
      \ 'scss2css',
      \ 'git pull',
      \ 'git push' ]
"}}}

" unite-ack {{{
highlight UniteAck cterm=bold ctermfg=19 ctermbg=205
let g:unite_source_ack_command = 'ack --nocolor'
let g:unite_source_ack_search_word_highlight = 'UniteAck'

" }}}

"}}}
