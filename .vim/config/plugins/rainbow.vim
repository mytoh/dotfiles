
if neobundle#is_installed('rainbow')
  let g:rainbow_operators = 2
  autocmd filetype scheme,lisp,clojure call rainbow#activate()
  autocmd filetype c,cpp,objc,objcpp   call rainbow#activate()
let g:rainbow_ctermfgs = [
            \ 'lightblue', 'green', 'yellow', 'darkyellow', 'red',
            \ 'magenta', 'blue', 'lightgreen'
            \ ]

endif
