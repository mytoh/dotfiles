"                      __                          __   ___
"                     /\ \                        /\ \ /\_ \
"   ___      __    ___\ \ \____  __  __    ___    \_\ \\//\ \      __
" /' _ `\  /'__`\ / __`\ \ '__`\/\ \/\ \ /' _ `\  /'_` \ \ \ \   /'__`\
" /\ \/\ \/\  __//\ \L\ \ \ \L\ \ \ \_\ \/\ \/\ \/\ \L\ \ \_\ \_/\  __/
" \ \_\ \_\ \____\ \____/\ \_,__/\ \____/\ \_\ \_\ \___,_\/\____\ \____\
"  \/_/\/_/\/____/\/___/  \/___/  \/___/  \/_/\/_/\/__,_ /\/____/\/____/
"

set shell=sh

let $VIMBUNDLE_DIR=$HOME."/.vim/bundle"
if !isdirectory($VIMBUNDLE_DIR."/neobundle.vim")
  call mkdir($VIMBUNDLE_DIR, "p")
else

  if has('vim_starting')
    set runtimepath^=$VIMBUNDLE_DIR/neobundle.vim
    set nocompatible
    filetype off
    call neobundle#rc($VIMBUNDLE_DIR)
  endif

  NeoBundle 'Shougo/neobundle.vim'

  " my bundles here {{{
  "
  " github repo {{{
  NeoBundle 'github:Shougo/neocomplcache', {'depends' :
        \ [ 'github:Shougo/neocomplcache-snippets-complete.git',
        \ ['github:rstacruz/sparkup', {'rtp': 'vim'}],
        \ ]}
  NeoBundle 'github:Shougo/vimfiler',
        \ {'depends' : 'github:Shougo/unite.vim' }
  NeoBundle 'github:Shougo/vimproc'
  NeoBundle 'github:Shougo/vimshell'
  NeoBundle 'github:Shougo/vinarise'
  NeoBundle 'github:Shougo/echodoc'
  NeoBundle 'github:koron/nyancat-vim'
  NeoBundle 'github:koron/chalice'
  " NeoBundle 'github:koron/homoo-vim'
  " NeoBundle 'github:koron/u-nya-vim'
  NeoBundle 'github:lilydjwg/colorizer'
  NeoBundle 'github:mattn/googlereader-vim'
  NeoBundle 'github:mattn/lisper-vim'
  NeoBundle 'github:mattn/webapi-vim'
  NeoBundle 'github:mattn/wwwrenderer-vim'
  NeoBundle 'github:mattn/learn-vimscript'
  NeoBundle 'github:mattn/hahhah-vim'
  NeoBundle 'github:mattn/gist-vim'
  NeoBundle 'github:mattn/sonictemplate-vim'
  NeoBundle 'github:mattn/togetter-vim'
  " NeoBundle 'github:rson/vim-bufstat'
  NeoBundle 'github:scrooloose/nerdcommenter'
  NeoBundle 'github:chikatoike/activefix.vim'
  NeoBundle 'github:thinca/vim-ambicmd'
  NeoBundle 'github:thinca/vim-openbuf'
  NeoBundle 'github:thinca/vim-singleton'
  NeoBundle 'github:thinca/vim-poslist'
  NeoBundle 'github:thinca/vim-qfreplace'
  NeoBundle 'github:thinca/vim-editvar'
  NeoBundle 'github:thinca/vim-localrc'
  NeoBundle 'github:tpope/vim-surround'
  NeoBundle 'github:tpope/vim-afterimage'
  NeoBundle 'github:tpope/vim-markdown'
  NeoBundle 'github:tpope/vim-unimpaired'
  NeoBundle 'github:tpope/vim-repeat'
  NeoBundle 'github:tpope/vim-eunuch'
  "dont map <cr> if install vim-endwise
  NeoBundle 'github:tpope/vim-endwise'
  NeoBundle 'github:tyru/eskk.vim'
  NeoBundle 'github:tyru/skkdict.vim'
  NeoBundle 'github:tyru/open-browser.vim'
  NeoBundle 'github:tyru/savemap.vim'
  " NeoBundle 'github:tyru/vice.vim'
  NeoBundle 'github:tyru/current-func-info.vim'
  NeoBundle 'github:tyru/caw.vim'
  NeoBundle 'github:tyru/autochmodx.vim'
  NeoBundle 'github:ujihisa/neco-look'
  NeoBundle 'github:ujihisa/vimshell-ssh'
  NeoBundle 'github:mfumi/mpc.vim'
  NeoBundle 'github:mileszs/ack.vim'
  NeoBundle 'github:epmatsw/ag.vim'
  NeoBundle 'github:trapd00r/vim-extendedcolors'
  NeoBundle 'github:groenewege/vim-less'
  NeoBundle 'github:othree/html5.vim'
  NeoBundle 'github:gregsexton/MatchTag'
  NeoBundle 'github:djjcast/mirodark'
  NeoBundle 'github:houtsnip/vim-emacscommandline'
  " NeoBundle 'github:acustodioo/vim-cmdline-completion'
  NeoBundle 'github:acustodioo/vim-enter-indent'
  NeoBundle 'github:h1mesuke/vim-alignta'
  NeoBundle 'github:baskerville/bubblegum'
  NeoBundle 'github:basyura/twibill.vim'
  NeoBundle 'github:basyura/bitly.vim'
  NeoBundle 'github:basyura/TweetVim'
  NeoBundle 'github:nathanaelkane/vim-indent-guides'
  " NeoBundle 'github:haruyama/scheme.vim'
  NeoBundle 'github:Lokaltog/vim-easymotion'
  " NeoBundle 'github:Lokaltog/vim-powerline'
  NeoBundle 'github:kien/rainbow_parentheses.vim'
  NeoBundle 'github:kien/tabman.vim'
  NeoBundle 'github:kergoth/fish.vim'
  NeoBundle 'github:kana/vim-textobj-user'
  NeoBundle 'github:kana/vim-textobj-line'
  NeoBundle 'github:kana/vim-smartinput'
  NeoBundle 'github:kana/vim-smartchr'
  NeoBundle 'github:kana/vim-scratch'
  NeoBundle 'github:kana/vim-tabpagecd'
  NeoBundle 'github:kana/vim-operator-user'
  NeoBundle 'github:kana/vim-operator-replace'
  NeoBundle 'github:lucapette/vim-textobj-underscore'
  " NeoBundle 'github:Raimondi/delimitMate'
  NeoBundle 'github:hobbestigrou/Vim-wmfs'
  NeoBundle 'github:bronson/vim-trailing-whitespace'
  NeoBundle 'github:chrisbra/SudoEdit.vim'
  NeoBundle 'github:yuratomo/w3m.vim'
  NeoBundle 'github:tsukkee/lingr-vim'
  NeoBundle 'github:xolox/vim-reload'
  NeoBundle 'github:jpalardy/vim-slime'
  NeoBundle 'github:godlygeek/tabular'
  NeoBundle 'github:sjl/gundo.vim'
  NeoBundle 'github:vim-jp/vital.vim'
  NeoBundle 'github:vim-jp/cpp-vim'
  NeoBundle 'github:Twinside/vim-codeoverview'
  NeoBundle 'vim2ansi'
  NeoBundle 'github:majutsushi/tagbar'
  " NeoBundle 'github:nefo-mi/nyan-modoki.vim'
  NeoBundle 'github:mytoh/nyan-modoki.vim'
  " NeoBundle 'github:coderifous/textobj-word-column.vim'
  NeoBundle 'github:spolu/dwm.vim'
  NeoBundle 'sherlock.vim'
  NeoBundle 'github:guns/xterm-color-table.vim'
  NeoBundle 'github:AndrewRadev/switch.vim'

  " tmux
  NeoBundle 'github:peterhoeg/vim-tmux'
  " NeoBundle 'github:anekos/runes-vim'

  " ref
  NeoBundle 'github:thinca/vim-ref'
  NeoBundle 'github:h1mesuke/ref-dicts-en'
  
  "unite
  NeoBundle 'github:Shougo/unite.vim'
  NeoBundle 'github:hakobe/unite-script'
  NeoBundle 'github:choplin/unite-vim_hacks'
  NeoBundle 'github:mattn/unite-remotefile'
  NeoBundle 'github:ujihisa/unite-colorscheme'
  NeoBundle 'github:ujihisa/unite-launch'
  NeoBundle 'github:mfumi/unite-mpc'
  NeoBundle 'github:h1mesuke/unite-outline'
  NeoBundle 'github:shiracha/unite-related_files'
  NeoBundle 'github:osyo-manga/unite-homo'
  NeoBundle 'github:osyo-manga/unite-u-nya-'
  NeoBundle 'github:osyo-manga/unite-env'
  NeoBundle 'github:mytoh/unite-sa-nya-'
  NeoBundle 'github:jceb/vim-hier'
  NeoBundle 'github:tsukkee/unite-tag'
  " NeoBundle 'github:Sixeight/unite-grep'
  NeoBundle 'github:pasela/unite-webcolorname'
  NeoBundle 'github:tsukkee/unite-help'
  NeoBundle 'github:t9md/vim-unite-ack'
  NeoBundle 'github:Shougo/unite-ssh'
  " NeoBundle 'github:tungd/unite-session'
  NeoBundle 'github:mytoh/unite-highlight'
  NeoBundle 'github:raduwen/unite-peercast'

  " quickrun
  NeoBundle 'github:osyo-manga/unite-quickfix'
  NeoBundle 'github:osyo-manga/shabadou.vim'
  NeoBundle 'github:osyo-manga/vim-watchdogs'
  NeoBundle 'github:osyo-manga/quickrun-hook-u-nya-'
  NeoBundle 'github:thinca/vim-quickrun'

  " git
  NeoBundle 'github:thinca/vim-github'
  NeoBundle 'github:tpope/vim-fugitive'
  NeoBundle 'github:tpope/vim-rhubarb'
  NeoBundle 'github:taka84u9/unite-git'
  NeoBundle 'github:gmarik/github-search.vim'
  NeoBundle 'github:gregsexton/gitv'
  NeoBundle 'github:yomi322/vim-gitq'
  NeoBundle 'github:hrsh7th/vim-unite-vcs'

  " others
  NeoBundle 'github:Rykka/colorv.vim'
  NeoBundle 'Highlight-UnMatched-Brackets'
  NeoBundle 'github:dahu/vim-fanfingtastic'

  " syntax
  "c
  NeoBundle 'github:cg433n/better-c'
  "lisp
  NeoBundle 'paredit.vim'
  NeoBundle 'github:aharisu/vim-gdev'
  " NeoBundle 'github:aharisu/Gauche-Complete'
  " clojure
  " NeoBundle 'bitbucket:kotarak/vimclojure', {'rtp': 'vim/src/main/vim'}
  " NeoBundle 'VimClojure'
  " NeoBundle 'github:emanon001/fclojure.vim'
  NeoBundle 'github:thinca/vim-ft-clojure'

  "haskell
  " NeoBundle 'github:Twinside/vim-haskellConceal'
  NeoBundle 'github:Twinside/vim-syntax-haskell-cabal'
  NeoBundle 'github:zenzike/vim-haskell-unicode'
  NeoBundle 'github:haskell.vim'
  NeoBundle 'github:lukerandall/haskellmode-vim'
  NeoBundle 'github:kana/vim-filetype-haskell'
  NeoBundle 'github:eagletmt/ghcmod-vim'
  NeoBundle 'github:ujihisa/neco-ghc'
  NeoBundle 'github:ujihisa/ref-hoogle'
  NeoBundle 'github:dag/vim2hs'
  NeoBundle 'github:eagletmt/unite-haddock'

  "javascript
  NeoBundle 'github:jelera/vim-javascript-syntax'
  NeoBundle 'github:pangloss/vim-javascript'
  NeoBundle 'github:teramako/jscomplete-vim'
  NeoBundle 'github:einars/js-beautify'
  NeoBundle 'github:maksimr/vim-jsbeautify'
  NeoBundle 'JSON.vim'
  " css
  NeoBundle 'github:hail2u/vim-css3-syntax'
  NeoBundle 'github:skammer/vim-css-color'
  " svg
  NeoBundle 'svg.vim'
  " rst
  NeoBundle 'github:Rykka/riv.vim'
  " markdow
  NeoBundle 'github:hallison/vim-markdown'
  " obj-c
  NeoBundle 'github:msanders/cocoa.vim'
  " supercollider
  NeoBundle 'github:sbl/scvim'
  " brainfuck
  NeoBundle 'brainfuck-syntax'
  " python
  NeoBundle 'python.vim'
  " mml
  NeoBundle 'stephencelis/vim-mml'

  " genie
  NeoBundle 'github:GrAndSE/genie-script-vim-syntax'
  " NeoBundle 'genie.vim'

  " colorscheme {{{
  NeoBundle 'github:paulwib/vim-colorschemes'
  NeoBundle 'github:w0ng/vim-hybrid'
  NeoBundle 'github:altercation/vim-colors-solarized'
  NeoBundle 'github:jelera/vim-gummybears-colorscheme'
  NeoBundle 'github:shawncplus/skittles_berry'
  NeoBundle 'github:jnurmine/Zenburn'
  NeoBundle 'github:jpo/vim-railscasts-theme'
  NeoBundle 'github:trapd00r/neverland-vim-theme'
  NeoBundle 'github:lorry-lee/vim-ayumi'
  NeoBundle 'github:chriskempson/vim-tomorrow-theme'
  NeoBundle 'github:chriskempson/base16-vim'
  NeoBundle 'github:sjl/badwolf'
  " NeoBundle 'github:nanotech/jellybeans.vim'
  " NeoBundle 'github:cloudshen/jellybeans.vim'
  NeoBundle 'github:hukl/Smyck-Color-Scheme'
  NeoBundle 'github:Lokaltog/vim-distinguished'
  NeoBundle 'github:zachwill/github.vim'
  NeoBundle 'xoria256.vim'
  NeoBundle 'wombat256.vim'
  NeoBundle 'void'
  NeoBundle 'github:tomasr/molokai'
  NeoBundle 'robokai'
  NeoBundle 'lilypink'
  NeoBundle 'Sorcerer'
  NeoBundle 'highlights-for-radiologist'
  NeoBundle 'Gentooish'
  NeoBundle '256-jungle'
  NeoBundle 'desert256.vim'
  NeoBundle 'git://gist.github.com/187578.git' " <- h2u_black
  NeoBundle 'github:tristen/superman' " <- h2u_black
  NeoBundle 'github:jelera/vim-nazca-colorscheme'
  NeoBundle 'bitbucket:abudden/easycolour'
  NeoBundle 'tropikos'
  NeoBundle 'github:sickill/vim-monokai'
  NeoBundle 'github:nielsmadan/harlequin'
  NeoBundle 'freya'
  "}}}
  " NeoBundle 'http://voikko.svn.sourceforge.net/svnroot/voikko/', {'type' : 'svn', 'rtp' : 'trunk/tools/vim'}
  " bitbucket
  " NeoBundle 'https://bitbucket.org/kovisoft/slimv'
  " }}}

  " official vim-scripts repo {{{
  NeoBundle 'vmark.vim--Visual-Bookmarking'
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
  NeoBundle 'HybridText'
  "Bundle 'buftabs'
  " }}}

  "personal repo
  NeoBundle 'github:mytoh/vim-jfbterm'
  NeoBundle 'github:mytoh/scheme.vim'
  NeoBundle 'github:mytoh/vim-vala'
  " NeoBundleLocal '~/.vim/dev'
  " }}}


endif

filetype plugin on
filetype indent on



" Installation check.
if neobundle#exists_not_installed_bundles()
  echomsg 'Not installed bundles : ' .
        \ string(neobundle#get_not_installed_bundle_names())
  echomsg 'Please execute ":NeoBundleInstall" command.'
  "finish
endif

" vim:set foldmethod=marker:
