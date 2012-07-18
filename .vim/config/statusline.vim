
" statusline {{{
set laststatus=2

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
" left , buffer list
" set stl=     " clear statusline when reloaded
"
" set stl+=%2*\     " left side
"
" set stl+=%=  " separator
"
" " right
" set stl+=%9*
" let &stl= &stl . "\ " . "mode"
"
" set stl+=%3*
" let &stl= &stl . "\ "
" set stl+=%<%{fnamemodify(getcwd(),':~')}   "get filepath
" let &stl= &stl . "\ "
"
" set stl+=%4*
" if exists('*fugitive#statusline')
"   set stl+=%{fugitive#statusline()}  "git repo info
" endif
"
" set stl+=%{SyntasticStatuslineFlag()}
"
" set stl+=%5*
" let stl= &stl . "\ "
" set stl+=%{&dictionary}
" set stl+=%{&fileformat}\
" set stl+=<\
" set stl+=%{&fenc}\
" set stl+=<\
" set stl+=%{&filetype}\
"
" set stl+=%6*
" set stl+=\
" set stl+=%{GetCharCode()}\  " hex under cursor
"
" set stl+=%7*
" set stl+=%3p%%\  "percentage of current line
" set stl+=%*    "reset color
" set stl+=%8*
" set stl+=\
" set stl+=%l,  "current line number
" set stl+=%c   "columns
" set stl+=/%L   "total line number
" set stl+=\
"

" run function on startup
au vimenter * call MakeStatusLine()

set stl=%!MakeStatusLine()
function! MakeStatusLine()
  " left
  let path  = '%3*' . fnamemodify(getcwd(),':~') . '%*'
  " let curmode  =  mode()
  let curmode  =  Statusmode()
  let left  = join([
        \  '%9*',
        \  curmode,
        \  '%2*',
        \  '%t',
        \  path,
        \  '%{SyntasticStatuslineFlag()}',
        \])
  " right
  let fileinfos = join([
        \  '%3*',
        \  '%{&dictionary}',
        \  '%<',
        \  '%{&fileformat}',
        \  '<',
        \  '%{&fenc}',
        \  '<',
        \  '%{&filetype}',
        \  '%*'
        \])
  let charcode = join([
        \   '%6*',
        \   '%{GetCharCode()}'
        \])
  let cursor = join([
        \   '%7*',
        \   '%3p%%',
        \   '%8*',
        \   '%l,',
        \   '%c' ,
        \   '/%L',
        \])
  let right = join([
        \   fileinfos,
        \   charcode,
        \   cursor,
        \])
  return left . '%=' . right
endfunction


" add hook to change mode highlight {{{
function! Statusmode()
  let curmode = mode()
  if curmode == 'i'
    hi clear User9
    silent exec 'highlight User9 ctermfg=45 ctermbg=194 cterm=none'
    return 'I'
  elseif curmode == 'n'
    hi clear User9
    silent exec 'highlight User9 ctermfg=18 ctermbg=154 cterm=none'
    return 'N'
  elseif curmode == 'v' || curmode == 'V'
    hi clear User9
    silent exec 'highlight User9 ctermfg=18 ctermbg=94 cterm=none'
    return 'V'
  else
    hi clear User9
    silent exec 'highlight User9 ctermfg=18 ctermbg=154 cterm=none'
    return curmode
  endif
endfunction
augroup InsertHook
  autocmd!
  autocmd InsertEnter * call Statusmode()
  autocmd InsertLeave * call Statusmode()
augroup END
"}}}

" change StatusLine color when insert mode {{{
" http://sites.google.com/site/fudist/Home/vim-nihongo-ban/vim-color#color-theme-mod
" let g:hi_insert = 'highlight StatusLine ctermfg=blue ctermbg=yellow
"                  \ cterm=none guifg=darkblue guibg=darkyellow gui=none'
" if has('sytax')
"   augroup InsertHook
"     autocmd!
"     autocmd InsertEnter * call s:StatusLine('Enter')
"     autocmd InsertLeave * call s:StatusLine('Leave')
"   augroup END
" endif

" let s:slhlcmd = ''
" function! s:StatusLine(mode)
"   if a:mode == 'Enter'
"     silent! let s:slhlcmd = 'highlight' . s:GetHighlight('StatusLine')
"     silent exec g:hi_insert
"   else
"     highlight clear StatusLine
"     silent exec s:slhlcmd
"   endif
" endfunction
"
" function! s:GetHighlight(hl)
"   redir => hl
"   exec 'highlight' . a:hl
"   redir END
"   let hl = substitute(hl, '[\r\n]', '', 'g')
"   let hl = substitute(hl, 'xxx', '', '')
"   return hl
" endfunction
"}}}

"}}}
