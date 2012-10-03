
" vimfiler"{{{
" from http://d.hatena.ne.jp/hrsh7th/20120229/1330525683

" vimfiler key-mappings {{{
nnoremap [vimfiler] <nop>
nmap     <localleader>f [vimfiler]
nnoremap <silent> [vimfiler]f :<c-u>VimFiler<cr>
nnoremap <silent> [vimfiler]t :<c-u>VimFilerTab<cr>
nnoremap <silent> [vimfiler]k :<c-u>Unite bookmark:directory<cr>
nnoremap <silent> <c-e> :VimFilerExplorer <cr>
" }}}

let g:vimfiler_as_default_explorer  = 1
let g:vimfiler_safe_mode_by_default = 0
let g:vimfiler_sort_type = "Time"
let g:vimfiler_edit_action = 'tabopen'

augroup vimfiler
  autocmd myautocommands filetype vimfiler call g:my_vimfiler_settings()
augroup end
function! g:my_vimfiler_settings() "{{{
  nmap     <buffer><expr><cr>        vimfiler#smart_cursor_map("\<plug>(vimfiler_expand_tree)", "\<plug>(vimfiler_edit_file)")
  nmap     <buffer> q         <plug>(vimfiler_exit)
  nmap     <buffer> Q         <plug>(vimfiler_hide)
  nnoremap <buffer><localleader><silent>s    :call vimfiler#mappings#do_action('my_split')<cr>
  nnoremap <buffer><localleader><silent>S    :call vimfiler#mappings#do_action('my_vsplit')<cr>
  call vimfiler#set_execute_file('mkv,mpg,mp4', 'mplayer')
  call vimfiler#set_execute_file('jpg,JPG,jpeg,png,gif,bmp,cbz,cbr,cbx', 'mplayer')
  if exists('*vimfiler#set_extensions')
    call vimfiler#set_extensions('archive', 'xz,txz,cbz,cbr,lzh,zip,gz,bz2,cab,rar,7z,tgz,tar')
  endif
endfunction "}}}

let my_vimfiler_split_action = { 'is_selectable' : 1, }
function! my_vimfiler_split_action.func(candidates)
  wincmd p
  exec 'split '. a:candidates[0].action__path
endfunction
if exists('*unite#custom_action')
  call unite#custom_action('file', 'my_split', my_vimfiler_split_action)
endif
unlet my_vimfiler_split_action

let my_vimfiler_vsplit_action = { 'is_selectable' : 1, }
function! my_vimfiler_vsplit_action.func(candidates)
  wincmd p
  exec 'vsplit '. a:candidates[0].action__path
endfunction
if exists('*unite#custom_action')
  call unite#custom_action('file', 'my_vsplit', my_vimfiler_vsplit_action)
endif
unlet my_vimfiler_vsplit_action


" }}}