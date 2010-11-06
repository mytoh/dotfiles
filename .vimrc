
"turn filetype off to load ftdetect by pathogen.vim
filetype off

"pathogen
call pathogen#runtime_append_all_bundles()
call pathogen#helptags()

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
set nomodeline
set history=10000
set autoindent
set smartindent
set cindent
set showcmd
set wrapscan
set autoread
set hidden
set wildmenu
set wildmode=list:longest
set shortmess=atI
set backspace=indent,eol,start
set fileformat=unix
set fileformats=unix,mac,dos

"statusline
set laststatus=2
set statusline=%<%f\ %m%r%h%w%=%Y\ %{&fenc}\ %{&ff}\ %l/%L\ %c%V%8P

" tabs
set smarttab
set tabstop=2
set expandtab
set softtabstop=2
set shiftwidth=2

"colors
set t_Co=256
colorscheme xoria256

" encodings
set enc=utf-8
"set fencs=cp932,usc-bom,usc-21e,ucs-2,iso-2022-jp-3,euc-jp

"keymaps
noremap ; :
noremap : ;
noremap <CR> o<ESC>
noremap <SPACE> i<SPACE><ESC>
nmap n nzz
nmap N Nzz
"" tabpages
let mapleader = ","
nnoremap [TABCMD] <nop>
nmap    <Leader>t [TABCMD]
noremap <silent> [TABCMD]f :<c-u>tabfirst<CR>
noremap <silent> [TABCMD]l :<c-u>tablast<CR>
noremap <silent> [TABCMD]n :<c-u>tabnext<CR>
noremap <silent> [TABCMD]N :<c-u>tabNext<CR>
noremap <silent> [TABCMD]p :<c-u>tabprevious<CR>
noremap <silent> [TABCMD]e :<c-u>tabedit<CR>
noremap <silent> [TABCMD]c :<c-u>tabclose<CR>
noremap <silent> [TABCMD]o :<c-u>tabonly<CR>
noremap <silent> [TABCMD]s :<c-u>tabs<CR>

"abbrev
cabbrev h tab help

"helptags $HOME/.vim/doc/

autocmd BufWritePost .vimrc source $MYVIMRC

" Chalice for vim -------------------
set runtimepath+=$HOME/.vim/chalice
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
let g:neocomplcache_enable_auto_select = 1 

" fuf.vim ------------------------
let g:fuf_modesDisable = [ 'mrucmd', ]
let g:fuf_file_exclude = '\v\~$|\.(o|exe|bak|swp|gif|jpg|png|)$|(^|[/\\])\.(hg|git|bzr)($|[/\\]'
let g:fuf_enumeratingLimit = 20
let g:fuf_keyPreview = '>'

" vimfiler ----------------------
let g:vimfiler_as_default_explorer = 1
