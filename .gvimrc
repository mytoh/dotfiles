
" gVimでもテキストベースのタブページを使う
set guioptions-=e

if has('gui_macvim')
  let $PATH = $HOME . '/local/homebrew/sbin:' . $HOME . '/local/homebrew/bin:' . $PATH
  set guifont=KonatuTohaba:h12
  set guioptions-=T
  set transparency=10
  colorscheme xoria256

  if has('gui_running')
    set fuoptions=maxvert,maxhorz
    au GUIEnter * set fullscreen
  endif

endif
