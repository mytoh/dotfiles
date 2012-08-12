"                      __                          __   ___
"                     /\ \                        /\ \ /\_ \
"   ___      __    ___\ \ \____  __  __    ___    \_\ \\//\ \      __
" /' _ `\  /'__`\ / __`\ \ '__`\/\ \/\ \ /' _ `\  /'_` \ \ \ \   /'__`\
" /\ \/\ \/\  __//\ \L\ \ \ \L\ \ \ \_\ \/\ \/\ \/\ \L\ \ \_\ \_/\  __/
" \ \_\ \_\ \____\ \____/\ \_,__/\ \____/\ \_\ \_\ \___,_\/\____\ \____\
"  \/_/\/_/\/____/\/___/  \/___/  \/___/  \/_/\/_/\/__,_ /\/____/\/____/
"

set shell=sh

let $VIMBUNDLE_DIR=$HOME."/.bundle"
if !isdirectory($VIMBUNDLE_DIR."/neobundle.vim")
  call mkdir($VIMBUNDLE_DIR, "p")
else

  if has('vim_starting')
    set runtimepath^=$HOME/.bundle/neobundle.vim
    filetype off
    call neobundle#rc(expand('$HOME/.bundle'))
  endif

  NeoBundle 'Shougo/neobundle.vim'

  " my bundles here {{{
  "
  " github repo {{{
  NeoBundle 'Shougo/neocomplcache'
  NeoBundle 'Shougo/neocomplcache-snippets-complete'
  NeoBundle 'Shougo/vimfiler'
  NeoBundle 'Shougo/vimproc'
  NeoBundle 'Shougo/vimshell'
  NeoBundle 'Shougo/vinarise'
  NeoBundle 'Shougo/echodoc'
  NeoBundle 'koron/nyancat-vim'
  NeoBundle 'koron/chalice'
  " NeoBundle 'koron/homoo-vim'
  " NeoBundle 'koron/u-nya-vim'
  NeoBundle 'lilydjwg/colorizer'
  NeoBundle 'mattn/googlereader-vim'
  NeoBundle 'mattn/lisper-vim'
  NeoBundle 'mattn/webapi-vim'
  NeoBundle 'mattn/wwwrenderer-vim'
  NeoBundle 'mattn/learn-vimscript'
  NeoBundle 'mattn/hahhah-vim'
  NeoBundle 'mattn/gist-vim'
  NeoBundle 'mattn/sonictemplate-vim'
  NeoBundle 'mattn/togetter-vim'
  " NeoBundle 'rson/vim-bufstat'
  NeoBundle 'scrooloose/syntastic'
  NeoBundle 'scrooloose/nerdcommenter'
  NeoBundle 'thinca/vim-quickrun'
  NeoBundle 'thinca/vim-ref'
  NeoBundle 'thinca/vim-ambicmd'
  NeoBundle 'thinca/vim-openbuf'
  NeoBundle 'thinca/vim-singleton'
  NeoBundle 'thinca/vim-poslist'
  NeoBundle 'thinca/vim-qfreplace'
  NeoBundle 'thinca/vim-editvar'
  NeoBundle 'tpope/vim-fugitive'
  NeoBundle 'tpope/vim-surround'
  NeoBundle 'tpope/vim-afterimage'
  NeoBundle 'tpope/vim-markdown'
  NeoBundle 'tpope/vim-unimpaired'
  NeoBundle 'tpope/vim-repeat'
  "dont map <cr> if install vim-endwise
  " NeoBundle 'tpope/vim-endwise'
  NeoBundle 'tyru/eskk.vim'
  NeoBundle 'tyru/skkdict.vim'
  NeoBundle 'tyru/open-browser.vim'
  NeoBundle 'tyru/savemap.vim'
  " NeoBundle 'tyru/vice.vim'
  NeoBundle 'tyru/current-func-info.vim'
  NeoBundle 'tyru/caw.vim'
  NeoBundle 'ujihisa/neco-look'
  NeoBundle 'ujihisa/vimshell-ssh'
  NeoBundle 'mfumi/mpc.vim'
  NeoBundle 'mileszs/ack.vim'
  NeoBundle 'trapd00r/vim-extendedcolors'
  NeoBundle 'groenewege/vim-less'
  NeoBundle 'othree/html5.vim'
  NeoBundle 'gregsexton/MatchTag'
  NeoBundle 'djjcast/mirodark'
  NeoBundle 'houtsnip/vim-emacscommandline'
  NeoBundle 'acustodioo/vim-cmdline-completion'
  NeoBundle 'acustodioo/vim-enter-indent'
  NeoBundle 'h1mesuke/vim-alignta'
  NeoBundle 'baskerville/bubblegum'
  NeoBundle 'basyura/twibill.vim'
  NeoBundle 'basyura/bitly.vim'
  NeoBundle 'basyura/TweetVim'
  NeoBundle 'nathanaelkane/vim-indent-guides'
  " NeoBundle 'haruyama/scheme.vim'
  NeoBundle 'mytoh/scheme.vim'
  NeoBundle 'Lokaltog/vim-easymotion'
  " NeoBundle 'Lokaltog/vim-powerline'
  NeoBundle 'kien/rainbow_parentheses.vim'
  NeoBundle 'kergoth/fish.vim'
  NeoBundle 'kana/vim-textobj-user'
  NeoBundle 'kana/vim-textobj-line'
  NeoBundle 'kana/vim-smartinput'
  NeoBundle 'kana/vim-smartchr'
  NeoBundle 'kana/vim-scratch'
  NeoBundle 'kana/vim-tabpagecd'
  NeoBundle 'kana/vim-operator-user'
  NeoBundle 'kana/vim-operator-replace'
  " NeoBundle 'Raimondi/delimitMate'
  NeoBundle 'hobbestigrou/Vim-wmfs'
  NeoBundle 'aharisu/Gauche-Complete'
  NeoBundle 'bronson/vim-trailing-whitespace'
  NeoBundle 'chrisbra/SudoEdit.vim'
  NeoBundle 'yuratomo/w3m.vim'
  NeoBundle 'tsukkee/lingr-vim'
  NeoBundle 'xolox/vim-reload'
  NeoBundle 'gmarik/github-search.vim'
  NeoBundle 'gregsexton/gitv'
  NeoBundle 'jpalardy/vim-slime'
  NeoBundle 'godlygeek/tabular'
  NeoBundle 'sjl/gundo.vim'
  NeoBundle 'vim-jp/vital.vim'
  NeoBundle 'vim-jp/cpp-vim'
  NeoBundle 'Twinside/vim-codeoverview'
  NeoBundle 'vim2ansi'
  NeoBundle 'majutsushi/tagbar'
  NeoBundle 'nefo-mi/nyan-modoki.vim'
  NeoBundle 'coderifous/textobj-word-column.vim'
  " NeoBundle 'anekos/runes-vim'
  "unite
  NeoBundle     'Shougo/unite.vim'
  NeoBundle 'hakobe/unite-script'
  NeoBundle 'choplin/unite-vim_hacks'
  NeoBundle 'mattn/unite-remotefile'
  NeoBundle 'tyru/unite-cmdwin'
  NeoBundle 'ujihisa/unite-colorscheme'
  NeoBundle 'ujihisa/unite-launch'
  NeoBundle 'mfumi/unite-mpc'
  NeoBundle 'h1mesuke/unite-outline'
  NeoBundle 'taka84u9/unite-git'
  NeoBundle 'shiracha/unite-related_files'
  NeoBundle 'osyo-manga/unite-homo'
  NeoBundle 'osyo-manga/unite-u-nya-'
  NeoBundle 'tsukkee/unite-tag'
  NeoBundle 'Sixeight/unite-grep'
  NeoBundle 'pasela/unite-webcolorname'
  NeoBundle 'tsukkee/unite-help'
  NeoBundle 't9md/vim-unite-ack'
  NeoBundle 'Shougo/unite-ssh'
  " syntax
  "c
  NeoBundle 'cg433n/better-c'
  "lisp
  NeoBundle 'emezeske/paredit.vim'
  NeoBundle 'aharisu/vim_goshrepl'
  " clojure
  " NeoBundle 'https://bitbucket.org/kotarak/vimclojure'
  NeoBundle 'VimClojure'
  "haskell
  " NeoBundle 'Twinside/vim-haskellConceal'
  NeoBundle 'Twinside/vim-syntax-haskell-cabal'
  NeoBundle 'zenzike/vim-haskell-unicode'
  NeoBundle 'haskell.vim'
  NeoBundle 'lukerandall/haskellmode-vim'
  NeoBundle 'kana/vim-filetype-haskell'
  NeoBundle 'eagletmt/ghcmod-vim'
  NeoBundle 'ujihisa/neco-ghc'
  NeoBundle 'dag/vim2hs'
  "javascript
  NeoBundle 'jelera/vim-javascript-syntax'
  NeoBundle 'teramako/jscomplete-vim'
  " css
  NeoBundle 'hail2u/vim-css3-syntax'
  NeoBundle 'skammer/vim-css-color'
  " svg
  NeoBundle 'svg.vim'
  " rst
  NeoBundle 'Rykka/riv.vim'
  " markdow
  NeoBundle 'hallison/vim-markdown'
  " obj-c
  NeoBundle 'msanders/cocoa.vim'
  " supercollider
  NeoBundle 'sbl/scvim'
  " colorscheme {{{
  NeoBundle 'altercation/vim-colors-solarized'
  NeoBundle 'jelera/vim-gummybears-colorscheme'
  NeoBundle 'shawncplus/skittles_berry'
  NeoBundle 'jnurmine/Zenburn'
  NeoBundle 'jpo/vim-railscasts-theme'
  NeoBundle 'trapd00r/neverland-vim-theme'
  NeoBundle 'lorry-lee/vim-ayumi'
  NeoBundle 'chriskempson/vim-tomorrow-theme'
  NeoBundle 'sjl/badwolf'
  NeoBundle 'nanotech/jellybeans.vim'
  NeoBundle 'xoria256.vim'
  NeoBundle 'wombat256.vim'
  NeoBundle 'void'
  NeoBundle 'tomasr/molokai'
  NeoBundle 'robokai'
  NeoBundle 'lilypink'
  NeoBundle 'Sorcerer'
  NeoBundle 'highlights-for-radiologist'
  NeoBundle 'Gentooish'
  NeoBundle '256-jungle'
  NeoBundle 'desert256.vim'
  NeoBundle 'git://gist.github.com/187578.git' " <- h2u_black
  NeoBundle 'tristen/superman' " <- h2u_black
  "}}}
  " NeoBundle 'http://voikko.svn.sourceforge.net/svnroot/voikko/', {'type' : 'svn', 'rtp' : 'trunk/tools/vim'}
  " bitbucket
  " NeoBundle 'https://bitbucket.org/kovisoft/slimv'
  " }}}

  " official vim-scripts repo {{{
  NeoBundle 'info.vim'
  NeoBundle 'eregex.vim'
  NeoBundle 'sudo.vim'
  NeoBundle 'fluxbox.vim'
  NeoBundle 'matchit.zip'
  NeoBundle 'daemon_saver.vim'
  NeoBundle 'smartword'
  " NeoBundle 'camelcasemotion'
  NeoBundle 'gtk-vim-syntax'
  NeoBundle 'submode'
  NeoBundle 'IndentHL'
  NeoBundle 'autoproto.vim'
  NeoBundle 'matchparenpp'
  NeoBundle 'AnsiEsc.vim'
  NeoBundle 'vim-jsbeautify'
  NeoBundle 'Source-Explorer-srcexpl.vim'
  NeoBundle 'Vimchant'
  NeoBundle 'copypath.vim'
  NeoBundle 'MPD-syntax-highlighting'
  "Bundle 'buftabs'
  " }}}

  "personal repo
  NeoBundle 'mytoh/jfbterm.vim'
  " }}}


endif

filetype plugin on
filetype indent on

" vim:set foldmethod=marker:

