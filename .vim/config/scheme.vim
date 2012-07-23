
augroup myauutocommands
  autocmd bufread,bufnewfile .gaucherc                 setlocal filetype=scheme
  autocmd bufread,bufnewfile *.scss                    setlocal filetype=scheme.scss
  autocmd bufread,bufnewfile *.stub                    setlocal filetype=scheme.c
  autocmd bufread,bufnewfile *.aa                      setlocal filetype=scheme
  autocmd bufread,bufnewfile scheme.snip               setlocal filetype=snippet.scheme
  autocmd bufread,bufnewfile *.kahua                   setlocal filetype=kahua.scheme
  autocmd bufread,bufnewfile *.leh                     setlocal filetype=scheme
  autocmd bufwritepost       {*.scm,*.scss}            call vimrc.scheme_bufwritepost()
  autocmd filetype           scheme                    call vimrc.scheme()
augroup END

