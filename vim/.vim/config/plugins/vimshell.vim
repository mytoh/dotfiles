
" vimshell {{{

let g:vimshell_user_prompt = '":: " . "(" . fnamemodify(getcwd(), ":~") . ")"'
let g:vimshell_prompt = '>> '
" let g:vimshell_right_prompt = 'vcs#info("(%s)-[%b]", "(%s)-[%b|%a]")'

"if isdirectory(expand('~/.vim/bundle/vimproc/'))
"call vimshell#set_execute_file('txt,vim,c,h,cpp,d,xml,java', 'vim')
"endif

let g:vimshell_execute_file_list = {}
for ext in split('txt,vim,c,h,cxx,d,xml,java,', ',')
  let g:vimshell_execute_file_list[ext] = 'vim'
endfor


let g:vimshell_enable_smart_case = 1
let g:vimshell_enable_auto_slash = 1
let g:vimshell_split_height = 20
" let g:vimshell_split_command = 'split'
augroup vimshell
  autocmd!
  autocmd filetype vimshell  call vimshell#hook#set('chpwd', ['s:my_chpwd'])
  autocmd filetype vimshell  call unite#custom_default_action('vimshell/history', 'insert')
  function! s:my_chpwd(args, context)
    call vimshell#execute('ls')
  endfunction
  "inoremap <buffer> <expr><silent> <C-l>  unite#sources#vimshell_history#start_complete()
  inoremap <buffer><expr> <C-l> unite#start_complete(
        \ ['vimshell/history'], {
        \ 'start_insert' : 0,
        \ 'input' : vimshell#get_cur_text()})
augroup end

" vimshell key-mappings {{{
nnoremap [vimshell] <nop>
nmap     <localleader>s [vimshell]
nmap     <silent> [vimshell]s <Plug>(vimshell_split_create)
nmap     <silent> [vimshell]c <Plug>(vimshell_create)
nnoremap <silent> [vimshell]p :<c-u>VimShellPop<cr>
nnoremap <silent> [vimshell]t :<c-u>VimShellTab<cr>
nnoremap <silent> [vimshell]v :<c-u>VimShellCreate -split -split-command='vsplit'<cr>
" }}}
"}}}
