
if filereadable(expand('~/.vim/config/global.vim'))
  source ~/.vim/config/global.vim
endif

runtime! config/plugins/*.vim

" plugins {{{
"












" sudo.vim {{{
"let g:sudoAuth="ssh"
"let g:sudoAuthArg="root@localhost"
" }}}

" ctrlp.vim {{{

let g:ctrlp_working_path_mode = 2

" }}}


" indent-guides {{{
let g:indent_guides_enable_on_vim_startup                   = 0
let g:indent_guides_guide_size                              = 1
let g:indent_guides_start_level                             = 2
let g:indent_guides_space_guides                            = 1
let g:indent_guides_auto_colors                             = 0
autocmd VimEnter,ColorScheme * :hi IndentGuidesOdd ctermbg=236
autocmd VimEnter,ColorScheme * :hi IndentGuidesEven ctermbg=233
" }}}

" scheme.vim {{{
" not work on autocmd
let is_gauche=1
" }}}

" slimv {{{
let g:slimv_keybindings = 3
" }}}

" poslist {{{
" nmap <C-o> <Plug>(poslist_prev)
" nmap <C-i> <Plug>(poslist_next)
" }}}

" delimitMate {{{
let delimitMate_matchpairs = "(:),[:],{:},<:>"
let delimitMate_excluded_regions = "Comment,String"

augroup delimitMateSettings
  autocmd FileType vim,html let b:delimitMate_matchpairs = "(:),[:],{:},<:>"
  autocmd FileType scheme let b:delimitMate_quotes = "\" ' *"
augroup end
" }}}

" scratch {{{
" open scratch buffer
" if no filename given
if !argc()
  autocmd myautocommands VimEnter * ScratchOpen
endif
" }}}

" paredit {{{
let g:paredit_leader = '\'
let g:paredit_mode = 1
" }}}

" haskell-mode {{{
let g:haddock_browser="/usr/local/bin/firefox"
" }}}

" vinarise {{{
let g:vinarise_enable_auto_detect = 0
" }}}

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


" vimclojure {{{
let g:vimclojure#FuzzyIndent = 1
let g:vimclojure#HighlightBuiltins = 1
let g:vimclojure#ParenRainbow = 1
let g:vimclojure#DynamicHighlighting = 1

" }}}

"dwm.vim {{{
let g:dwm_map_keys=0

" map <silent> <C-J> <C-W>w
" map <silent> <C-K> <C-W>W
" map <silent> <C-,> :call DWM_Rotate(0)<CR>
" map <silent> <C-.> :call DWM_Rotate(1)<CR>

map <silent> <localleader>dn :call DWM_New()<CR>
map <silent> <localleader>dc    :call DWM_Close()<CR>
map <silent> <localleader>d<Space> :call DWM_Focus()<CR>
map <silent> <LocalLeader>d@ :call DWM_Focus()<CR>

map <silent> <LocalLeader>dh :call DWM_GrowMaster()<CR>
map <silent> <localleader>dl :call DWM_ShrinkMaster()<CR>
" }}}

"}}}
