
" Vundle and bundles configuration {{{
source $HOME/.bundles.vim
"}}}

"  options{{{

filetype plugin indent on " required
syntax enable

language messages C
language time C

set nobackup
set history=10000
set clipboard=unnamed,autoselect
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

" indent
set autoindent
set smartindent
set smarttab
set expandtab
set tabstop=2
set softtabstop=2
set shiftround
set shiftwidth=2

" search
set ignorecase
set smartcase
set hlsearch
set incsearch

set list
set listchars=tab:^\ ,trail:_

" tags
set showfulltag

" colors
set t_Co=256
colorscheme jellybeans

" statusline
set laststatus=2
set statusline=%<%1*\ %f\ %m%r%h%w\ %1*%{fugitive#statusline()}%1*%=\ %1*%Y\ %{&fenc}\ %{&ff}\ %l/%L\ %c%V%8P\ %9*(・x・)%*\ 
" highlight for statusline
" set colorscheme above
" User1-9 => %{1-9}*
hi User1 ctermfg=white ctermbg=235 cterm=none
hi User9 ctermfg=4 ctermbg=235 cterm=none
"hi link User2 Statement

" set mouse
set mouse=a
set ttymouse=xterm2

" encodings
scriptencoding=utf-8
set termencoding=utf-8
set enc=utf-8
set fenc=utf-8
set fencs=utf-8,iso-2022-jp-3,euc-jp,cp932

set helplang=ja,en
set wrapscan
set autoread
set hidden
set wildmenu
set wildmode=list:full
set shortmess=atIToO
set backspace=indent,eol,start
set splitright
set splitbelow
set fileformat=unix
set fileformats=unix,mac,dos
set autochdir
set virtualedit=all
if executable('ack')
set grepprg=ack\ -a
endif

"}}}

" funcs {{{
let s:myfunc = {}

function! s:myfunc.isos(name)
  let os = tolower(substitute(system('uname'),"\n","",""))
  return os == a:name ? 1 : 0
  unlet os
endfunction

if s:myfunc.isos('haiku')
  let g:loaded_vimproc = 1
  set rtp^=~/.vim/
endif

"}}}

" keymaps{{{
let mapleader = ","
nmap     n nzz
nmap     N Nzz
nnoremap ; :
nnoremap : ;
nnoremap <space> i<space><esc>
nnoremap <silent> <esc><esc> :nohlsearch<cr><esc>
nnoremap <leader>w :<c-u>up<cr>
nnoremap <leader>q :<c-u>qa<cr>
cnoremap <c-a>      <home>
cnoremap <c-f>      <right>
cnoremap <c-b>      <left>
" http://vim.g.hatena.ne.jp/tyru/20100116
cnoremap <c-k>      <c-\>e getcmdpos() == 1 ? '' : getcmdline()[:getcmdpos()-2]<cr>
"}}}

" autocommands{{{
aug myautocommands
  au!
  au bufread,bufnewfile .tmux.conf               set filetype=tmux
  au bufread,bufnewfile .vimshrc,.vim-bundles    set filetype=vim
  au bufread,bufnewfile *.changelog              set filetype=changelog
  au bufread,bufnewfile *.twmrc                  set filetype=conf
  au bufwritepost       .vimrc                   source $MYVIMRC
  au bufwritepost       .Xresources       silent !xrdb -remove
  au bufwritepost       .Xresources       silent !xrdb -merge ~/.Xresources
  au bufwritepost       .zshrc            silent !zcompile .zshrc
  au bufwritepost       .conkyrc          silent !killall -SIGUSR1  conky
  au filetype           scheme                   setl cindent& lispwords=define,lambda,call-with-*
  au filetype           help                     nnoremap q :<c-u>q<cr>
  " for chalice buffers
  au filetype           2ch*                     setl fencs=cp932,iso-2022-jp-3,euc-jp
  au filetype           2ch*                     let g:loaded_golden_ratio = 1

aug end

aug cch
  au!
  au winleave * set nocursorline
  au winenter,bufread * set cursorline
aug end

hi clear cursorline
hi cursorline gui=underline
hi cursorline ctermbg=237 guibg=black

if s:myfunc.isos('darwin')
  au bufwritepost * call SetUTF8Xattr(expand("<afile>"))
  function! SetUTF8Xattr(file)
    let isutf8 = &fileencoding == "utf-8" || (&fileencoding == "" && &encoding == "utf-8")
    if has("unix") && match(system("uname"),'Darwin') != -1 && isutf8
      call system("xattr -w com.apple.TextEncoding 'utf-8;134217984' '" . a:file . "'")
    endif
  endfunction
endif

" }}}

" plugins{{{
"
" Chalice {{{
"set runtimepath+=$HOME/.vim/chalice
let chalice_startupflags              = 'bookmark'
let chalice_writeoptions              = 'amp,nbsp,zenkaku'
let chalice_statusline                = '%c,'
let chalice_anonyname                 = ''
let chalice_boardlist_columns         = 9
let chalice_threadlist_lines          = 13
let chalice_autonumcheck              = 1
let chalice_previewflags              = 'autoclose'
let chalice_reloadinterval_threadlist = 0
let chalice_basedir                   = $HOME . '/.chalice'
let chalice_exbrowser                 = 'tmux new-window w3m %URL% '
aug chalice
  au!
  au filetype 2ch_thread       CMiniBufExplorer
aug END
"call mkdir($HOME.'/.chalice', 'p')
"}}}

" neocomplcache"{{{
let g:neocomplcache_enable_at_startup = 1
let g:neocomplcache_enable_smart_case = 1 
let g:neocomplcache_enable_camel_case_completion = 1
let g:neocomplcache_enable_underbar_completion = 1
let g:neocomplcache_enable_auto_select = 0
let g:neocomplcache_dictionary_filetype_lists = {
                    \ 'default'  : '',
                    \ 'scheme'   : $HOME . '/.rlwrap/gosh_completions',
                    \ 'vimshell' : $HOME . '/.vimshell/command-history'
                    \ }
"}}}

" vimfiler"{{{
let g:vimfiler_as_default_explorer = 1
" }}}

" {{{ fholgado's minibufexpl
"nnoremap gt :<c-u>MBEbn<cr>
"nnoremap gT :<c-u>MBEbp<cr>
"let g:miniBufExplMapWindowNavVim = 1
"let g:miniBufExplMapCTabSwitchBufs = 1
"let g:miniBufExplShowBufNumbers = 0
" minibufexplorer and many useful plugins
" http://d.hatena.ne.jp/yuroyoro/20101104/1288879591
"
"}}}

" quickrun{{{
if executable('gosh')
let g:quickrun_config = { '*': { 'split': ''}, 'scheme': { 'command': 'gosh'}}
endif
"}}}

" unite{{{
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
  au!
  au filetype unite nnoremap <silent> <buffer> <esc><esc> :q<cr>
  au filetype unite inoremap <silent> <buffer> <esc><esc> <esc>:q<cr>
  call unite#custom_default_action('file', 'tabopen')
  call unite#custom_default_action('bookmark', 'tabopen')
aug end
"}}}

" eskk{{{
if has('vim_starting')
        let g:eskk#dictionary = {
        \ 'path': "~/.skk-jisyo",
        \ 'sorted': 0,
        \ 'encoding': 'utf-8',
        \}
  if s:myfunc.isos("darwin")
        let g:eskk#large_dictionary = {
        \ 'path': "~/Library/Application\ Support/AquaSKK/SKK-JISYO.L",
        \ 'sorted': 1,
        \ 'encoding': 'euc-jp',
        \}
  elseif s:myfunc.isos('freebsd')
        let g:eskk#large_dictionary = {
        \ 'path': "/usr/local/share/skk/SKK-JISYO.L",
        \ 'sorted': 1,
        \ 'encoding': 'euc-jp',
        \}
  endif
endif
let g:eskk#egg_like_newline = 1
let g:eskk#enable_completion = 1
let g:eskk#select_cand_keys = "aoeuidhts"
let g:eskk#show_annotation = 1
"let g:eskk_revert_henkan_style = "okuri"
"}}}

" vimshell {{{
let g:vimshell_prompt = '>>> '
let g:vimshell_user_prompt = 'fnamemodify(getcwd(), ":~")'
let g:vimshell_right_prompt = 'vimshell#vcs#info("(%s)-[%b]", "(%s)-[%b|%a]")'

"if isdirectory(expand('~/.vim/bundle/vimproc/'))
"call vimshell#set_execute_file('txt,vim,c,h,cpp,d,xml,java', 'vim')
"endif

let g:vimshell_execute_file_list = {}
let g:vimshell_execute_file_list['pl'] = 'perl'
let g:vimshell_execute_file_list['scm'] = 'gosh'

let g:vimshell_enable_smart_case = 1
let g:vimshell_enable_auto_slash = 1
let g:vimshell_split_height = 20
let g:vimshell_split_command = 'split'
aug vimshell
  au!
  au filetype vimshell
        \  call vimshell#hook#set('chpwd', ['g:my_chpwd'])
  function! g:my_chpwd(args, context)
    call vimshell#execute('ls')
  endfunction
  "call vimshell#execute('source ~/.zshrc')
aug end

nmap <leader>ss <plug>(vimshell_switch)
"}}}

" vimproc{{{
let g:vimproc_dll_path = $HOME . '/.vim/bundle/vimproc/autoload/proc.so'
"}}}

" gauref{{{
let g:gauref_file = '/usr/home/mytoh/.vim/bundle/gauref.vim/doc/gauche-refe.txt'
"}}}

" changelog{{{
let g:changelog_username = " "
let g:changelog_username = ''
let g:changelog_spacing_errors = 0
"}}}

" open-browser {{{
let g:netrw_nogx = 1
nmap gx <Plug>(openbrowser-smart-search)
vmap gx <Plug>(openbrowser-smart-search)
" }}}

" }}}

set secure

" vim:set foldmethod=marker:

