
" NeoBundle and bundles configuration {{{
source $HOME/.bundles.vim
"}}}

" singleton.vim {{{
if has('clientserver')
  " if exists("g:singleton#opener")
  call singleton#enable()
"   endif
endif
"}}}

"  options{{{

filetype plugin indent on " required
syntax enable

language messages C
language time C

" fix problem when vim on fish shell
if $SHELL =~ '/fish$'
  set shell=bash
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
set display+=lastline
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
set background=dark
colorscheme molokai


" set mouse
set mouse=a
set ttymouse=xterm2

" encodings
scriptencoding=utf-8
set termencoding=utf-8
set enc=utf-8

set helplang=en,ja
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
set nomore
set imdisable

" columns {{{
set textwidth=80
set colorcolumn=+1

" }}}

"show replace end
set cpoptions+=$

if executable('ack')
  set grepprg=ack\ -a
endif

" change cursor colour
let &t_SI  = "\<Esc>]12;orange\x7"
let &t_EI  = "\<Esc>]12;red\x7"
silent !echo -ne "\033]12;red\007"
autocmd VimLeave * silent !echo -ne "\033]112\007"

" change cursor when insert mode
" let &t_SI .= "[4 q"
" let &t_EI .= "[2 q"

"}}}

" statusline {{{
set laststatus=2
" highlight for statusline
" set colorscheme above these settings
" User1-9 => %{1-9}*
hi User1 ctermfg=white ctermbg=244 cterm=none
hi User2 ctermfg=61    ctermbg=233
hi User3 ctermfg=243    ctermbg=234
hi User4 ctermfg=59   ctermbg=235
hi User5 ctermfg=38   ctermbg=239
hi User6 ctermfg=24   ctermbg=243
hi User7 ctermfg=17   ctermbg=247
hi User8 ctermfg=95   ctermbg=251
hi User9 ctermfg=233   ctermbg=255 

function! GetCharCode() " {{{ from powerline
" Get the output of :ascii
redir => ascii
silent! ascii
redir END

if match(ascii, 'NUL') != -1
return 'NUL'
endif

" Zero pad hex values
let nrformat = '0x%02x'

let encoding = (&fenc == '' ? &enc : &fenc)

if encoding == 'utf-8'
" Zero pad with 4 zeroes in unicode files
let nrformat = '0x%04x'
endif

" Get the character and the numeric value from the return value of :ascii
" This matches the two first pieces of the return value, e.g.
" "<F> 70" => char: 'F', nr: '70'
let [str, char, nr; rest] = matchlist(ascii, '\v\<(.{-1,})\>\s*([0-9]+)')

" Format the numeric value
let nr = printf(nrformat, nr)

return "'". char ."' ". nr
endfunction "}}}

" statusline
set stl=     " clear statusline when reloaded

set stl=%2*\    " left side

set stl+=%=  " separator

set stl+=%3*
set stl+=\ 
set stl+=%<%{fnamemodify(getcwd(),':~')}   "get filepath
set stl+=\ 

set stl+=%4*
set stl+=%{fugitive#statusline()}  "git repo info

set stl+=%5*
set stl+=\ 
set stl+=%{&dictionary}
set stl+=%{&fileformat}\ 
set stl+=<\ 
set stl+=%{&fenc}\ 
set stl+=<\ 
set stl+=%{&filetype}\ 

set stl+=%6*
set stl+=\ 
set stl+=%{GetCharCode()}\  " hex under cursor

set stl+=%7*
set stl+=%3p%%\  "percentage of current line
set stl+=%*    "reset color

set stl+=%8*
set stl+=\ 
set stl+=%l,  "current line number
set stl+=%c   "columns
set stl+=/%L   "total line number
set stl+=\ 


" change StatusLine color when insert mode {{{
" http://sites.google.com/site/fudist/Home/vim-nihongo-ban/vim-color#color-theme-mod
let g:hi_insert = 'highlight StatusLine ctermfg=blue ctermbg=yellow 
                   \cterm=none guifg=darkblue guibg=darkyellow gui=none'
if has('sytax')
  augroup InsertHook
    autocmd!
    autocmd InsertEnter * call s:StatusLine('Enter')
    autocmd InsertLeave * call s:StatusLine('Leave')
  augroup END
endif

let s:slhlcmd = ''
function! s:StatusLine(mode)
  if a:mode == 'Enter'
    silent! let s:slhlcmd = 'highlight' . s:GetHighlight('StatusLine')
    silent exec g:hi_insert
  else
    highlight clear StatusLine
    silent exec s:slhlcmd
  endif
endfunction

function! s:GetHighlight(hi)
  redir => hl
  exec 'highlight' . a:hi
  redir END
  let hl = substitute(hl, '[\r\n]', '', 'g')
  let hl = substitute(hl, 'xxx', '', '')
  return hl
endfunction
"}}}
  
"}}}

" highlights {{{
hi clear cursorline
hi cursorline     ctermbg=237  gui=underline guibg=black
hi StatusLine     ctermfg=gray ctermbg=235 cterm=none
hi ActiveBuffer   ctermfg=blue ctermbg=230 cterm=none
hi InactiveBuffer ctermfg=gray ctermbg=235 cterm=none
hi Comment        ctermfg=244 ctermbg=234 cterm=bold
hi ColorColumn ctermbg=234

" }}}

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

" remove trailing spaces
function! s:vimrc.trimspace() dict
  %s/\s*$//
  ''
endfunction
command! -complete=command TrimSpace :call s:vimrc.trimspace()

command! -nargs=1 Silent
      \ | execute ':silen !'.<q-args>
      \ | execute ':redraw!'

"}}}

" keymaps{{{
let mapleader = ","
nmap     n nzz
nmap     N Nzz

nnoremap ; :
nnoremap : ;
nnoremap Y y$
nnoremap <space> i<space><esc>
nnoremap <silent> <esc><esc> :nohlsearch<cr><esc>
nnoremap <tab> :<c-u>bnext<cr>
nnoremap <c-c> <esc>

nmap [vim-keymap] <nop>
nmap     <leader>v [vim-keymap]
nnoremap <silent> [vim-keymap]w :<c-u>up<cr>
nnoremap <silent> [vim-keymap]q :<c-u>qa<cr>
nnoremap <silent> [vim-keymap]bd :<c-u>bp<bar>sp<bar>bn<bar>bd<cr>


nnoremap <leader>ff :<c-u>VimFilerTab<cr>
cnoremap <c-a>      <home>
cnoremap <c-f>      <right>
cnoremap <c-b>      <left>
" vim.g.hatena.ne.jp/tyru/20100116
cnoremap <c-k>      <c-\>e getcmdpos() == 1 ? '' : getcmdline()[:getcmdpos()-2]<cr>

" window resize {{{
function! s:resizeWindow()
	call submode#enter_with('winsize', 'n', '', 'mws', '<Nop>')
	call submode#leave_with('winsize', 'n', '', '<Esc>')

	let curwin = winnr()
	wincmd j | let target1 = winnr() | exe curwin "wincmd w"
	wincmd l | let target2 = winnr() | exe curwin "wincmd w"


	execute printf("call submode#map ('winsize', 'n', 'r', 'j', '<C-w>%s')", curwin == target1 ? "-" : "+")
	execute printf("call submode#map ('winsize', 'n', 'r', 'k', '<C-w>%s')", curwin == target1 ? "+" : "-")
	execute printf("call submode#map ('winsize', 'n', 'r', 'h', '<C-w>%s')", curwin == target2 ? ">" : "<")
	execute printf("call submode#map ('winsize', 'n', 'r', 'l', '<C-w>%s')", curwin == target2 ? "<" : ">")

endfunction

nmap <C-w>r	:<C-u>call <SID>resizeWindow()<CR>mws
" }}}

" better C-a C-e  {{{
" http://vim.g.hatena.ne.jp/tyru/20100305
" goto head, or tail 
inoremap <expr> <C-a> <SID>goto_head()
func! s:goto_head() "{{{
  let col = col('.')
  let lnum = line('.')
  let tilde_col = match(getline(lnum),'\S')+1

  if col > tilde_col
    " go to ^ pos.
    return "\<C-o>^"
  else
    " go to head.
    return "\<Home>"
  endif
endfunc "}}}

inoremap <expr> <C-e> <SID>goto_tail()
func! s:goto_tail() "{{{
  let col = col('.')
  let lnum = line('.')
  let tilde_col = match(getline(lnum), '\S')+1
  
  if col < tilde_col
    "go to ^ pos
    return "\<C-o>"
  else
    "go to tail
    return "\<End>"
  endif
endfunc "}}}
  "}}}

"}}}

" autocommands{{{
function! s:vimrc.xrdb() dict
  if strlen(expand($DISPLAY))
    Silent !xrdb -remove
    Silent !xrdb -merge ~/.Xresources
  endif
endfunction

function! s:vimrc.gauche() dict
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
  au bufread,bufnewfile .tmux.conf               setl filetype=tmux
  au bufread,bufnewfile *.changelog              setl filetype=changelog
  au bufread,bufnewfile *.twmrc                  setl filetype=conf
  au bufread,bufnewfile .vimshrc,.vim-bundles    setl filetype=vim
  au bufread,bufnewfile ~/.xcolours/*            setl filetype=xdefaults
  au bufread,bufnewfile ~/.xcolours/*            ColorHighlight
  au bufread,bufnewfile *.scss                   setl filetype=scheme
  au bufread,bufnewfile *.stub                   setl filetype=scheme
  au bufread,bufnewfile .gaucherc                setl filetype=scheme
  au bufread,bufnewfile .mkshrc                  setl filetype=sh
  au bufread,bufnewfile *stumpwmrc*              setl filetype=lisp
  au bufread,bufnewfile *sawfish/rc              setl filetype=lisp
  au bufread,bufnewfile *.fish                   setl filetype=fish
  au bufread,bufnewfile loader.conf.local        setl filetype=conf
  au bufwritepost       .vimrc                   source ~/.vimrc
  au bufwritepost       .zshrc                   Silent !zcompile ~/.zshrc
  au bufwritepost       .conkyrc                 Silent !killall -SIGUSR1  conky
  au bufwritepost       xmonad.hs                Silent !xmonad --recompile
  au filetype           xdefaults                call s:vimrc.xrdb()
  au filetype           scheme                   call s:vimrc.gauche()
  au filetype           help                     nnoremap q :<c-u>q<cr>
  au filetype           nerdtree                 let g:loaded_golden_ratio=1
  au filetype           css,less                      ColorHighlight
  au filetype           haskell                      ColorHighlight
  au filetype           fish                      setl equalprg=fish_indent
  " for chalice buffers
  au filetype           2ch*                     setl fencs=cp932,iso-2022-jp-3,euc-jp
  au filetype           2ch*                     let g:loaded_golden_ratio=1
aug end

aug cch
  au!
  au winleave * set nocursorline
  au winenter,bufread * set cursorline
aug end


if s:vimrc.isos('darwin')
  au bufwritepost * call SetUTF8Xattr(expand("<afile>"))
  function! SetUTF8Xattr(file)
    let isutf8 = &fileencoding == "utf-8" || (&fileencoding == "" && &encoding == "utf-8")
    if has("unix") && match(system("uname"),'Darwin') != -1 && isutf8
      call system("xattr -w com.apple.TextEncoding 'utf-8;134217984' '" . a:file . "'")
    endif
  endfunction
endif

" Restore cursor position to where it was before
augroup JumpCursorOnEdit
   au!
   autocmd BufReadPost *
            \ if expand("<afile>:p:h") !=? $TEMP |
            \ if line("'\"") > 1 && line("'\"") <= line("$") |
            \ let JumpCursorOnEdit_foo = line("'\"") |
            \ let b:doopenfold = 1 |
            \ if (foldlevel(JumpCursorOnEdit_foo) > foldlevel(JumpCursorOnEdit_foo - 1)) |
            \ let JumpCursorOnEdit_foo = JumpCursorOnEdit_foo - 1 |
            \ let b:doopenfold = 2 |
            \ endif |
            \ exe JumpCursorOnEdit_foo |
            \ endif |
            \ endif
" Need to postpone using "zv" until after reading the modelines.
   autocmd BufWinEnter *
            \ if exists("b:doopenfold") |
            \ exe "normal zv" |
            \ if(b:doopenfold > 1) |
            \ exe "+".1 |
            \ endif |
            \ unlet b:doopenfold |
            \ endif
augroup END

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
" let g:neocomplcache_enable_camel_case_completion = 1
" let g:neocomplcache_enable_underbar_completi on = 1
let g:neocomplcache_enable_fuzzy_completion = 1
let g:neocomplcache_enable_auto_select = 0
let g:neocomplcache_dictionary_filetype_lists = {
      \ 'default'  : '',
      \ 'scheme'   : $RLWRAP_HOME . '/gosh_completions',
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
inoremap <expr><CR>  neocomplcache#close_popup() . "\<CR>"
" <C-h>, <BS>: close popup and delete backword char.
inoremap <expr><C-h> neocomplcache#smart_close_popup()."\<C-h>"
inoremap <expr><BS> neocomplcache#smart_close_popup()."\<C-h>"
inoremap <expr><C-y>  neocomplcache#close_popup()

autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType less setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType scss setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

" For snippet_complete marker.
if has('conceal')
  set conceallevel=2 concealcursor=i
endif

" snippet directory
let g:neocomplcache_snippets_dir='~/.vim/snippets'


" force cache dict when insert
autocmd InsertEnter * call s:neco_pre_cache()
function! s:neco_pre_cache()
  if exists('b:neco_pre_cache')
    return
  endif
  let b:neco_pre_cache = 1
  if bufname('%') =~ g:neocomplcache_lock_buffer_name_pattern
    return
  endif
  :NeoComplCacheCachingBuffer
  :NeoComplCacheCachingDictionary
endfunction
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
let g:bufstat_surround_buffers = '(:)'
let g:bufstat_number_before_bufname = 0

let g:bufstat_active_hl_group = "StatusLine"
let g:bufstat_inactive_hl_group = "StatusLine"

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

" auto session loading
" let g:unite_source_session_enable_auto_save = 1
" autocmd VimEnter * UniteSessionLoad


" keymaps
nnoremap [unite] <Nop>
nmap     <Leader>u [unite]
nnoremap <silent> [unite]f  :<C-u>UniteWithBufferDir -buffer-name=files -prompt=%\  buffer file<CR>
nnoremap <silent> [unite]c  :<C-u>UniteWithCurrentDir -buffer-name=files buffer file<CR>
nnoremap <silent> [unite]b :<c-u>Unite bookmark<cr>
nnoremap <silent> [unite]m :<c-u>Unite -buffer-name=files file_mru<cr>
nnoremap <silent> [unite]l :<c-u>Unite launcher<cr>

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
" let g:vimshell_right_prompt = 'vcs#info("(%s)-[%b]", "(%s)-[%b|%a]")'

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
nmap     <silent> [vimshell]s <Plug>(vimshell_split_create)
nmap     <silent> [vimshell]c <Plug>(vimshell_create)
nnoremap <silent> [vimshell]p :<c-u>VimShellPop<cr>
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
let g:indent_guides_enable_on_vim_startup = 0
let g:indent_guides_guide_size = 1
let g:indent_guides_start_level = 2
let g:indent_guides_space_guides = 1
let g:indent_guides_auto_colors = 0
autocmd VimEnter,ColorScheme * :hi IndentGuidesOdd ctermbg=236
autocmd VimEnter,ColorScheme * :hi IndentGuidesEven ctermbg=233
" }}}

" scheme.vim {{{
" not work on autocmd
let is_gauche=1
" }}}

" nerdtree {{{
let NERDSpaceDelims = 1
" }}}

" syntastic {{{
let g:syntastic_mode_map = { 'mode': 'active',
      \ 'active_filetypes': ['ruby', 'javascript'],
      \ 'passive_filetypes': ['puppet'] }
" }}}

" slimv {{{
let g:slimv_keybindings = 3
" }}}

" }}}

set secure

" hg clone https://vim.googlecode.com/hg/ vim
" cd vim/src
" ./configure --prefix=/home/mytoh/local --enable-multibyte --enable-perlinterp=yes --with-x --enable-xim --disable-darwin --disable-selinux --enable-fontset
" make install clean distclean

" vim:set foldmethod=marker:


