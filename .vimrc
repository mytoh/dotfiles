
"turn filetype off to load ftdetect
set nocompatible
filetype off

set rtp+=~/.vim/vundle/
call vundle#rc()

" my bundles here {{

" github repo
Bundle 'tpope/vim-fugitive'
Bundle 'tpope/vim-surround'
Bundle 'Shougo/neocomplcache'
Bundle 'Shougo/vimfiler'
Bundle 'Shougo/vinarise'
Bundle 'Shougo/unite.vim'
Bundle 'Shougo/vimproc'
Bundle 'Shougo/vimshell'
Bundle 'thinca/vim-quickrun'
Bundle 'thinca/vim-ref'
Bundle 'koron/chalice'
Bundle 'scrooloose/nerdcommenter'
Bundle 'kana/vim-fakeclip'
Bundle 'tyru/savemap.vim'
Bundle 'tyru/vice.vim'
Bundle 'tyru/eskk.vim'
Bundle 'fholgado/minibufexpl.vim'
Bundle 'lilydjwg/colorizer'
Bundle 'hakobe/unite-script'
Bundle 'mattn/unite-remotefile'
Bundle 'mattn/googlereader-vim'
Bundle 'ujihisa/unite-colorscheme'
Bundle 'ujihisa/neco-look'

" vim-scripts repo
"Bundle 'gauref.vim'
Bundle 'info.vim'
Bundle 'eregex.vim'
Bundle 'sudo.vim'

" git repo
"

" }}

filetype on
filetype plugin indent on
syntax on

set nobackup
set clipboard=unnamed,autoselect
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
set history=100
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
set autochdir
set cursorline
set list
set listchars=tab:^\ ,trail:_
set virtualedit=all
set grepprg=ack\ -a

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

" keymap {{
let mapleader = ","
nnoremap ; :
nnoremap : ;
nnoremap <CR> o<ESC>
nnoremap <SPACE> i<SPACE><ESC>
nmap n nzz
nmap N Nzz
nnoremap <ESC><ESC> ;nohlsearch<CR><ESC>
nnoremap <Leader>w :<C-u>up<CR>
nnoremap <Leader>q :<C-u>qa<CR>
" neocomplcache keymap
" <CR>: close popup and save indent.
inoremap <expr><CR> neocomplcache#smart_close_popup() . "\<CR>"
" }}

" autocommands {{
aug mycommands
  au!
  au bufwritepost .vimrc source $MYVIMRC
  au bufread,bufnewfile .tmux.conf  set filetype=tmux
  au bufwritepost .Xresources silent !xrdb -remove
  au bufwritepost .Xresources silent !xrdb -merge ~/.Xresources
  au bufwritepost .zshrc silent !zcompile .zshrc
aug END

aug scheme
  au!
  au filetype scheme setl cindent& lispwords=define,lambda,call-with-*
aug END

aug cch
  au! cch
  au winleave * set nocursorline
  au winenter,bufread * set cursorline
aug END

hi clear Cursorline
hi Cursorline gui=underline
hi Cursorline ctermbg=black guibg=black

au bufwritepost * call SetUTF8Xattr(expand("<afile>"))
function! SetUTF8Xattr(file)
  let isutf8 = &fileencoding == "utf-8" || (&fileencoding == "" && &encoding == "utf-8")
  if has("unix") && match(system("uname"),'Darwin') != -1 && isutf8
    call system("xattr -w com.apple.TextEncoding 'utf-8;134217984' '" . a:file . "'")
  endif
endfunction

" }}


" plugins {{{

" Chalice for vim {{
"set runtimepath+=$HOME/.vim/chalice
let chalice_startupflags = 'bookmark'
let chalice_writeoptions = 'amp,nbsp,zenkaku'
let chalice_statusline = '%c,'
let chalice_anonyname = ''
let chalice_autonumcheck = 1
let chalice_previewflags = 'autoclose'
let chalice_reloadinterval_threadlist = 0
" }}

" neocomplcache {{
let g:neocomplcache_enable_at_startup = 1
let g:neocomplcache_enable_smart_case = 1 
let g:neocomplcache_enable_camle_case_completion = 1
let g:neocomplcache_enable_underbar_completion = 1
let g:neocomplcache_enable_auto_select = 0
let g:neocomplcache_dictionary_filetype_lists = {
                    \ 'default' : '',
                    \ 'scheme'  : $HOME.'/.gosh_completions'
                    \ }
" }}

" vimfiler {{
let g:vimfiler_as_default_explorer = 1
" }}

" minibufexplorerpp {{
let g:miniBufExplMapWindowNavVim = 1 "move with keys hjkl
let g:miniBufExplMapWindowNavArrows = 1
let g:miniBufExplMapCTabSwitchBufs = 1
let g:miniBufExplModSelTarget = 1
" }}

" quickrun {{
let g:quickrun_config = { '*': { 'split': ''}, 'scheme': { 'command': 'gosh'}}
" }}

" minibufexplorer and many useful plugins
" http://d.hatena.ne.jp/yuroyoro/20101104/1288879591
"

" unite.vim {{
"let g:unite_enable_start_insert=1
let g:unite_split_rule = "belowright"
" buffer list
nnoremap <silent> <Leader>ub :<C-u>Unite bookmark<CR>
nnoremap <silent> <Leader>uf :<C-u>Unite -buffer-name=files file<CR>
" leave unite buffer
au filetype unite nnoremap <silent> <buffer> <ESC><ESC> :q<CR>
au filetype unite inoremap <silent> <buffer> <ESC><ESC> <ESC>:q<CR>
" }}

" eskk {{
if has('vim_starting')
    let g:eskk_dictionary = '~/.skk-jisyo'
"   let g:eskk_large_dictionary = '~/.skk-jisyo.mine'
endif
let g:eskk_egg_like_newline = 0
"let g:eskk_revert_henkan_style = "okuri"
let g:eskk_enable_completion = 0
" }}

" vimshell {{
nnoremap <silent> <Leader>is :VimShell<cr>
let g:vimshell_user_prompt = 'fnamemodify(getcwd(), ":~")'
let g:vimshell_smart_case = 1
let g:vimshell_enable_auto_slash = 1

aug Vimshell
  autocmd FileType vimshell
        \ call vimshell#hook#set('chpwd', ['g:my_chpwd'])

  function! g:my_chpwd(args, context)
    call vimshell#execute('ls')
  endfunction
aug END
" }}

" vimproc {{
let g:vimproc_dll_path = $HOME . '/.vim/bundle/vimproc/autoload/proc.so'
" }}

" gauref
let g:gauref_file = '/usr/home/mytoh/.vim/bundle/gauref.vim/doc/gauche-refe.txt'

" }}}

