let s:V = vital#of('vital')
let s:P = s:V.import('Prelude')


" unite{{{

let g:unite_enable_start_insert=1
let g:unite_split_rule = "belowright"
" fnamemodify() format
" :help filename-modifiers
let g:unite_source_file_mru_filename_format = ':p:~'
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
nnoremap <silent> [unite]f :<c-u>UniteWithBufferDir -buffer-name=files -prompt=%\  file file/new<CR>
nnoremap <silent> [unite]g :<c-u>Unite git<cr>
nnoremap <silent> [unite]k :<c-u>Unite bookmark<cr>
" nnoremap <silent> [unite]r :<c-u>Unite launcher<cr>
nnoremap <silent> [unite]nr :<c-u>Unite menu:repos<cr>
nnoremap <silent> [unite]m :<c-u>Unite -buffer-name=files file_mru<cr>
nnoremap <silent> [unite]o :<c-u>Unite outline<cr>
noremap  <silent> [unite]s :<c-u>Unite ack --nogroup<cr>
nnoremap <silent> [unite]t :<c-u>Unite tab<cr>
nnoremap <silent> [unite]/ :<c-u>Unite -buffer-name=search line -start-insert<CR>
" }}}
" 

augroup unite_my_settings
autocmd  FileType unite call s:unite_my_settings()
augroup end
function! s:unite_my_settings() "{{{
  " Overwrite settings.
  imap <buffer> <c-w>     <plug>(unite_delete_backward_path)
  imap <buffer> <c-j>     <plug>(unite_exit)
  imap <buffer> <localleader><localleader>  <c-u>~/
  imap <buffer> <localleader>/  <c-u>/
  imap <buffer> <localleader>rp         <c-u>~/local/repo/
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
  " substitute patterns
  call unite#set_substitute_pattern('file', '/usr'.escape($HOME, '\'), '^\~',   -2)
endfunction "}}}

" unite-menu {{{
let g:unite_source_menu_menus = {}
let g:unite_source_menu_menus.repos = {}
let g:unite_source_menu_menus.repos = {
      \     'description' : 'github repos',
      \ }
let g:unite_source_menu_menus.repos.candidates = {}
for path in s:P.globpath(expand('~/local/repo'), '*')
  let repo =  fnamemodify(path, ':t')
  let g:unite_source_menu_menus.repos.candidates[repo] = path
endfor
" let g:unite_source_menu_menus.repos.candidates = {
"       \  'dotfiles' : "$HOME/local/repo/dotfiles",
"       \  'loitsu'   : "$HOME/local/repo/loitsu",
      \ }
function! g:unite_source_menu_menus.repos.map(key, values)
  return {
        \ 'word': a:key,
        \ 'kind': 'command',
        \ 'action__command': printf('Unite file_rec/async:%s', expand(a:values))
        \}
endfunction

let g:unite_source_menu_menus.ack = {}
let g:unite_source_menu_menus.ack = {
      \     'description' : 'ack',
      \ }
let g:unite_source_menu_menus.ack = deepcopy(g:unite_source_menu_menus.repos)
function! g:unite_source_menu_menus.ack.map(key,value)
  return {
        \ 'word': a:key,
        \ 'kind': 'command',
        \ 'action__command': printf('Unite ack:%s', expand(a:value))
        \}
endfunction

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
