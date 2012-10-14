
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
  let @/=''
endfunction
" }}}


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


" }}}




" highlights {{{
highlight clear cursorline
highlight cursorline                   ctermbg=237  gui=underline guibg=black
highlight StatusLine     ctermfg=gray  ctermbg=235 cterm=none
highlight ActiveBuffer   ctermfg=232   ctermbg=244 cterm=none
highlight InactiveBuffer ctermfg=gray  ctermbg=235 cterm=none
highlight Comment        ctermfg=244   ctermbg=234 cterm=bold
highlight ColorColumn    ctermfg=white ctermbg=234
highlight MatchParen     cterm=bold,reverse


highlight Pmenu          ctermfg=110    ctermbg=235
highlight PmenuSel      ctermfg=189    ctermbg=238

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

if executable('pdftotext')
  command! -complete=file -nargs=1 Pdf :r !pdftotext -nopgbrk -layout <q-args> -
endif



" autocommands{{{

augroup myautocommands
  autocmd!
  autocmd bufenter           *                         if expand("%:p:h") !~ '^/tmp' | silent lcd %:p:h | endif
  autocmd bufread,bufnewfile ~/.xcolours/*             ColorHighlight
  autocmd bufwritepost       .vimrc                    source ~/.vimrc
  autocmd bufwritepost       ~/.vim/config/bundle.vim  source ~/.vim/config/bundle.vim
  autocmd bufwritepost       .zshrc                    Silent !zcompile ~/.zshrc
  autocmd bufwritepost       .conkyrc                  Silent !killall -SIGUSR1  conky
  autocmd bufwritepost       xmonad.hs                 Silent !xmonad --recompile
  autocmd bufwritepost       *.c                       call vimrc.trimspace()
  " autocmd filetype           xdefaults                 call vimrc.xrdb()
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


" utility from tyru's autochmodx
function! s:echomsg(hl, msg) "{{{
    execute 'echohl' a:hl
    try
        echomsg a:msg
    finally
        echohl None
    endtry
endfunction "}}}



" }}}
