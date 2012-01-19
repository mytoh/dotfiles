
" NeoBundle and bundles configuration {{{
source $HOME/.bundles.vim
"}}}

"  options{{{

filetype plugin indent on " required
syntax enable

language messages C
language time C

" fix problem when vim on fish shell
if $SHELL =~ '/fish$'
  set shell=zsh
endif

set nobackup
set history=10000
if has('persistent_undo')
  set undodir=~/.vim/undo
  set undofile
endif
set directory^=~/.vim/swap
set clipboard=autoselect
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
set ambiwidth=single
" key sequence timeout length (default: 1000(ms))
set timeoutlen=10000

" indent
set autoindent
set smartindent
set shiftround
set smarttab

" tab
set expandtab
set tabstop=2
set softtabstop&
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
set background=dark

" statusline {{{
set laststatus=2
" highlight for statusline
" set colorscheme above these settings
" User1-9 => %{1-9}*
hi User1 ctermfg=white ctermbg=233 cterm=none
hi User2 ctermfg=60   ctermbg=233
hi User9 ctermfg=4 ctermbg=235 cterm=none
" statusline for buftabs plugin
set stl=     " clear statusline when reloaded
set stl=%1*\    " left side
set stl+=%=  " separator
set stl+=%2*(%1*%<%{fnamemodify(getcwd(),':~')}%2*)%1*\   "get filepath
set stl+=%{fugitive#statusline()}\  "git repo info
set stl+=%y\  "filetype
set stl+=%{&dictionary}
set stl+=%{&fenc}\  "fileencoding
set stl+=%{&ff}\    "fileformat
set stl+=%2*(%1*%3.3b,%2.2B%2*)%1*\  " ascii, hex under cursor
set stl+=%2*(%1*%l,  "current line number
set stl+=%c   "columns
set stl+=/%L%2*)%1*\   "total line number
set stl+=%3p%%\  "percentage of current line
set stl+=%*    "reset color
"}}}

" set mouse
set mouse=a
set ttymouse=xterm2

" encodings
scriptencoding=utf-8
set termencoding=utf-8
set enc=utf-8

set helplang=ja,en
set wrapscan
set autoread
set hidden
set wildmenu
set wildmode=list:full
set wildignore+=*/.neocon/*
set shortmess=atIToO
set backspace=indent,eol,start
set splitright
set splitbelow
set fileformats=unix,mac,dos
set virtualedit=all
if executable('ack')
  set grepprg=ack\ -a
endif

" change cursor colour
let &t_SI  = "\<Esc>]12;orange\x7"
let &t_EI  = "\<Esc>]12;red\x7"
silent !echo -ne "\033]12;red\007"
autocmd VimLeave * silent !echo -ne "\033]112\007"

" change cursor when insert mode
let &t_SI .= "[4 q"
let &t_EI .= "[2 q"

"}}}

" funcs {{{
let s:vimrc = {}

function! s:vimrc.isos(name) dict
  let os = tolower(substitute(system('uname'),"\n","",""))
  return os == a:name ? 1 : 0
  unlet os
endfunction

if s:vimrc.isos('haiku')
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
nnoremap <leader>ff :<c-u>VimFilerTab<cr>

cnoremap <c-a>      <home>
cnoremap <c-f>      <right>
cnoremap <c-b>      <left>
" vim.g.hatena.ne.jp/tyru/20100116
cnoremap <c-k>      <c-\>e getcmdpos() == 1 ? '' : getcmdline()[:getcmdpos()-2]<cr>
"}}}

" autocommands{{{
function! s:vimrc.xrdb() dict
  if strlen(expand($DISPLAY))
    silent !xrdb -remove
    silent !xrdb -merge ~/.Xresources
  endif
endfunction

function! s:vimrc.gauche() dict
  if filereadable('~/.gosh_completions')
    setlocal dictionary=~/.gosh_completions
  endif
  if filereadable('~/.vim/syntax/scheme.vim')
    let is_gauche=1
  endif
  if executable('scmindent.scm') 
    if executable('racket')
      setlocal equalprg=scmindent.scm
    endif
  endif
  call rainbow_parenthsis#LoadSquare ()
  call rainbow_parenthsis#LoadRound ()
  call rainbow_parenthsis#Activate ()
endfunction

aug myautocommands
  au!
  au bufread,bufnewfile .tmux.conf               set filetype=tmux
  au bufread,bufnewfile *.changelog              set filetype=changelog
  au bufread,bufnewfile *.twmrc                  set filetype=conf
  au bufread,bufnewfile .vimshrc,.vim-bundles    set filetype=vim
  au bufread,bufnewfile ~/.xcolours/*            set filetype=xdefaults
  au bufread,bufnewfile ~/.xcolours/*            ColorHighlight
  au bufread,bufnewfile *.scss                   set filetype=scheme
  au bufread,bufnewfile .mkshrc                  set filetype=sh
  au filetype           xdefaults                call s:vimrc.xrdb()
  au bufwritepost       .vimrc                   source ~/.vimrc
  au bufwritepost       .zshrc                   silent !zcompile ~/.zshrc
  au bufwritepost       .conkyrc                 silent !killall -SIGUSR1  conky
  au filetype           scheme                   call s:vimrc.gauche()
  au filetype           help                     nnoremap q :<c-u>q<cr>
  au filetype           nerdtree                 let g:loaded_golden_ratio=1
  au filetype           css                      ColorHighlight
  au filetype           less                      ColorHighlight
  " for chalice buffers
  au filetype           2ch*                     setl fencs=cp932,iso-2022-jp-3,euc-jp
  au filetype           2ch*                     let g:loaded_golden_ratio=1
aug end

aug cch
  au!
  au winleave * set nocursorline
  au winenter,bufread * set cursorline
aug end

hi clear cursorline
hi cursorline gui=underline
hi cursorline ctermbg=237 guibg=black

if s:vimrc.isos('darwin')
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
aug end
"call mkdir($HOME.'/.chalice', 'p')
"}}}

" neocomplcache"{{{
let g:neocomplcache_enable_at_startup = 1
let g:neocomplcache_enable_smart_case = 1 
let g:neocomplcache_enable_ignore_case = 1 
let g:neocomplcache_enable_camel_case_completion = 1
let g:neocomplcache_enable_underbar_completion = 1
let g:neocomplcache_enable_auto_select = 0
let g:neocomplcache_dictionary_filetype_lists = {
      \ 'default'  : '',
      \ 'scheme'   : $HOME . '/.gosh_completions',
      \ 'vimshell' : $HOME . '/.vimshell/command-history' }
" Define keyword.
if !exists('g:neocomplcache_keyword_patterns')
  let g:neocomplcache_keyword_patterns = {}
endif
let g:neocomplcache_keyword_patterns['default'] = '\h\w*'
" Plugin key-mappings.
imap <C-k>     <Plug>(neocomplcache_snippets_expand)
smap <C-k>     <Plug>(neocomplcache_snippets_expand)
inoremap <expr><C-g>     neocomplcache#undo_completion()
inoremap <expr><C-l>     neocomplcache#complete_common_string()
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
"inoremap <expr><CR>  neocomplcache#close_popup() . "\<CR>"
" <C-h>, <BS>: close popup and delete backword char.
inoremap <expr><C-h> neocomplcache#smart_close_popup()."\<C-h>"
inoremap <expr><BS> neocomplcache#smart_close_popup()."\<C-h>"
inoremap <expr><C-y>  neocomplcache#close_popup()
inoremap <expr><C-e>  neocomplcache#cancel_popup()

autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType less setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType scss setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

" Enable heavy omni completion.
if !exists('g:neocomplcache_omni_patterns')
  let g:neocomplcache_omni_patterns = {}
endif
let g:neocomplcache_omni_patterns.ruby = '[^. *\t]\.\h\w*\|\h\w*::'
"autocmd FileType ruby setlocal omnifunc=rubycomplete#Complete
let g:neocomplcache_omni_patterns.php = '[^. \t]->\h\w*\|\h\w*::'
let g:neocomplcache_omni_patterns.c = '\%(\.\|->\)\h\w*'
let g:neocomplcache_omni_patterns.cpp = '\h\w*\%(\.\|->\)\h\w*\|\h\w*::'

" For snippet_complete marker.
if has('conceal')
  set conceallevel=2 concealcursor=i
endif
"}}}

" vimfiler"{{{
let g:vimfiler_execute_file_list = {
      \ 'mkv' : 'mplayer',
      \ 'mpg' : 'mplayer',
      \ 'mp4' : 'mplayer',
      \ 'jpg' : 'feh',
      \ 'JPG' : 'feh',
      \ 'png' : 'feh',
      \ 'cbz' : 'comix',
      \ 'cbr' : 'comix',
      \}
call vimfiler#set_extensions(
      \ 'archive', 'xz,txz,cbz,cbr,lzh,zip,gz,bz2,cab,rar,7z,tgz,tar'
      \)

let g:vimfiler_as_default_explorer = 1
let g:vimfiler_safe_mode_by_default = 0
" }}}

" {{{ fholgado's minibufexpl
"nnoremap gt :<c-u>MBEbn<cr>
"nnoremap gT :<c-u>MBEbp<cr>
"let g:miniBufExplMapWindowNavVim = 1
"let g:miniBufExplMapCTabSwitchBufs = 1
"let g:miniBufExplShowBufNumbers = 0
"let g:miniBufExplSplitBelow = 0
"let g:statusLineText = ''
" minibufexplorer and many useful plugins
" d.hatena.ne.jp/yuroyoro/20101104/1288879591
"
"}}}

"{{{ rson's bufstat
nnoremap gn :<c-u>bnext<cr>
nnoremap gp :<c-u>bNext<cr>
let g:bufstat_debug = 1
let g:bufstat_surround_buffers = ':'
let g:bufstat_number_before_bufname = 0

highlight StatusLine ctermfg=gray ctermbg=235 cterm=none
highlight ActiveBuffer ctermfg=blue ctermbg=235 cterm=none
highlight InactiveBuffer ctermfg=gray ctermbg=235 cterm=none
let g:bufstat_active_hl_group = "ActiveBuffer"
let g:bufstat_inactive_hl_group = "InactiveBuffer"

"}}}

" quickrun{{{
let g:quickrun_config = {}
let g:quickrun_config['*'] = { 'runmode': "async:remote:vimproc", 'split': 'below', 'scheme': { 'command': 'gosh'}}
"}}}

" unite{{{

let g:unite_enable_start_insert=1
let g:unite_split_rule = "belowright"
" fnamemodify() format
" :help filename-modifiers
let g:unite_source_file_mru_filename_format = ':p:~:.'
let g:unite_source_file_mru_time_format = ''
let g:unite_cursor_line_highlight = 'TabLineSel'
" let g:unite_abbr_highlight = 'TabLine'

" keymaps
nnoremap [unite] <Nop>
nmap     <Leader>u [unite]
nnoremap <silent> [unite]f  :<C-u>UniteWithBufferDir -buffer-name=files -prompt=%\  buffer file_mru bookmark file<CR>
nnoremap <silent> [unite]c  :<C-u>UniteWithCurrentDir -buffer-name=files buffer file_mru bookmark file<CR>
nnoremap <silent> [unite]b :<c-u>Unite bookmark<cr>
nnoremap <silent> [unite]m :<c-u>Unite -buffer-name=files file_mru<cr>

autocmd FileType unite call s:unite_my_settings()
function! s:unite_my_settings()"{{{
  " Overwrite settings.
  imap <buffer> <C-w>     <Plug>(unite_delete_backward_path)
  " <C-l>: manual neocomplcache completion.
  inoremap <buffer> <C-l>  <C-x><C-u><C-p><Down>
  "call unite#custom_default_action('file', 'tabopen')
  "call unite#custom_default_action('bookmark', 'tabopen')
endfunction "}}}
"}}}

" unite-launch {{{
    let g:unite_launch_apps = [
	  \ 'rake',
	  \ 'make',
    \ 'scss2css',
	  \ 'git pull',
	  \ 'git push' ]
"}}}

" eskk{{{
if has('vim_starting')
  let g:eskk#dictionary = {
        \ 'path': "~/.skk-jisyo",
        \ 'sorted': 0,
        \ 'encoding': 'utf-8',
        \}
  if s:vimrc.isos("darwin")
    let g:eskk#large_dictionary = {
          \ 'path': "~/Library/Application\ Support/AquaSKK/SKK-JISYO.L",
          \ 'sorted': 1,
          \ 'encoding': 'euc-jp',
          \}
  elseif s:vimrc.isos('freebsd')
    let g:eskk#large_dictionary = {
          \ 'path': "/usr/local/share/skk/SKK-JISYO.L",
          \ 'sorted': 1,
          \ 'encoding': 'euc-jp',
          \}
  endif
endif

"---
" http://kstn.fc2web.com/seikana_zisyo.html
au myautocommands User eskk-initialize-pre call s:eskk_initial_pre()
function! s:eskk_initial_pre()
  " User can be allowed to modify
  " eskk global variables (`g:eskk#...`)
  " until `User eskk-initialize-pre` event.
  " So user can do something heavy process here.
  " (I'm a paranoia, eskk#table#new() is not so heavy.
  " But it loads autoload/vice.vim recursively)
  let t = eskk#table#new('rom_to_hira*', 'rom_to_hira')
  call t.add_map('gwa', 'ぐゎ')
  call t.add_map('gwe', 'ぐぇ')
  call t.add_map('gwi', 'ぐぃ')
  call t.add_map('gwo', 'ぐぉ')
  call t.add_map('gwu', 'ぐ')
  call t.add_map('kwa', 'くゎ')
  call t.add_map('kwe', 'くぇ')
  call t.add_map('kwi', 'くぃ')
  call t.add_map('kwo', 'くぉ')
  call t.add_map('kwu', 'く')
  call t.add_map('we', 'ゑ')
  call t.add_map('wha', 'うぁ')
  call t.add_map('whe', 'うぇ')
  call t.add_map('whi', 'うぃ')
  call t.add_map('who', 'うぉ')
  call t.add_map('whu', 'う')
  call t.add_map('wi', 'ゐ')
  call t.add_map(':',':')
  call t.add_map(';',';')
  call t.add_map('!','!')
  call t.add_map('?','?')
  call t.add_map('{','『')
  call t.add_map('}','』')
  call eskk#register_mode_table('hira', t)
endfunction
"---

let g:eskk#egg_like_newline = 1
let g:eskk#enable_completion = 1
let g:eskk#select_cand_keys = "aoeuidhts"
let g:eskk#show_annotation = 1
"let g:eskk_revert_henkan_style = "okuri"
"}}}

" vimshell {{{

let g:vimshell_user_prompt = '"┌─" . "(" . fnamemodify(getcwd(), ":~") . ")"'
let g:vimshell_prompt = '└┈╸ '
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
  au filetype vimshell  call vimshell#hook#set('chpwd', ['g:my_chpwd'])
  au filetype vimshell  call unite#custom_default_action('vimshell/history', 'insert')
  function! g:my_chpwd(args, context)
    call vimshell#execute('ls')
  endfunction
  "inoremap <buffer> <expr><silent> <C-l>  unite#sources#vimshell_history#start_complete()
		inoremap <buffer><expr> <C-l> unite#start_complete(
		\ ['vimshell/history'], {
		\ 'start_insert' : 0,
		\ 'input' : vimshell#get_cur_text()})
aug end

nnoremap [vimshell] <nop>
nmap     <leader>s [vimshell]
nmap <silent> [vimshell]s <Plug>(vimshell_split_create)
nmap <silent> [vimshell]c <Plug>(vimshell_create)
nnoremap <silent> [vimshell]p :<c-u>VimShellPop<cr>
"}}}

" vimproc{{{
let g:vimproc_dll_path = $HOME . '/.bundle/vimproc/autoload/proc.so'
"}}}

" gauref{{{
let g:gauref_file = $HOME . '/.bundle/gauref.vim/doc/gauche-refj.txt'
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
let g:openbrowser_open_rules = { 'w3m': '{browser} {shellescape(uri)} ', }
" }}}

" ambicmd {{{
cnoremap <expr> <Space> ambicmd#expand("\<Space>")
cnoremap <expr> <CR>    ambicmd#expand("\<CR>")

" }}}

" mpc.vim {{{
let g:mpd_host = "localhost"
let g:mpd_port = "6600"
" }}}

" gist.vim {{{
if s:vimrc.isos('darwin')
    let g:gist_clip_command = 'pbcopy'
  elseif s:vimrc.isos('freebsd')
    let g:gist_clip_command = 'xclip -selection clipboard'
endif

let g:gist_detect_filetype = 1

" show private gists with ':Gist -l'
let g:gist_show_privates = 1
"}}}

" sudo.vim {{{
"let g:sudoAuth="ssh"
"let g:sudoAuthArg="root@localhost"
" }}}

" ctrlp.vim {{{

let g:ctrlp_working_path_mode = 2

" }}}

" syntastic {{{
let g:syntastic_enable_balloons = 1
let g:syntastic_enable_highlighting = 1
let g:syntastic_enable_signs = 1
let g:syntastic_auto_loc_list = 2
" }}}

" indent-guides {{{
let g:indent_guides_guide_size = 1
let g:indent_guides_start_level = 2
autocmd VimEnter,ColorScheme * :hi IndentGuidesOdd ctermbg=235
autocmd VimEnter,ColorScheme * :hi IndentGuidesEven ctermbg=233
" }}}


" }}}

set secure

" hg clone https://vim.googlecode.com/hg/ vim
" cd vim/src
" ./configure --prefix=/home/mytoh/local --enable-multibyte --enable-perlinterp=yes --with-x --enable-xim --disable-darwin --disable-selinux --enable-fontset
" make install clean distclean

" vim:set foldmethod=marker:

