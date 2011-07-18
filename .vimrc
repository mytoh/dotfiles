
let os = substitute(system('uname'),"\n","","")
if os == "Haiku"
  let g:loaded_vimproc = 1
  set rtp^=~/.vim/
endif

" Vundle and bundles configuration
source $HOME/.vim-bundles

" {{ options
"
filetype plugin indent on " required
syntax on

language messages C
language time C


set nobackup
set clipboard=unnamed,autoselect
set showmatch
set title
set scrolloff=1
set ruler
set ignorecase
set smartcase
set hlsearch
set incsearch
set showmode
set showcmd
set modeline
set history=100
set autoindent
set smartindent
"set cindent
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
" statusline
set laststatus=2
set statusline=%<\ %f\ %m%r%h%w\ %{fugitive#statusline()}%=%Y\ %{&fenc}\ %{&ff}\ %l/%L\ %c%V%8P
" tabs
set smarttab
set tabstop=2
set expandtab
set softtabstop=2
set shiftwidth=2
" set mouse
set mouse=a
set ttymouse=xterm2
" colors
set t_Co=256
colorscheme xoria256
" encodings
scriptencoding=utf-8
set termencoding=utf-8
set enc=utf-8
set fenc=utf-8
"set fencs=cp932,usc-bom,usc-21e,ucs-2,iso-2022-jp-3,euc-jp
" }}

" {{ keymap
let mapleader = ","
nnoremap ; :
nnoremap : ;
nnoremap <space> i<space><esc>
nmap n nzz
nmap N Nzz
nnoremap <silent> <esc><esc> :nohlsearch<cr><esc>
nnoremap <leader>w :<c-u>up<cr>
nnoremap <leader>q :<c-u>qa<cr>
" }}

" {{ autocommands
aug myautocommands
  au!
  au bufread,bufnewfile .tmux.conf  set filetype=tmux
  au bufread,bufnewfile .vimshrc    set filetype=vim
  au bufwritepost       .vimrc      source $MYVIMRC
  au bufwritepost       .Xresources silent !xrdb -remove
  au bufwritepost       .Xresources silent !xrdb -merge ~/.Xresources
  au bufwritepost       .zshrc      silent !zcompile .zshrc
  au filetype scheme setl cindent& lispwords=define,lambda,call-with-*
  au filetype help nnoremap q :<c-u>q<cr>
aug end

aug cch
  au! cch
  au winleave * set nocursorline
  au winenter,bufread * set cursorline
aug end

hi clear cursorline
hi cursorline gui=underline
hi cursorline ctermbg=237 guibg=black

au bufwritepost * call SetUTF8Xattr(expand("<afile>"))
function! SetUTF8Xattr(file)
  let isutf8 = &fileencoding == "utf-8" || (&fileencoding == "" && &encoding == "utf-8")
  if has("unix") && match(system("uname"),'Darwin') != -1 && isutf8
    call system("xattr -w com.apple.TextEncoding 'utf-8;134217984' '" . a:file . "'")
  endif
endfunction

" }}


" {{{ plugins
"
" {{ Chalice for vim
"set runtimepath+=$HOME/.vim/chalice
let chalice_startupflags = 'bookmark'
let chalice_writeoptions = 'amp,nbsp,zenkaku'
let chalice_statusline = '%c,'
let chalice_anonyname = ''
let chalice_autonumcheck = 1
let chalice_previewflags = 'autoclose'
let chalice_reloadinterval_threadlist = 0
" }}

" {{ neocomplcache
let g:neocomplcache_enable_at_startup = 1
let g:neocomplcache_enable_smart_case = 1 
let g:neocomplcache_enable_camle_case_completion = 1
let g:neocomplcache_enable_underbar_completion = 1
let g:neocomplcache_enable_auto_select = 0
let g:neocomplcache_dictionary_filetype_lists = {
                    \ 'default' : '',
                    \ 'scheme'  : $HOME.'/.rlwrap/gosh_completions',
                    \ 'vimshell': $HOME.'/.vimshell/command_history'
                    \ }
" }}

" {{ vimfiler
let g:vimfiler_as_default_explorer = 1
" }}

" {{ fholgado's minibufexpl
let g:miniBufExplMapWindowNavVim = 1
let g:miniBufExplMapCTabSwitchBufs = 1
" highlights
"hi MBENormal               " - for buffers that have NOT CHANGED and
                            "   are NOT VISIBLE.
hi MBEChanged guibg=darkblue ctermbg=darkblue ctermfg=white             | " - for buffers that HAVE CHANGED and are
                                                                          "   NOT VISIBLE
"hi MBEVisibleNormal        " - buffers that have NOT CHANGED and are
                            "   VISIBLE
"hi MBEVisibleNormalActive  " - buffers that have NOT CHANGED and are
                            "   VISIBLE and is the active buffer
"hi MBEVisibleChanged       " - for buffers that have CHANGED and are 
                            "   VISIBLE
"hi MBEVisibleChangedActive " - buffers that have CHANGED and are VISIBLE
                             "and is the active buffer
" minibufexplorer and many useful plugins
" http://d.hatena.ne.jp/yuroyoro/20101104/1288879591
"
" }}

" {{ quickrun
let g:quickrun_config = { '*': { 'split': ''}, 'scheme': { 'command': 'gosh'}}
" }}

" {{ unite.vim
"let g:unite_enable_start_insert=1
let g:unite_split_rule = "belowright"
" fnamemodify() format
" :help filename-modifiers
let g:unite_source_file_mru_filename_format = ':p:~:.'
let g:unite_source_file_mru_time_format = ''
" buffer list
nnoremap <silent> <leader>ub :<c-u>Unite bookmark<cr>
nnoremap <silent> <leader>uf :<c-u>Unite -buffer-name=files file<cr>
nnoremap <silent> <leader>um :<c-u>Unite -buffer-name=files file_mru<cr>
" leave unite buffer
aug unite
  au! unite
  au filetype unite nnoremap <silent> <buffer> <esc><esc> :q<cr>
  au filetype unite inoremap <silent> <buffer> <esc><esc> <esc>:q<cr>
aug end
" }}

" {{ eskk
if has('vim_starting')
  let g:eskk#dictionary = {
        \       'path': "~/.skk-jisyo",
        \       'sorted': 0,
        \       'encoding': 'utf-8',
        \       }
  let g:eskk#large_dictionary = {
        \ 'path': "~/.skk-jisyo.mine",
        \ 'sorted': 0,
        \ 'encoding': 'utf-8',
        \ }
endif

let g:eskk_egg_like_newline = 0
let g:eskk_enable_completion = 0
"let g:eskk_revert_henkan_style = "okuri"
" }}

" {{ vimshell
let g:vimshell_prompt = '>>> '
let g:vimshell_user_prompt = 'fnamemodify(getcwd(), ":~")'
let g:vimshell_right_prompt = 'vimshell#vcs#info("(%s)-[%b]", "(%s)-[%b|%a]")'
let g:vimshell_execute_file_list = {}
let g:vimshell_execute_file_list['pl'] = 'perl'
let g:vimshell_execute_file_list['scm'] = 'gosh'

if isdirectory(expand("$HOME/.vim/bundle/vimproc/"))
call vimshell#set_execute_file('txt,vim,c,cpp,xml,java', 'vim')
endif

let g:vimshell_smart_case = 1
let g:vimshell_enable_auto_slash = 1
let g:vimshell_split_height = 20
let g:vimshell_split_command = 'split'
aug vimshell
  au! vimshell
  au filetype vimshell
        \  call vimshell#hook#set('chpwd', ['g:my_chpwd'])
  function! g:my_chpwd(args, context)
    call vimshell#execute('ls')
  endfunction
aug end

nmap <leader>ss <plug>(vimshell_switch)
" }}

" {{ vimproc
let g:vimproc_dll_path = $HOME . '/.vim/bundle/vimproc/autoload/proc.so'
" }}

" gauref
let g:gauref_file = '/usr/home/mytoh/.vim/bundle/gauref.vim/doc/gauche-refe.txt'

" changelog
let g:changelog_username = " "

" }}}

