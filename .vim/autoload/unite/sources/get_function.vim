"original source http://kokukuma.blogspot.jp/2012/01/vim-unite-source.html
"----------------------------------------------------------+
" get function                                             |
"----------------------------------------------------------+
let s:save_cpo = &cpo
set cpo&vim


" define source
let s:get_function = {
\   'name': 'get_function',
\   'action_table': {},
\   'default_action': {'common':'execute'},
\}


" bzr status
function! s:get_function.gather_candidates(args, context)

  let s:path  = expand('%:p')
  let s:ext   = expand('%:e')
  let s:lines = getbufline('%', 1, '$')
  let s:ftype = &filetype

  let s:func_list = []
  let s:line_number = 1

  for line in s:lines

    if line =~ 'function ' && s:ext == "php"
      call add(s:func_list, [s:line_number, line])

    " vim
    elseif line =~ 'function! ' 
      \ || line =~ 'function('
      \ || line =~ 'func('
      \ || line =~ 'func! ' && (s:ext == "vim" || s:ftype == "vim")
      call add(s:func_list, [s:line_number, line])

    elseif line =~ 'def ' && s:ext == "py"
      call add(s:func_list, [s:line_number, line])

    " scheme
    elseif line =~ '(define ' || line =~ '(define-syntax ' && (s:ext == "scm" || s:ftype == "scheme")
      call add(s:func_list, [s:line_number, line])

    " shell
    elseif line =~ ' ()' 
    \   || line =~ '() {'
    \   && (s:ext == "sh" || s:ftype == "sh")
      call add(s:func_list, [s:line_number, line])

    endif

    let s:line_number += 1
  endfor

  return map(copy(s:func_list), '{
  \   "word": v:val[0]." ".v:val[1],
  \   "source": "get_function",
  \   "kind": "jump_list",
  \   "action__path": s:path,
  \   "action__line": v:val[0]
  \ }')

endfunction

"
function! unite#sources#get_function#define()
    return [ s:get_function ]
endfunction

let &cpo = s:save_cpo
unlet s:save_cpo
