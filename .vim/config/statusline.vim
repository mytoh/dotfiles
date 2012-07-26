
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

" add hook to change mode highlight {{{
function! Statusmode()
  let curmode = mode()
  let is_unite = &filetype == 'unite' ? 1 : 0
  let is_vimfiler = &filetype == 'vimfiler' ? 1 : 0 
  let is_gosh_repl = &filetype == 'gosh-repl' ? 1 : 0 
  if is_unite
    if curmode == 'i'
      call SetHighlight('User9', 45, 144)
      return 'uI'
    elseif curmode == 'n'
      call SetHighlight('User9', 18, 134)
      return 'uN'
    else
      call SetHighlight('User9', 18, 134)
      return 'u' . curmode
    endif
  elseif is_vimfiler
    if curmode == 'i'
      call SetHighlight('User9', 45, 94)
      return 'vfI'
    elseif curmode == 'n'
      call SetHighlight('User9', 18, 152)
      return 'vfN'
    else
      call SetHighlight('User9', 18, 152)
      return 'vf' . curmode
    endif
  elseif is_gosh_repl
    if curmode == 'i'
      call SetHighlight('User9', 45, 34)
      return 'gI'
    elseif curmode == 'n'
      call SetHighlight('User9', 18, 202)
      return 'gN'
    else
      call SetHighlight('User9', 18, 202)
      return 'g' . curmode
    endif
  else
    if curmode == 'i'
      call SetHighlight('User9', 45, 194)
      call SetHighlight('StatusLine', 39, 224)
      return 'I'
    elseif curmode == 'n'
      call SetHighlight('User9', 18, 154)
      call SetHighlight('StatusLine', 18, 234)
      return 'N'
    elseif curmode == 'v' || curmode == 'V'
      call SetHighlight('User9', 18, 94)
      return 'V'
    else
      call SetHighlight('User9', 18, 154)
      return curmode
    endif
  endif
endfunction
augroup InsertHook
  autocmd!
  autocmd insertenter * call Statusmode()
  autocmd insertleave * call Statusmode()
  autocmd bufleave,winleave * call Statusmode()
augroup END
"}}}

function! SetHighlight(hl, fg, bg)
  hi clear a:hl
  let command = join([
        \  'highlight',
        \  a:hl,
        \  'ctermfg=',
        \  a:fg,
        \  'ctermbg=',
        \  a:bg,
        \  'cterm=none',
        \])
  silent exec command
endfunction

" active status {{{

function! SetActiveStatusLine()
  " setl stl=""
  " setl stl=%!MakeActiveStatusLine()
  let &l:statusline = '%!MakeActiveStatusLine()'
endfunction
function! MakeActiveStatusLine()
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
  let fileinfo = {
        \ 'dict': '%{&dictionary}',
        \ 'format': '%{&fileformat}',
        \ 'enc': '%{&fileencoding}',
        \ 'type': '%{&filetype}',
        \ 'separator': '<',
        \}
  let fileinfos = join([
        \  '%3*',
        \  fileinfo.dict,
        \  '%<',
        \  fileinfo.format,
        \  fileinfo.separator,
        \  fileinfo.enc,
        \  fileinfo.separator,
        \   fileinfo.type,
        \  '%*',
        \])

  let charcode = join([
        \   '%6*',
        \   '%{GetCharCode()}'
        \])

  let ruler = {
        \ 'percent': '%3p%%',
        \ 'curline': '%l/%L',
        \ 'column': '%c',
        \}
  let rulers = '%7*' .
        \ join([
        \   ruler.percent,
        \   ruler.column . ',' . ruler.curline,
        \])
        \ . '%0*'

  let right = join([
        \   fileinfos,
        \   charcode,
        \   rulers,
        \])
  return left . '%=' . right
endfunction

" au VimEnter     * call SetActiveStatusLine()
" au InsertEnter  * call SetActiveStatusLine()
" au InsertLeave  * call SetActiveStatusLine()
autocmd BufEnter,WinEnter     * call SetActiveStatusLine()
" }}}

" inactive status {{{
function! SetInactiveStatusLine()
  " setl stl=""
  " setl stl=%!MakeInactiveStatusLine()
  let &l:statusline = '%!MakeInactiveStatusLine()'
endfunction

function! MakeInactiveStatusLine()
  " left
  let path  = '%3*' . fnamemodify(getcwd(),':~') . '%*'
  " let curmode  =  mode()
  let curmode  =  Statusmode()
  let left  = join([
        \  '%8*',
        \  'n',
        \  '%2*',
        \  '%t',
        \])
  return left
endfunction

" Update when leaving Buffer {{{
function! SetStatusLeaveBuffer()
  call SetInactiveStatusLine()
endfunction
" autocmd bufleave,winleave * call SetInactiveStatusLine() " }}}

" }}}

" change StatusLine color when insert mode {{{
" http://sites.google.com/site/fudist/Home/vim-nihongo-ban/vim-color#color-theme-mod
" let g:hi_insert = 'highlight StatusLine ctermfg=blue ctermbg=yellow
"                  \ cterm=none guifg=darkblue guibg=darkyellow gui=none'
" if has('sytax')
"   augroup InsertHook
"     autocmd!
"     autocmd InsertEnter * call StatusLine('Enter')
"     autocmd InsertLeave * call StatusLine('Leave')
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

