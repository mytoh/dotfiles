
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
  " autocmd filetype           xdefaults                 call vimrc.xrdb()
  autocmd filetype           help                      nnoremap q :<c-u>q<cr>
  autocmd filetype           haskell                       ColorHighlight
  autocmd filetype           fish                       setl equalprg=fish_indent
  " for chalice buffers
  autocmd filetype           2ch*                      setl fencs=cp932,iso-2022-jp-3,euc-jp
  autocmd filetype           2ch*                      let g:loaded_golden_ratio=1

  autocmd filetype           *                         setl formatoptions-=ro

  autocmd bufreadpre,bufnewfile *.scm                     let is_gauche=1
  autocmd bufreadpre,bufnewfile {*.ss,*.sps,*.sls,*.sld}        let b:is_r7rs=1
augroup end

augroup cch
  autocmd!
  autocmd winleave * set nocursorline
  autocmd winenter,bufread * set cursorline
augroup end

" augroup tmux
"   if !has('gui_running') && $TMUX !=# ''
"     autocmd!
"     autocmd! vimenter,vimleave * silent !tmux set status
"   endif
" augroup END

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
  augroup end


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
