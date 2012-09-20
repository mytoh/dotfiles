
" kien/rainbow_parentheses {{{
augroup rainbow_parentheses
  autocmd!
  autocmd vimenter * RainbowParenthesesToggle
  autocmd syntax   * RainbowParenthesesLoadRound
  autocmd syntax   * RainbowParenthesesLoadSquare
  autocmd syntax   * RainbowParenthesesLoadBraces
augroup end

let g:rbpt_loadcmd_toggle = 0
let g:rbpt_colorpairs = [
	\ ['brown',       'RoyalBlue3'],
	\ ['Darkblue',    'SeaGreen3'],
	\ ['darkgray',    'DarkOrchid3'],
	\ ['darkgreen',   'firebrick3'],
	\ ['darkcyan',    'RoyalBlue3'],
	\ ['darkred',     'SeaGreen3'],
	\ ['darkmagenta', 'DarkOrchid3'],
	\ ['brown',       'firebrick3'],
	\ ['gray',        'RoyalBlue3'],
	\ ['green',       'SeaGreen3'],
	\ ['darkmagenta', 'DarkOrchid3'],
	\ ['Darkblue',    'firebrick3'],
	\ ['darkgreen',   'RoyalBlue3'],
	\ ['darkcyan',    'SeaGreen3'],
	\ ['blue',        'DarkOrchid3'],
	\ ['red',         'firebrick3'],
	\ ]
" (1 (2 (3 (4 (5 (6 (7 (8 (9 (10 (11 (12 (13 (14 (15 (16 (17 (18 (19)))))))))))))))))))
" }

" }}}
