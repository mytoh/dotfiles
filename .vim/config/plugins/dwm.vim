
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
