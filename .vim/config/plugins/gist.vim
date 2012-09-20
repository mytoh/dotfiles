
" gist.vim {{{
if vimrc.P.is_mac()
  let g:gist_clip_command = 'pbcopy'
elseif vimrc.isos('freebsd')
  let g:gist_clip_command = 'xclip -selection clipboard'
endif

let g:gist_detect_filetype = 1

" show private gists with ':Gist -l'
let g:gist_show_privates = 1
"}}}
