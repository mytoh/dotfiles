
" gVimでもテキストベースのタブページを使う
set guioptions-=e
colorscheme Monokai

if has('mac')
  let $PATH = $HOME . '/local/homebrew/sbin:' . $HOME . '/local/homebrew/bin:' . $PATH

  " font
  set guifontwide=Menlo:h12
  set guifont=Menlo:h12

  set guioptions-=T
  set transparency=10

  set fuoptions=maxvert,maxhorz
  au GUIEnter * set fullscreen

endif
