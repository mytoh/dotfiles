"
"          __
"  __  __ /\_\    ___ ___   _ __   ___
" /\ \/\ \\/\ \ /' __` __`\/\`'__\/'___\
" \ \ \_/ |\ \ \/\ \/\ \/\ \ \ \//\ \__/
"  \ \___/  \ \_\ \_\ \_\ \_\ \_\\ \____\
"   \/__/    \/_/\/_/\/_/\/_/\/_/ \/____/
"
"

" NeoBundle and bundles configuration {{{
if filereadable(expand('~/.vim/config/bundle.vim'))
source $HOME/.vim/config/bundle.vim
endif
"}}}


 if isdirectory(expand('~/.vim/config'))
   source ~/.vim/config/global.vim
   source ~/.vim/config/plugins.vim
   source ~/.vim/config/scheme.vim
   source ~/.vim/config/statusline.vim
   source ~/.vim/config/tabpage.vim
 endif

"runtime! userautoload/*.vim



"  options{{{

filetype plugin indent on " required
syntax enable

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
set shiftround

set tabstop=2                  " tab size eql 2 spaces
set softtabstop=2
set shiftwidth=2               " default shift width for indents
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
set listchars=tab:^\ ,trail:-,eol:¬,extends:»,precedes:«,nbsp:%

" tags
set showfulltag

" colors
set t_Co=256
set background=dark
colorscheme jellybeans

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
silent !echo -ne "\033]12;red\007"
autocmd VimLeave * silent !echo -ne "\033]112\007"

" change cursor when insert mode
" let &t_SI .= "[4 q"
" let &t_EI .= "[2 q"

"}}}


" highlights {{{
hi clear cursorline
hi cursorline     ctermbg=237  gui=underline guibg=black
hi StatusLine     ctermfg=gray ctermbg=235 cterm=none
hi ActiveBuffer   ctermfg=232 ctermbg=244 cterm=none
hi InactiveBuffer ctermfg=gray ctermbg=235 cterm=none
hi Comment        ctermfg=244 ctermbg=234 cterm=bold
hi ColorColumn    ctermfg=white    ctermbg=234 
hi MatchParen     cterm=bold,reverse

hi TabLine        ctermfg=10  ctermbg=235
hi TabLineSel     ctermfg=111 ctermbg=234
hi TabLineFill    ctermbg=238 ctermbg=235
hi TabLineInfo    ctermfg=39  ctermbg=235

" highlight for statusline
" set colorscheme above these settings
" User1-9 => %{1-9}*
hi User1 ctermfg=white ctermbg=244 cterm=none
hi User2 ctermfg=61    ctermbg=233
hi User3 ctermfg=243    ctermbg=234
hi User4 ctermfg=59   ctermbg=235
hi User5 ctermfg=38   ctermbg=239
hi User6 ctermfg=190   ctermbg=243
hi User7 ctermfg=17   ctermbg=247
hi User8 ctermfg=95   ctermbg=251
" mode
hi User9 ctermfg=18   ctermbg=154
" }}}

command! -nargs=1 Silent
      \ | execute ':silen !'.<q-args>
      \ | execute ':redraw!'

command! -complete=command EditUtf8 :e ++enc=utf-8

command! -complete=command TrimSpace :call vimrc.trimspace()

" rename current buffer
" :Rename newfilename
command! -nargs=+ -bang -complete=file Rename let pbnr=fnamemodify(bufname('%')), ':p')
      \| exec 'f'.escape(<q-args>, '')
      \| w<bang>
      \| call delet(pbnc)

"}}}

" general keymaps{{{
let maplocalleader = ","
nmap     n nzz
nmap     N Nzz

nnoremap ; :
nnoremap : ;
nnoremap j gj
nnoremap k gk
nnoremap <space>  i<space><esc>
nnoremap <silent> <esc><esc> :nohlsearch<cr><esc>
nnoremap <silent> <tab> :<c-u>bnext<cr>
nnoremap <c-c> <esc>
nnoremap / /\v

" change word under cursor with yanked text
nnoremap <silent> ciy ciw<c-r>0<esc>:let@/=@1<cr>:noh<cr>
nnoremap <silent> cy  ce<c-r>0<esc>:let@/=@1<cr>:noh<cr>
vnoremap <silent> cy  c<c-r>0<esc>:let@/=@1<cr>:noh<cr>

nmap [vim-keymap] <nop>
nmap     <localleader>v [vim-keymap]
nnoremap <silent> [vim-keymap]w :<c-u>up<cr>
nnoremap <silent> [vim-keymap]q :<c-u>qa<cr>
nnoremap <silent> [vim-keymap]bd :<c-u>bp<bar>sp<bar>bn<bar>bd<cr>


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
func! s:goto_head() "{{{
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
func! s:goto_tail() "{{{
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

aug myautocommands
  au!
  au bufenter           *                         if expand("%:p:h") !~ '^/tmp' | silent lcd %:p:h | endif
  au bufread,bufnewfile .tmux.conf                setl filetype=tmux
  au bufread,bufnewfile *.changelog               setl filetype=changelog
  au bufread,bufnewfile *.twmrc                   setl filetype=conf
  au bufread,bufnewfile .vimshrc,.vimrc.*         setl filetype=vim
  au bufread,bufnewfile ~/.xcolours/*             setl filetype=xdefaults
  au bufread,bufnewfile ~/.xcolours/*             ColorHighlight
  au bufread,bufnewfile .mkshrc                   setl filetype=sh
  au bufread,bufnewfile {*stumpwmrc*,*sawfish/rc} setl filetype=lisp
  au bufread,bufnewfile *.fish                    setl filetype=fish
  au bufread,bufnewfile loader.conf.local         setl filetype=conf
  au bufread,bufnewfile {*.md,*.mkd,*.markdown}   set filetype=markdown
  au bufread,bufnewfile /usr/ports/UPDATING       setl filetype=changelog
  au bufread,bufnewfile *.mik                   setl filetype=xml
  au bufread,bufnewfile rc.conf.local             setl filetype=sh
  au bufread,bufnewfile *.mksh                    setl filetype=sh
  au bufwritepost       .vimrc                    source ~/.vimrc
  au bufwritepost       ~/.vim/config/bundle.vim  source ~/.vim/config/bundle.vim
  au bufwritepost       .zshrc                    Silent !zcompile ~/.zshrc
  au bufwritepost       .conkyrc                  Silent !killall -SIGUSR1  conky
  au bufwritepost       xmonad.hs                 Silent !xmonad --recompile
  au bufwritepost       *.c                       call vimrc.trimspace()
  au filetype           xdefaults                 call vimrc.xrdb()
  au filetype           help                      nnoremap q :<c-u>q<cr>
  au filetype           haskell                       ColorHighlight
  au filetype           fish                       setl equalprg=fish_indent
  " for chalice buffers
  au filetype           2ch*                      setl fencs=cp932,iso-2022-jp-3,euc-jp
  au filetype           2ch*                      let g:loaded_golden_ratio=1

  au filetype           *                         setl formatoptions-=ro
aug end

aug cch
  au!
  au winleave * set nocursorline
  au winenter,bufread * set cursorline
aug end


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


if filereadable(expand('~/.vim/config/plugins.vim'))
  source ~/.vim/config/plugins.vim
endif

" }}}

set secure

" hg clone https://vim.googlecode.com/hg/ vim
" cd vim/src
" ./configure --prefix=/home/mytoh/local --enable-multibyte --enable-perlinterp=yes --with-x --enable-xim --disable-darwin --disable-selinux --enable-fontset
" make install clean distclean

"" umlaut characters
" ^v228 ä
" ^v246 ö
" ^v235 ë

"" ansicolor
" vim2ansi.vim
" :Toansi 
" :AnsiEsc

" vim:set foldmethod=marker:
