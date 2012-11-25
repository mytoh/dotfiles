
"  options{{{

" fix problem when vim on fish shell
if $SHELL =~ '/fish$'
  set shell=bash
endif

" backup, swap, undo {{{
set history=10000
if has('persistent_undo')
  set undodir=~/.vim/undo
  set undofile
endif
set nobackup
set nowritebackup
set noswapfile
set directory^=~/.vim/swap
" }}}

let g:is_posix = 1             " vim's default is archaic bourne shell, bring it up to the 90s

set clipboard=unnamed
set scrolloff=1
set title
set ruler
set tildeop
set cursorline
set modeline
set showmode
set showcmd
set showmatch
set diffopt+=vertical
set ambiwidth=double
set display+=lastline
" key sequence timeout length (default: 1000(ms))
set timeoutlen=10000
set wildignorecase
set visualbell
set noerrorbells visualbell t_vb=

" indent {{{

set autoindent
set smartindent

set tabstop=2                  " tab size eql 2 spaces
set softtabstop=2
set shiftwidth=2               " default shift width for indents
set shiftround
set expandtab                  " replace tabs with ${tabstop} spaces
set smarttab
" }}}


set backspace=indent
set backspace+=eol
set backspace+=start

" search {{{
set ignorecase
set smartcase
set hlsearch
set incsearch
set wrapscan
set gdefault                  " %s/foo/bar  ->  %s/foo/bar/g
" }}}

" fold {{{
set foldenable                " Turn on folding
set foldmethod=marker         " Fold on the marker
set foldlevel=100             " Don't autofold anything (but I can still fold manually)

set foldopen=block,hor,tag    " what movements open folds
set foldopen+=percent,mark
set foldopen+=quickfix
" }}}

set splitbelow
set splitright

set list
set listchars=tab:\|\ ,trail:-,eol:¬,extends:»,precedes:«,nbsp:%

" tags
set showfulltag

" colors
set t_Co=256
" set background=dark
colorscheme mycolour
let g:molokai_original = 0

" set mouse
set mouse=a
set ttymouse=xterm2

set ttyfast

" encodings
scriptencoding=utf-8
set termencoding=utf-8
set enc=utf-8
set fenc=utf-8
" set fencs=iso-2022-jp,utf-8,ucs-21e,euc-jp

set helplang=en,ja
set autoread
set hidden
set wildmenu
set wildmode=list:full
set wildignore+=*/.neocon/*
set shortmess=atIToO
set cmdheight=1
set fileformats=unix,mac,dos
set virtualedit=all
set nomore
set imdisable
set formatoptions=q

" columns {{{
set textwidth=80
" vertical line on column 81
set colorcolumn=+1

" }}}

"show replace end
set cpoptions+=$

if executable('ack')
  set grepprg=ack\ -a
endif

" change cursor colour
" let &t_SI  = "\<Esc>[3 q;orange\x7"
" let &t_EI  = "\<Esc>[0 q;red\x7"
"silent !echo -ne "\033]12;red\007"
"autocmd VimLeave * silent !echo -ne "\033]112\007"

" change cursor when insert mode
" let &t_SI .= "[4 q"
" let &t_EI .= "[2 q"

"}}}
