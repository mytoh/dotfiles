
" Only do this when not done yet for this buffer
if exists("b:did_ftplugin_scheme")
  finish
endif

" Don't load another plugin for this buffer
let b:did_ftplugin_scheme = 1

setlocal lisp
setlocal cindent&
setlocal iskeyword=@,33,35-38,42-43,45-58,60-64,94,_,126,.
if executable('scmindent.scm')
if executable('racket')
setlocal equalprg=scmindent.scm
endif
endif
let g:vimshell_split_command = 'vsplit'
nnoremap <buffer><silent><LocalLeader>gi  :VimShellInteractive gosh<cr>
nnoremap <buffer><silent><LocalLeader>gs <S-v>:VimShellSendString<cr>
vmap     <buffer><silent><LocalLeader>gs :VimShellSendString<cr>
