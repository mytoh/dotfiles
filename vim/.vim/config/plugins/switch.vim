
nnoremap - :Switch<cr>

autocmd filetype scheme let b:switch_definitions =
      \ [
      \   ['equal?', 'eq?', 'eqv?', '='],
      \   ['#t', '#f'],
      \   ['define', 'define-macro', 'define-syntax'],
      \ ]
