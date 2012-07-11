
aug myauutocommands
  au bufread,bufnewfile .gaucherc                 setl filetype=scheme
  au bufread,bufnewfile *.scss                    setl filetype=scheme.scss
  au bufread,bufnewfile *.stub                    setl filetype=scheme.c
  au bufread,bufnewfile *.aa                      setl filetype=scheme
  au bufread,bufnewfile scheme.snip               setl filetype=snippet.scheme
  au bufread,bufnewfile *.kahua                   setl filetype=kahua.scheme
  au bufread,bufnewfile *.leh                   setl filetype=scheme
  au bufwritepost       {*.scm,*.scss}            call vimrc.scheme_bufwritepost()
  au filetype           scheme                    call vimrc.scheme()
aug END

