
set laststatus=2

" highlight for statusline
" User1-9 => %{1-9}*
highlight User1 ctermfg=white ctermbg=244 cterm=none guifg=#ffffff guibg=#808080
highlight User2 ctermfg=172    ctermbg=233           guifg=#df8700 guibg=#121212
highlight User3 ctermfg=243    ctermbg=234           guifg=#767676 guibg=#1c1c1c
highlight User4 ctermfg=59   ctermbg=235             guifg=#5f5f5f guibg=#262626 
highlight User5 ctermfg=38   ctermbg=239             guifg=#444444 guibg=#4e4e4e 
highlight User6 ctermfg=190   ctermbg=243            guifg=#dfff00 guibg=#767676 
highlight User7 ctermfg=17   ctermbg=247             guifg=#007799 guibg=#808080 
highlight User8 ctermfg=95   ctermbg=251             guifg=#bfaf0f guibg=#908080 
" mode
highlight User9 ctermfg=18   ctermbg=154             guifg=#fafe9f guibg=#908080 

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

  return  "'" . char ."' ". nr
endfunction "}}}

function! GetCharHighlightGroup()
  redir => highlights
  silent! echo map(synstack(line('.'),col('.')),'synIDattr(synIDtrans(v:val),"name")')
  redir END

  return highlights
endfunction

let s:statusline_mode_unite_insert = 'U.insert'
let s:statusline_mode_unite_normal = 'U.normal'
let s:statusline_mode_vimfiler_insert = 'Vf.insert'
let s:statusline_mode_vimfiler_normal = 'Vf.normal'

let s:status_sign = {
      \ 'i': 'insert',
      \ 'R': 'replace',
      \ 'n': 'normal',
      \ 'v': 'visual',
      \ 'V': 'lvisual',
      \ 'cv': 'cvisual',
      \ 's': 'select',
      \ 'S': 'lselect',
      \ 'cs': 'cselect',
      \}

function! StatusSign(group, fg, bg, mode)
  call SetHighlight(a:group, a:fg, a:bg)
  call get(s:status_sign, a:mode)
endfunction

" add hook to change mode highlight {{{
function! Statusmode()
  let curmode = mode()
  let is_unite = &filetype == 'unite' ? 1 : 0
  let is_vimfiler = &filetype == 'vimfiler' ? 1 : 0
  let is_gosh_repl = &filetype == 'gosh-repl' ? 1 : 0
  " unite
  if is_unite
    if curmode == 'i'
      call SetHighlight('User9', 45, 144)
      return s:statusline_mode_unite_insert
    elseif curmode == 'n'
      call SetHighlight('User9', 18, 134)
      return s:statusline_mode_unite_normal
    else
      call SetHighlight('User9', 18, 134)
      return curmode . '.un'
    endif
    " vimfiler
  elseif is_vimfiler
    if curmode == 'i'
      call SetHighlight('User9', 45, 94)
      return s:statusline_mode_vimfiler_insert
    elseif curmode == 'n'
      call SetHighlight('User9', 18, 152)
      return s:statusline_mode_vimfiler_normal
    else
      call SetHighlight('User9', 18, 152)
      return curmode . '.vf'
    endif
    " gosh_repl
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
      call SetHighlight('NyanMdoki', 18, 234)
      return s:status_sign.i
    elseif curmode == 'n'
      call SetHighlight('User9', 18, 154)
      call SetHighlight('StatusLine', 18, 234)
      call SetHighlight('NyanMdoki', 18, 234)
      return s:status_sign.n
    elseif curmode == 'v'
      call SetHighlight('User9', 18, 94)
      return s:status_sign.v
    elseif curmode == 'V'
      call SetHighlight('User9', 18, 94)
      return s:status_sign.V
    elseif curmode == 'cv'
      call SetHighlight('User9', 18, 94)
      return s:status_sign.cv
    elseif curmode == 's'
      call SetHighlight('User9', 18, 34)
      return s:status_sign.s
    elseif curmode == 'S'
      call SetHighlight('User9', 18, 34)
      return s:status_sign.S
    elseif curmode == 'cs'
      call SetHighlight('User9', 18, 34)
      return s:status_sign.cs
    elseif curmode == 'R'
      call SetHighlight('User9', 18, 53)
      return s:status_sign.R
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

  let left  = join([
        \  mystatus#segment('curmode'),
        \  '%2*',
        \  '%t',
        \  mystatus#segment('curpath'),
        \  mystatus#segment('fugitive'),
        \], '')

  " right
  let right = join([
        \   mystatus#segment('hahhah'),
        \   mystatus#segment('nyan_modoki'),
        \   mystatus#segment('fileinfo'),
        \   mystatus#segment('charcode'),
        \   mystatus#segment('charhighlight'),
        \   mystatus#segment('ruler'),
        \], '')
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

