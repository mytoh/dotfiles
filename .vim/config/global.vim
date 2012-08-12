
" funcs {{{
let vimrc = {}

function! vimrc.isos(name) dict
  let os = tolower(substitute(system('uname'),"\n","",""))
  return os == a:name ? 1 : 0
  unlet os
endfunction

if vimrc.isos('haiku')
  let g:loaded_vimproc = 1
  set rtp^=~/.vim/
endif

" remove trailing spaces {{{
function! vimrc.trimspace() dict
  silent! %s/\s\+$//
  ''
endfunction
" }}}

function! vimrc.trimspacelisp() dict
  " trim space for lisp file
  silent! %s/(\s\+/(/
  silent! %s/)\s\+)/))/
  ''
endfunction

" vital {{{
let vimrc.V  = vital#of('vital')
let vimrc.P  = vimrc.V.import('Prelude')
let vimrc.M  = vimrc.V.import('Mapping')
let vimrc.L  = vimrc.V.import('Data.List')
let vimrc.F  = vimrc.V.import('System.File')
let vimrc.FP = vimrc.V.import('System.Filepath')
" }}}


function! vimrc.xrdb() dict
  if strlen(expand($DISPLAY))
    Silent !xrdb -remove
    Silent !xrdb -merge ~/.Xresources
  endif
endfunction

function! vimrc.scheme()
  setlocal lisp
  setlocal cindent&
  setlocal iskeyword=@,33,35-38,42-43,45-58,60-64,94,_,126,.
  if executable('scmindent.scm')
    if executable('racket')
      setlocal equalprg=scmindent.scm
    endif
  endif
  let g:vimshell_split_command = 'vsplit'
  nnoremap <buffer><silent><LocalLeader>gi  :VimShellInteractive gosh<cr>
  nnoremap <buffer><silent><LocalLeader>gs <S-v>:VimShellSendString<cr>
  vmap     <buffer><silent><LocalLeader>gs :VimShellSendString<cr>
endfunction

function! vimrc.scheme_bufwritepost() dict
  silent! call vimrc.trimspacelisp()
  silent! call vimrc.trimspace()
endfunction

" }}}


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
set background=dark
colorscheme peachpuff
let g:molokai_original = 1

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


" highlights {{{
highlight clear cursorline
highlight cursorline     ctermbg=237  gui=underline guibg=black
highlight StatusLine     ctermfg=gray ctermbg=235 cterm=none
highlight ActiveBuffer   ctermfg=232 ctermbg=244 cterm=none
highlight InactiveBuffer ctermfg=gray ctermbg=235 cterm=none
highlight Comment        ctermfg=244 ctermbg=234 cterm=bold
highlight ColorColumn    ctermfg=white    ctermbg=234 
highlight MatchParen     cterm=bold,reverse

highlight TabLine       ctermfg=10  ctermbg=235
highlight TabLineSel    ctermfg=220 ctermbg=239
highlight TabLineFill   ctermbg=238 ctermbg=235
highlight TabLineInfo   ctermfg=39  ctermbg=235
highlight TabLineSep    ctermbg=218  ctermbg=235

" highlight for statusline
" User1-9 => %{1-9}*
highlight User1 ctermfg=white ctermbg=244 cterm=none
highlight User2 ctermfg=172    ctermbg=233
highlight User3 ctermfg=243    ctermbg=234
highlight User4 ctermfg=59   ctermbg=235
highlight User5 ctermfg=38   ctermbg=239
highlight User6 ctermfg=190   ctermbg=243
highlight User7 ctermfg=17   ctermbg=247
highlight User8 ctermfg=95   ctermbg=251
" mode
highlight User9 ctermfg=18   ctermbg=154
" }}}

command! -nargs=1 Silent
      \ | execute ':silen !'.<q-args>
      \ | execute ':redraw!'

command! -complete=command EditUtf8 :e ++enc=utf-8

command! -complete=command TrimSpace :call vimrc.trimspace()

" rename current buffer
" :Rename newfilename
command! -nargs=+ -bang -complete=file Rename let pbnr=fnamemodify(bufname('%')), ':p')
      \| execute 'f'.escape(<q-args>, '')
      \| w<bang>
      \| call delet(pbnc)


" general keymaps{{{
let maplocalleader = ","
nmap     n nzz
nmap     N Nzz

inoremap <c-c> <esc>

nnoremap ; :
nnoremap : ;
nnoremap j gj
nnoremap k gk
nnoremap <space>  i<space><esc>
nnoremap <silent> <esc><esc> :nohlsearch<cr><esc>
nnoremap <silent> <tab> :<c-u>bnext<cr>
nnoremap <c-c> <esc>
nnoremap / /\v
nnoremap Q <nop>

nnoremap <tab> %
vnoremap <tab> %

" change word under cursor with yanked text
nnoremap <silent> ciy ciw<c-r>0<esc>:let@/=@1<cr>:noh<cr>
nnoremap <silent> cy  ce<c-r>0<esc>:let@/=@1<cr>:noh<cr>
vnoremap <silent> cy  c<c-r>0<esc>:let@/=@1<cr>:noh<cr>

nmap [vim-keymap] <nop>
nmap     <localleader>v [vim-keymap]
nnoremap <silent> [vim-keymap]w :<c-u>up<cr>
nnoremap <silent> [vim-keymap]q :<c-u>qa<cr>
nnoremap <silent> [vim-keymap]bd :<c-u>bp<bar>sp<bar>bn<bar>bd<cr>

cnoremap <Leader><Leader> ~/
cnoremap <c-a>      <home>
" vim.g.hatena.ne.jp/tyru/20100116
cnoremap <silent><c-k>      <c-\>e getcmdpos() == 1 ? '' : getcmdline()[:getcmdpos()-2]<cr>

" clipboard copy and paste {{{
" Linux環境でのクリップボードコピー
" if has('unix')
"   vnoremap y "+y
"   imap <C-I> <ESC>"*pa
" endif

" bubbling text
" vimcasts.org/episodes/bubbling-text
if isdirectory(expand('$HOME/.bundle/vim-unimpaired'))
  " bubbse single line
  nmap <s-up> [e
  nmap <s-down> ]e
  " bubble multiple lines
  vmap <s-up> [egv
  vmap <s-down> ]egv
else
  nmap <s-up> ddkP
  nmap <s-down> ddp
  vmap <s-up> xkP`[V`]
  vmap <s-down> xp`[V`]
endif
"}}}

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

nmap <C-w>r :<C-u>call <SID>resizeWindow()<CR>mws
" }}}

" forward/backward word
inoremap <silent> <c-b> <s-left>
inoremap <silent> <c-f> <s-right>

" better C-a C-e  {{{
" http://vim.g.hatena.ne.jp/tyru/20100305
" goto head, or tail
inoremap <expr> <C-a> <SID>goto_head()
function! s:goto_head() "{{{
  let col       = col('.')
  let lnum      = line('.')
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
function! s:goto_tail() "{{{
  let col       = col('.')
  let lnum      = line('.')
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

augroup myautocommands
  autocmd!
  autocmd bufenter           *                         if expand("%:p:h") !~ '^/tmp' | silent lcd %:p:h | endif
  autocmd bufread,bufnewfile .tmux.conf                setl filetype=tmux
  autocmd bufread,bufnewfile *.changelog               setl filetype=changelog
  autocmd bufread,bufnewfile *.twmrc                   setl filetype=conf
  autocmd bufread,bufnewfile .vimshrc,.vimrc.*         setl filetype=vim
  autocmd bufread,bufnewfile ~/.xcolours/*             setl filetype=xdefaults
  autocmd bufread,bufnewfile ~/.xcolours/*             ColorHighlight
  autocmd bufread,bufnewfile .mkshrc                   setl filetype=sh
  autocmd bufread,bufnewfile {*stumpwmrc*,*sawfish/rc} setl filetype=lisp
  autocmd bufread,bufnewfile *.fish                    setl filetype=fish
  autocmd bufread,bufnewfile loader.conf.local         setl filetype=conf
  autocmd bufread,bufnewfile {*.md,*.mkd,*.markdown}   set filetype=markdown
  autocmd bufread,bufnewfile /usr/ports/UPDATING       setl filetype=changelog
  autocmd bufread,bufnewfile *.mik                   setl filetype=xml
  autocmd bufread,bufnewfile rc.conf.local             setl filetype=sh
  autocmd bufread,bufnewfile *.mksh                    setl filetype=sh
  autocmd bufwritepost       .vimrc                    source ~/.vimrc
  autocmd bufwritepost       ~/.vim/config/bundle.vim  source ~/.vim/config/bundle.vim
  autocmd bufwritepost       .zshrc                    Silent !zcompile ~/.zshrc
  autocmd bufwritepost       .conkyrc                  Silent !killall -SIGUSR1  conky
  autocmd bufwritepost       xmonad.hs                 Silent !xmonad --recompile
  autocmd bufwritepost       *.c                       call vimrc.trimspace()
  autocmd filetype           xdefaults                 call vimrc.xrdb()
  autocmd filetype           help                      nnoremap q :<c-u>q<cr>
  autocmd filetype           haskell                       ColorHighlight
  autocmd filetype           fish                       setl equalprg=fish_indent
  " for chalice buffers
  autocmd filetype           2ch*                      setl fencs=cp932,iso-2022-jp-3,euc-jp
  autocmd filetype           2ch*                      let g:loaded_golden_ratio=1

  autocmd filetype           *                         setl formatoptions-=ro
augroup end

augroup cch
  autocmd!
  autocmd winleave * set nocursorline
  autocmd winenter,bufread * set cursorline
augroup end


if vimrc.P.is_mac()
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
  autocmd!
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
