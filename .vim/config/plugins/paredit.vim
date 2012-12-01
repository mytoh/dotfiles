
" paredit {{{
let g:paredit_leader = '\'
let g:paredit_mode = 1
let g:paredit_electric_return = 1
let g:paredit_smartjump = 1 
let g:paredit_matchlines = 100
let g:paredit_shortmaps = 0

function! s:enable_shortmaps()
  " shortmaps
  nnoremap <buffer> <silent> <            :<C-U>call PareditMoveLeft()<CR>
  nnoremap <buffer> <silent> >            :<C-U>call PareditMoveRight()<CR>
  " nnoremap <buffer> <silent> O            :<C-U>call PareditSplit()<CR>
  " nnoremap <buffer> <silent> J            :<C-U>call PareditJoin()<CR>
  " nnoremap <buffer> <silent> W            :<C-U>call PareditWrap('(',')')<CR>
  " vnoremap <buffer> <silent> W            :<C-U>call PareditWrapSelection('(',')')<CR>
  nnoremap <buffer> <silent> S            :<C-U>call PareditSplice()<CR>
  execute 'nnoremap <buffer> <silent> ' . g:paredit_leader.'<  :<C-U>normal! <<CR>'
  execute 'nnoremap <buffer> <silent> ' . g:paredit_leader.'>  :<C-U>normal! ><CR>'
  " execute 'nnoremap <buffer> <silent> ' . g:paredit_leader.'O  :<C-U>normal! O<CR>'
  " execute 'nnoremap <buffer> <silent> ' . g:paredit_leader.'J  :<C-U>normal! J<CR>'
  " execute 'nnoremap <buffer> <silent> ' . g:paredit_leader.'W  :<C-U>normal! W<CR>'
  " execute 'vnoremap <buffer> <silent> ' . g:paredit_leader.'W  :<C-U>normal! W<CR>'
  execute 'nnoremap <buffer> <silent> ' . g:paredit_leader.'S  :<C-U>normal! S<CR>'
endfunction


execute 'nnoremap <buffer> <silent> ' . g:paredit_leader.'t  :<C-U>call PareditToggle()<cr>'
augroup paredit
autocmd filetype scheme call PareditInitBuffer()
autocmd filetype scheme call s:enable_shortmaps()
augroup end
" }}}
