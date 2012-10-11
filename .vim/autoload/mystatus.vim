



function! mystatus#segment(seg)
  return get(s:segments, a:seg)
endfunction

function! s:wrap(colour, list)
  let seglist = a:colour . join(a:list) . '%*'
  return seglist
endfunction

function! s:wrap_plugin(plugin, colour, list)
  if neobundle#is_installed(a:plugin)
    s:wrap(a:colour, a:list)
  else
    return []
  endif
endfunction

let s:segments = {}

let s:segments.curpath =  s:wrap('%3*',
      \ [
      \ '%{fnamemodify(getcwd(),":~")}',
      \])

if neobundle#is_installed('vim-fugitive')
  let s:segments.fugitive = s:wrap('%6*',
        \[
        \ '%{fugitive#statusline()}',
        \])
endif



let s:segments.curmode = s:wrap('%9*',
      \[
      \  '%{Statusmode()}',
      \])

let s:segments.fileinfo = s:wrap('%3*',
      \[
      \  '%{&dictionary}',
      \  '%<',
      \  '%{&fileformat}',
      \  '<',
      \  '%{&fileencoding}',
      \  '<',
      \  '%{&filetype}',
      \]) . '%0*'

let s:segments.charcode = s:wrap('%6*',
      \ [
      \  '%{GetCharCode()}',
      \])

let s:segments.ruler = s:wrap('%7*',
      \[
      \ '%3p%%',
      \  '%c' . ',' . '%l/%L' ,
      \])

if neobundle#is_installed('hahhah-vim')
  let s:segments.hahhah = s:wrap('%4*',
        \[
        \ '%{g:HahHah()}',
        \])
endif

if neobundle#is_installed('Syntastic')
let s:segments.syntastic = s:wrap('%7*',
      \[
      \  '%{SyntasticStatuslineFlag()}',
      \])
endif

let s:segments.charhighlight = s:wrap('%9*',
      \[
      \ '%{GetCharHighlightGroup()}',
      \])

if neobundle#is_installed('nyan-modoki.vim')
let s:segments.nyan_modoki = s:wrap('%3*',
      \ [
      \ '%{g:NyanModoki()}'
      \])
endif


