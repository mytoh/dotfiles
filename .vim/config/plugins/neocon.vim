
" neocomplcache"{{{
let g:neocomplcache_enable_at_startup              = 1
let g:neocomplcache_enable_smart_case              = 1
let g:neocomplcache_enable_ignore_case             = 1
" let g:neocomplcache_enable_camel_case_completion = 1
" let g:neocomplcache_enable_underbar_completi on  = 1
let g:neocomplcache_enable_fuzzy_completion        = 1
let g:neocomplcache_enable_auto_select             = 0
let g:neocomplcache_use_vimproc                    = 1
let g:neocomplcache_enable_prefetch                = 1
let g:neocomplcache_max_list                       = 1000
let g:neocomplcache_dictionary_filetype_lists      = {
      \ 'default'  : '',
      \ 'scheme'   : $RLWRAP_HOME . '/gosh_completions',
      \ 'vimshell' : $HOME . '/.vimshell/command-history' }
" Define keyword.
if !exists('g:neocomplcache_keyword_patterns')
  let g:neocomplcache_keyword_patterns = {}
endif
let g:neocomplcache_keyword_patterns['default'] = '\h\w*'

if !exists('g:neocomplcache_context_filetype_lists')
  let g:neocomplcache_context_filetype_lists = {}
endif
let g:neocomplcache_context_filetype_lists.perl6 =
      \ [{'filetype' : 'pir', 'start' : 'Q:PIR\s*{', 'end' : '}'}]
let g:neocomplcache_context_filetype_lists.vim =
      \ [{'filetype' : 'python', 'start' : '^\s*python <<\s*\(\h\w*\)', 'end' : '^\1'}]
" neocomplcache key-mappings {{{
imap <C-k>     <Plug>(neocomplcache_snippets_expand)
smap <C-k>     <Plug>(neocomplcache_snippets_expand)
inoremap <expr><C-g>     neocomplcache#undo_completion()
inoremap <expr><C-l>     neocomplcache#complete_common_string()
inoremap <silent><expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
inoremap <silent><CR>  <CR><C-R>=neocomplcache#smart_close_popup()<CR>
inoremap <silent><C-m>  <CR><C-R>neocomplcache#smart_close_popup()<CR>
" <C-h>, <BS>: close popup and delete backword char.
" inoremap <expr><C-h> neocomplcache#smart_close_popup()."\<C-h>"
inoremap <silent><expr><BS> neocomplcache#smart_close_popup()."\<C-h>"
inoremap <expr><C-y>  neocomplcache#close_popup()
" }}}

augroup myautocommands
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType less setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType scss setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
augroup end

" For snippet_complete marker.
if has('conceal')
  set conceallevel=2 concealcursor=i
endif

" snippet directory
let g:neocomplcache_snippets_dir='~/.vim/snippets'


" force cache dict when insert
" augroup myautocommands
" autocmd InsertEnter * call s:neco_pre_cache()
" augroup end
" function! s:neco_pre_cache()
"   if exists('b:neco_pre_cache')
"     return
"   endif
"   let b:neco_pre_cache = 1
"   if bufname('%') =~ g:neocomplcache_lock_buffer_name_pattern
"     return
"   endif
"   :NeoComplCacheCachingBuffer
"   :NeoComplCacheCachingDictionary
" endfunction
"}}}

