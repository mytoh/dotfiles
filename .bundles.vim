
if !isdirectory(expand("~/.bundle"))
  call mkdir(expand("~/.bundle"), "p")
 if !isdirectory(expand("~.bundle/neobundle.vim"))
  call system("git clone " . "git://github.com/Shougo/neobundle.vim " . expand("~/.bundle/neobundle.vim"))
endif
if !isdirectory(expand("~/.bundle/vim-ambicmd"))
  call system("git clone " . "git://github.com/thinca/vim-ambicmd " . expand("~/.bundle/vim-ambicmd"))
endif
endif


if has('vim_starting')
  set runtimepath+=$HOME/.bundle/neobundle.vim
  filetype off
  call neobundle#rc(expand('~/.bundle'))
endif

NeoBundle 'Shougo/neobundle.vim'

" my bundles here {{{
"
" github repo
NeoBundle 'Shougo/neocomplcache'
NeoBundle 'Shougo/unite.vim'
NeoBundle 'Shougo/vimfiler'
NeoBundle 'Shougo/vimproc'
NeoBundle 'Shougo/vimshell'
NeoBundle 'hakobe/unite-script'
NeoBundle 'koron/chalice'
NeoBundle 'choplin/unite-vim_hacks'
NeoBundle 'lilydjwg/colorizer'
NeoBundle 'mattn/googlereader-vim'
NeoBundle 'mattn/lisper-vim'
NeoBundle 'mattn/unite-remotefile'
NeoBundle 'mattn/webapi-vim'
NeoBundle 'mattn/wwwrenderer-vim'
NeoBundle 'mattn/learn-vimscript'
NeoBundle 'rson/vim-bufstat'
NeoBundle 'scrooloose/nerdcommenter'
NeoBundle 'thinca/vim-quickrun'
NeoBundle 'thinca/vim-ref'
NeoBundle 'thinca/vim-ambicmd'
NeoBundle 'thinca/vim-openbuf'
NeoBundle 'tpope/vim-fugitive'
NeoBundle 'tpope/vim-surround'
NeoBundle 'tpope/vim-afterimage'
NeoBundle 'tyru/eskk.vim'
NeoBundle 'tyru/skkdict.vim'
NeoBundle 'tyru/open-browser.vim'
NeoBundle 'tyru/savemap.vim'
NeoBundle 'tyru/unite-cmdwin'
NeoBundle 'tyru/vice.vim'
NeoBundle 'ujihisa/neco-look'
NeoBundle 'ujihisa/unite-colorscheme'
NeoBundle 'ujihisa/vimshell-ssh'
NeoBundle 'mfumi/unite-mpc'
NeoBundle 'mfumi/mpc.vim'
NeoBundle 'plasticboy/vim-markdown'
NeoBundle 'mileszs/ack.vim'
NeoBundle 'trapd00r/vim-extendedcolors'
NeoBundle 'groenewege/vim-less'
NeoBundle 'othree/html5.vim'
NeoBundle 'gregsexton/MatchTag'
NeoBundle 'djjcast/mirodark'

" official vim-scripts repo
NeoBundle 'info.vim'
NeoBundle 'eregex.vim'
NeoBundle 'SudoEdit.vim'
NeoBundle 'fluxbox.vim'
NeoBundle 'matchit.zip'
"Bundle 'buftabs'
" colorschemes
NeoBundle 'jellybeans.vim'
NeoBundle 'xoria256.vim'
" other git repo

" }}}

filetype plugin on
filetype indent on

" vim:set foldmethod=marker:
