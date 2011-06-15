

if has('gui_macvim')
  set guifont=KohatuTohaba:h10
  set guioptions-=T
  set transparency=10
  colorscheme xoria256

  if has('gui_running')
    set fuoptions=maxvert,maxhorz
    au GUIEnter * set fullscreen
  endif

endif
