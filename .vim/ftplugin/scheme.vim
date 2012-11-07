
" Only do this when not done yet for this buffer
if exists("b:did_ftplugin_scheme")
  finish
endif

" Don't load another plugin for this buffer
let b:did_ftplugin_scheme = 1


function! s:trimspacelisp()
  " trim space for lisp file
  silent! %s/(\s\+/(/
  silent! %s/)\s\+)/))/
  silent! %s/\(\w\)\s\+\()\+\)$/\1\2/
  silent! %s/\s\+$//
  ''
endfunction

augroup ftplugin_scheme
  autocmd! 
  autocmd! bufwritepost       {*.scm,*.ss,*.sls,*sps}            call s:trimspacelisp()
augroup END

setlocal lisp
setlocal cindent&
setlocal iskeyword=@,33,35-38,42-43,45-58,60-64,94,_,126,.
if executable('scmindent.scm')
  if executable('racket')
    setlocal equalprg=scmindent.scm
  endif
endif

" paredit
let g:paredit_mode = 1

let g:vimshell_split_command = 'vsplit'

