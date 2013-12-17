
" vim-ref {{{
"http://www.karakaram.com/vim/ref-webdict/
let g:ref_use_vimproc = 1
let g:ref_source_webdict_sites = {
      \   'je': {
      \     'url': 'http://dictionary.infoseek.ne.jp/jeword/%s',
      \   },
      \   'ej': {
      \     'url': 'http://dictionary.infoseek.ne.jp/ejword/%s',
      \   },
      \   'ef': {
      \     'url': 'http://www.fincd.com/index.php?txtSearch=%s',
      \   },
      \   'fe': {
      \     'url': 'http://www.fincd.com/index.php?txtSearch=%s',
      \   },
      \   'wiki': {
      \     'url': 'http://ja.wikipedia.org/wiki/%s',
      \   },
      \ }

" default site
let g:ref_source_webdict_sites.default = 'ej'

" function for outputs. remove first some lines
function! g:ref_source_webdict_sites.je.filter(output)
  return join(split(a:output, "\n")[15 :], "\n")
endfunction
function! g:ref_source_webdict_sites.ej.filter(output)
  return join(split(a:output, "\n")[15 :], "\n")
endfunction
function! g:ref_source_webdict_sites.wiki.filter(output)
  return join(split(a:output, "\n")[17 :], "\n")
endfunction
function! g:ref_source_webdict_sites.ef.filter(output)
  return join(split(a:output, "\n")[4 :], "\n")
endfunction
function! g:ref_source_webdict_sites.fe.filter(output)
  return join(split(a:output, "\n")[4 :], "\n")
endfunction

" keymap
autocmd filetype ref-webdict nnoremap <buffer> q <c-w>c

" }}}
