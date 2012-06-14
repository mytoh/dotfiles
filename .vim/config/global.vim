
" funcs {{{
let vimrc = {}

function! vimrc.isos(name) dict
  let os = tolower(substitute(system('uname'),"\n","",""))
  return os == a:name ? 1 : 0
  unlet os
endfunction

if vimrc.isos('haiku')
  let g:loaded_vimproc = 1
  set rtp^=~/.vim/
endif

" remove trailing spaces {{{
function! vimrc.trimspace() dict
  silent! %s/\s\+$//
  ''
endfunction
" }}}

function! vimrc.trimspacelisp() dict
  " trim space for lisp file
  silent! %s/(\s\+/(/
  silent! %s/)\s\+)/))/
  ''
endfunction

" vital {{{
let vimrc.V = vital#of('vital')
let vimrc.P = vimrc.V.import('Prelude')
let vimrc.M = vimrc.V.import('Mapping')
" }}}

function! vimrc.scheme()
  setl lisp
  setl cindent&
  setl iskeyword=@,33,35-38,42-43,45-58,60-64,94,_,126
  if executable('scmindent.scm')
    if executable('racket')
      setlocal equalprg=scmindent.scm
    endif
  endif
  let g:vimshell_split_command = 'vsplit'
  nnoremap <buffer><silent><LocalLeader>gi  :VimShellInteractive gosh<cr>
  nnoremap <buffer><silent><LocalLeader>gs <S-v>:VimShellSendString<cr>
  vmap     <buffer><silent><LocalLeader>gs :VimShellSendString<cr>
endfunction

function! vimrc.scheme_bufwritepost() dict
  silent! call vimrc.trimspacelisp()
  silent! call vimrc.trimspace()
endfunction

function! vimrc.xrdb() dict
  if strlen(expand($DISPLAY))
    Silent !xrdb -remove
    Silent !xrdb -merge ~/.Xresources
  endif
endfunction

" }}}
