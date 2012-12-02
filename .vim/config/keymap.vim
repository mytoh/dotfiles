
" general keymaps{{{
let maplocalleader = ","
nmap     n nzz
nmap     N Nzz

inoremap <c-c> <esc>
" inoremap <esc> <nop>
nnoremap <c-c> <esc>
" nnoremap <esc> <nop>
vnoremap <c-c> <esc>
" vnoremap <esc> <nop>

nnoremap ; :
nnoremap : ;
" nnoremap j gj
" nnoremap k gk
nnoremap <space>  i<space><esc>
nnoremap <silent> <esc><esc> :nohlsearch<cr><esc>
nnoremap <silent> <tab> :<c-u>bnext<cr>
nnoremap / /\v
nnoremap Q <nop>

" sudo write
command! W :w !sudo tee % > /dev/null

" 
nnoremap H ^
nnoremap L g_

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

nmap <C-w>r :<c-u>call <SID>resizeWindow()<CR>mws
" }}}

" forward/backward word
inoremap <silent> <c-b> <s-left>
inoremap <silent> <c-f> <s-right>

" better C-a C-e  {{{
" http://vim.g.hatena.ne.jp/tyru/20100305
" goto head, or tail
inoremap <expr> <c-a> <SID>goto_head()
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

inoremap <expr> <c-e> <SID>goto_tail()
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

" sudo to write
cmap w!! w !sudo tee % >/dev/null

"}}}
