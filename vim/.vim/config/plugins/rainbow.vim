
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
        \ 'darkblue', 'green', 'yellow', 'blue', 'darkyellow', 'red', 
        \ 'darkgreen', 'magenta', 'darkcyan', 'lightgreen',
        \ 'darkyellow', 'cyan', 'lightred', 'brown' , 'gray',
        \ 'darkblue', 'green', 'yellow', 'blue', 'darkyellow', 'red', 
        \ 'darkgreen', 'magenta', 'darkcyan', 'lightgreen',
        \ 'darkyellow', 'cyan', 'lightred', 'brown' , 'gray',
        \ 'darkblue', 'green', 'yellow', 'blue', 'darkyellow', 'red', 
        \ 'darkgreen', 'magenta', 'darkcyan', 'lightgreen',
        \ 'darkyellow', 'cyan', 'lightred', 'brown' , 'gray',
        \ ]


  " ((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((()))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))
  " 0     0     Black
  " 1     4     DarkBlue
  " 2     2     DarkGreen
  " 3     6     DarkCyan
  " 4     1     DarkRed
  " 5     5     DarkMagenta
  " 6     3     Brown, DarkYellow
  " 7     7     LightGray, LightGrey, Gray, Grey
  " 8     0*      DarkGray, DarkGrey
  " 9     4*      Blue, LightBlue
  " 10      2*      Green, LightGreen
  " 11      6*      Cyan, LightCyan
  " 12      1*      Red, LightRed
  " 13      5*      Magenta, LightMagenta
  " 14      3*      Yellow, LightYellow
  " 15      7*      White


endif
