
"turn filetype off to load ftdetect by pathogen.vim
filetype off

"pathogen
call pathogen#runtime_append_all_bundles()
"call pathogen#helptags() "remove temporarily, it makes untracked contents in git status(doc/tags)

filetype on
filetype plugin indent on
syntax on

set nobackup
set clipboard+=unnamed
set showmatch
set title
set scrolloff=3
set ruler
set ignorecase
set smartcase
set hlsearch
set incsearch
set showmode
set modeline
set history=10000
set autoindent
set smartindent
set cindent
set showcmd
set wrapscan
set autoread
set hidden
set wildmenu
set wildmode=list:full
set shortmess=atI
set backspace=indent,eol,start
set fileformat=unix
set fileformats=unix,mac,dos
set splitright
set splitbelow

"statusline
set laststatus=2
set statusline=%<%f\ %m%r%h%w%=%Y\ %{&fenc}\ %{&ff}\ %l/%L\ %c%V%8P

"tabs
set smarttab
set tabstop=2
set expandtab
set softtabstop=2
set shiftwidth=2

"set mouse
set mouse=a
set ttymouse=xterm2

"colors
set t_Co=256
colorscheme xoria256

"encodings
set termencoding=utf-8
set enc=utf-8
set fenc=utf-8
"set fencs=cp932,usc-bom,usc-21e,ucs-2,iso-2022-jp-3,euc-jp

" keymaps ---------------
noremap ; :
noremap : ;
noremap <CR> o<ESC>
noremap <SPACE> i<SPACE><ESC>
nmap n nzz
nmap N Nzz
" neocomplcache keymap
" <CR>: close popup and save indent.
inoremap <expr><CR> neocomplcache#smart_close_popup() . "\<CR>"

helptags $HOME/.vim/doc

au BufWritePost .vimrc source $MYVIMRC

augroup Scheme
  au!
  au FileType scheme setl cindent& lispwords=define,lambda,call-with-*
augroup END
       


"------------------------------------
" plugins
"------------------------------------

" Chalice for vim -------------------
"set runtimepath+=$HOME/.vim/chalice
let chalice_startupflags = 'bookmark'
let chalice_writeoptions = 'amp,nbsp,zenkaku'
let chalice_statusline = '%c,'
let chalice_anonyname = ''
let chalice_autonumcheck = 1
let chalice_previewflags = 'autoclose'
let chalice_reloadinterval_threadlist = 0

" neocomplcache ------------------------
let g:neocomplcache_enable_at_startup = 1
let g:neocomplcache_enable_smart_case = 1 
let g:neocomplcache_enable_camle_case_completion = 1
let g:neocomplcache_enable_underbar_completion = 1
let g:neocomplcache_enable_auto_select = 0

" vimfiler ----------------------
let g:vimfiler_as_default_explorer = 1

" minibufexplorerpp ---------------------
let g:miniBufExplMapWindowNavVim = 1 "move with keys hjkl
let g:miniBufExplMapWindowNavArrows = 1
let g:miniBufExplMapCTabSwitchBufs = 1
let g:miniBufExplModSelTarget = 1

" quickrun ---------------------------
let g:quickrun_config = { '*': { 'split': ''}, 'scheme': { 'command': 'petite --script'}}

"--------------------------------------
" I stole settings from these urls
"--------------------------------------

" minibufexplorer and many useful plugins
" http://d.hatena.ne.jp/yuroyoro/20101104/1288879591
"


