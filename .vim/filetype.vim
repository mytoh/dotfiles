
" my filetype file
if exists("did_load_filetypes")
  finish
endif
augroup filetypedetect
  autocmd! bufread,bufnewfile .gaucherc                 setfiletype scheme
  autocmd! bufread,bufnewfile *.scss                    setfiletype scheme.scss
  autocmd! bufread,bufnewfile *.stub                    setfiletype scheme.c
  autocmd! bufread,bufnewfile scheme.snip               setfiletype snippet.scheme
  autocmd! bufread,bufnewfile *.kahua                   setfiletype kahua.scheme
  autocmd! bufread,bufnewfile *.leh                     setfiletype scheme
  autocmd! bufread,bufnewfile *.test.scm                setfiletype scheme.test

  autocmd bufread,bufnewfile .tmux.conf                setfiletype tmux
  autocmd bufread,bufnewfile *.tmux                    setfiletype tmux
  autocmd bufread,bufnewfile *.changelog               setfiletype changelog
  autocmd bufread,bufnewfile *.twmrc                   setfiletype conf
  autocmd bufread,bufnewfile loader.conf.local         setfiletype conf
  autocmd bufread,bufnewfile .vimshrc,.vimrc.*         setfiletype vim
  autocmd bufread,bufnewfile ~/.xcolours/*             setfiletype xdefaults
  autocmd bufread,bufnewfile *.xresources.d/*           setfiletype xdefaults
  autocmd bufread,bufnewfile {*stumpwmrc*,*sawfish/rc} setfiletype lisp
  autocmd bufread,bufnewfile *.fish                    setfiletype fish
  autocmd bufread,bufnewfile *.fish-theme              setfiletype fish
  autocmd bufread,bufnewfile {*.md,*.mkd,*.markdown}   setfiletype markdown
  autocmd bufread,bufnewfile /usr/ports/UPDATING       setfiletype changelog
  autocmd bufread,bufnewfile *.mik                     setfiletype xml
  autocmd bufread,bufnewfile rc.conf.local             setfiletype sh
  autocmd bufread,bufnewfile *.mksh                    setfiletype ksh
  autocmd bufread,bufnewfile .mkshrc                   setfiletype sh
augroup END
