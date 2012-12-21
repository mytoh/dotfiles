
if neobundle#is_installed('rainbow')
  let g:rainbow_active = 1
  let g:rainbow_operators = 2

  let g:rainbow_load_separately = [
        \ [ '*' , [['(', ')'], ['\[', '\]'], ['{', '}']] ],
        \ [ '*.tex' , [['(', ')'], ['\[', '\]']] ],
        \ [ '*.cpp' , [['(', ')'], ['\[', '\]'], ['{', '}']] ],
        \ [ '*.{html,htm}' , [['(', ')'], ['\[', '\]'], ['{', '}'], ['<\a[^>]*>', '</[^>]*>']] ],
        \ ]

  let g:rainbow_guifgs = ['RoyalBlue3', 'DarkOrange3', 'DarkOrchid3', 'FireBrick',]
  let g:rainbow_ctermfgs = [
        \ 'darkblue', 'green', 'yellow', 'darkyellow', 'red',
        \ 'magenta', 'blue', 'lightgreen'
        \ ]

endif
