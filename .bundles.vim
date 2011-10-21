
if !isdirectory(expand("~/.bundle"))
  call mkdir(expand("~/.bundle"), "p")
  call system("git clone " . "git://github.com/Shougo/neobundle.vim " . expand("~/.bundle/neobundle.vim"))
endif


if has('vim_starting')
  set runtimepath+=$HOME/.bundle/neobundle.vim
  filetype off
  call neobundle#rc(expand('~/.bundle'))
  filetype plugin on
  filetype indent on
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
NeoBundle 'Shougo/vinarise'
"Bundle 'fholgado/minibufexpl.vim'
NeoBundle 'godlygeek/tabular'
NeoBundle 'hakobe/unite-script'
NeoBundle 'kana/vim-fakeclip'
NeoBundle 'koron/chalice'
NeoBundle 'lilydjwg/colorizer'
NeoBundle 'mattn/googlereader-vim'
NeoBundle 'mattn/unite-remotefile'
NeoBundle 'mattn/webapi-vim'
NeoBundle 'mattn/wwwrenderer-vim'
"NeoBundle 'roman/golden-ratio'
NeoBundle 'rson/vim-bufstat'
NeoBundle 'scrooloose/nerdcommenter'
NeoBundle 'scrooloose/nerdtree'
NeoBundle 'thinca/vim-quickrun'
NeoBundle 'thinca/vim-ref'
NeoBundle 'thinca/vim-ambicmd'
NeoBundle 'tpope/vim-fugitive'
NeoBundle 'tpope/vim-surround'
NeoBundle 'tpope/vim-afterimage'
NeoBundle 'Twinside/vim-cuteErrorMarker'
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

" official vim-scripts repo
"NeoBundle 'gauref.vim'
NeoBundle 'info.vim'
NeoBundle 'eregex.vim'
NeoBundle 'sudo.vim'
NeoBundle 'YankRing.vim'
NeoBundle 'fluxbox.vim'
NeoBundle 'matchit.zip'
NeoBundle 'Align'
NeoBundle 'Color-Sampler-Pack'
"Bundle 'buftabs'
" colorschemes
NeoBundle 'jellybeans.vim'
NeoBundle 'xoria256.vim'
" other git repo

" }}}


" vim:set foldmethod=marker:
