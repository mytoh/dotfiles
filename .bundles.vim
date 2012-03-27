set shell=sh

if isdirectory(expand('$HOME/.bundle/neobundle.vim'))
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
NeoBundle 'Shougo/unite.vim'
NeoBundle 'Shougo/vimfiler'
NeoBundle 'Shougo/vimproc'
NeoBundle 'Shougo/vimshell'
NeoBundle 'Shougo/vinarise'
NeoBundle 'hakobe/unite-script'
NeoBundle 'koron/chalice'
NeoBundle 'koron/nyancat-vim'
NeoBundle 'choplin/unite-vim_hacks'
NeoBundle 'lilydjwg/colorizer'
NeoBundle 'mattn/googlereader-vim'
NeoBundle 'mattn/lisper-vim'
NeoBundle 'mattn/unite-remotefile'
NeoBundle 'mattn/webapi-vim'
NeoBundle 'mattn/wwwrenderer-vim'
NeoBundle 'mattn/learn-vimscript'
NeoBundle 'mattn/hahhah-vim'
NeoBundle 'mattn/gist-vim'
NeoBundle 'mattn/sonictemplate-vim'
NeoBundle 'rson/vim-bufstat'
NeoBundle 'scrooloose/syntastic'
NeoBundle 'scrooloose/nerdcommenter'
NeoBundle 'thinca/vim-quickrun'
NeoBundle 'thinca/vim-ref'
NeoBundle 'thinca/vim-ambicmd'
NeoBundle 'thinca/vim-openbuf'
NeoBundle 'thinca/vim-singleton'
NeoBundle 'thinca/vim-poslist'
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
NeoBundle 'tyru/unite-cmdwin'
NeoBundle 'tyru/vice.vim'
NeoBundle 'tyru/current-func-info.vim'
NeoBundle 'tyru/caw.vim'
NeoBundle 'ujihisa/neco-look'
NeoBundle 'ujihisa/unite-colorscheme'
NeoBundle 'ujihisa/unite-launch'
NeoBundle 'ujihisa/vimshell-ssh'
NeoBundle 'mfumi/unite-mpc'
NeoBundle 'mfumi/mpc.vim'
NeoBundle 'mileszs/ack.vim'
NeoBundle 'trapd00r/vim-extendedcolors'
NeoBundle 'groenewege/vim-less'
NeoBundle 'othree/html5.vim'
NeoBundle 'gregsexton/MatchTag'
NeoBundle 'djjcast/mirodark'
NeoBundle 'houtsnip/vim-emacscommandline'
NeoBundle 'acustodioo/vim-cmdline-completion'
NeoBundle 'h1mesuke/unite-outline'
NeoBundle 'h1mesuke/vim-alignta'
NeoBundle 'baskerville/bubblegum'
NeoBundle 'kien/ctrlp.vim'
NeoBundle 'basyura/twibill.vim'
NeoBundle 'basyura/bitly.vim'
NeoBundle 'basyura/TweetVim'
NeoBundle 'nathanaelkane/vim-indent-guides'
NeoBundle 'haruyama/scheme.vim'
NeoBundle 'Lokaltog/vim-easymotion'
" NeoBundle 'Lokaltog/vim-powerline'
NeoBundle 'behaghel/Rainbow_Parenthsis_Bundle'
NeoBundle 'kergoth/fish.vim'
NeoBundle 'kana/vim-textobj-user'
NeoBundle 'kana/vim-textobj-line'
NeoBundle 'Raimondi/delimitMate'
NeoBundle 'hobbestigrou/Vim-wmfs'
NeoBundle 'aharisu/Gauche-Complete'
NeoBundle 'bronson/vim-trailing-whitespace'
NeoBundle 'taka84u9/unite-git'
NeoBundle 'chrisbra/SudoEdit.vim'
NeoBundle 'yuratomo/w3m.vim'
NeoBundle 'xolox/vim-reload'
NeoBundle 'gmarik/github-search.vim'
NeoBundle 'gregsexton/gitv'
" colorscheme {{{
NeoBundle 'altercation/vim-colors-solarized'
NeoBundle 'jelera/vim-gummybears-colorscheme'
NeoBundle 'shawncplus/skittles_berry'
NeoBundle 'jnurmine/Zenburn'
NeoBundle 'jpo/vim-railscasts-theme'
NeoBundle 'trapd00r/neverland-vim-theme'
"}}}
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
NeoBundle 'gtk-vim-syntax'
NeoBundle 'submode'
NeoBundle 'IndentHL'
"Bundle 'buftabs'
" colorschemes
NeoBundle 'jellybeans.vim'
NeoBundle 'xoria256.vim'
NeoBundle 'molokai'
NeoBundle 'robokai'
NeoBundle 'lilypink'
" }}}
" }}}

endif

filetype plugin on
filetype indent on

" vim:set foldmethod=marker:
