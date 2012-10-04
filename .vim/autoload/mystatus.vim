
let s:segments = {}

let s:segments.curpath =  join([
        \ '%3*'. '%{fnamemodify(getcwd(),":~")}' . '%*',
        \])

let s:segments.fugitive = join([
      \ '%6*' . '%{fugitive#statusline()}' . '%0*',
      \])


let s:segments.curmode = join([
      \  '%9*' . '%{Statusmode()}'. '%0*',
      \])

let s:segments.fileinfo = '%3*' .
      \ join([
        \  '%{&dictionary}',
        \  '%<',
        \  '%{&fileformat}',
        \  '<',
        \  '%{&fileencoding}',
        \  '<',
        \  '%{&filetype}',
        \]) . '%0*'

let s:segments.charcode = '%6*' .
        \ join([
        \  '%{GetCharCode()}',
        \])

let s:segments.ruler = join([
      \ '%7*',
      \ '%3p%%',
      \  '%c' . ',' . '%l/%L' . '%0*',
      \])

let s:segments.hahhah = join([
      \ '%4*',
      \ '%{g:HahHah()}' . '%*',
      \])

let s:segments.syntastic = join([
      \ '%7*' . '%{SyntasticStatuslineFlag()}' . '%0*',
      \])

let s:segments.charhighlight = join([
      \ '%9*' . '%{GetCharHighlightGroup()}' . '%0*',
      \])

let s:segments.nyan_modoki = join ([
      \ '%3*' . '%{g:NyanModoki()}' . '%*',
      \])

function! mystatus#segment(seg)
  return get(s:segments, a:seg)
endfunction
