
" eskk{{{
if has('vim_starting')
  " let g:eskk#dictionary = {
  "       \ 'path'     : "~/.skk-jisyo",
  "       \ 'sorted'   : 0,
  "       \ 'encoding' : 'utf-8',
  "       \}
  if vimrc.P.is_mac()
    let g:eskk#large_dictionary = {
          \ 'path'     : "~/Library/Application\ Support/AquaSKK/SKK-JISYO.L",
          \ 'sorted'   : 1,
          \ 'encoding' : 'euc-jp',
          \}
  elseif vimrc.isos('freebsd')
    let g:eskk#large_dictionary = {
          \ 'path'     : "/usr/local/share/skk/SKK-JISYO.L",
          \ 'sorted'   : 1,
          \ 'encoding' : 'euc-jp',
          \}
  endif
endif

    " http://subtech.g.hatena.ne.jp/motemen/20110527/1306485690
    " in eskk config.
    " NOTE: This config remains the last character "z"
    " if g:eskk#rom_input_style is not "skk".
    autocmd myautocommands User eskk-initialize-pre call s:eskk_initial_pre()
    function! s:eskk_initial_pre() "{{{
        for [orgtable, mode] in [['rom_to_hira', 'hira'], ['rom_to_kata', 'kata']]
            let t = eskk#table#new(orgtable.'*', orgtable)
            call t.add_map('zw', 'w', 'z')
            call eskk#register_mode_table(mode, t)
        endfor
    endfunction "}}}
" " http://kstn.fc2web.com/seikana_zisyo.html
" autocmd myautocommands User eskk-initialize-pre call s:eskk_initial_pre()
" function! s:eskk_initial_pre()
"   " User can be allowed to modify
"   " eskk global variables (`g:eskk#...`)
"   " until `User eskk-initialize-pre` event.
"   " So user can do something heavy process here.
"   " (I'm a paranoia, eskk#table#new() is not so heavy.
"   " But it loads autoload/vice.vim recursively)
"   let t = eskk#table#new('rom_to_hira*', 'rom_to_hira')
"   call t.add_map('gwa', 'ぐゎ')
"   call t.add_map('gwe', 'ぐぇ')
"   call t.add_map('gwi', 'ぐぃ')
"   call t.add_map('gwo', 'ぐぉ')
"   call t.add_map('gwu', 'ぐ')
"   call t.add_map('kwa', 'くゎ')
"   call t.add_map('kwe', 'くぇ')
"   call t.add_map('kwi', 'くぃ')
"   call t.add_map('kwo', 'くぉ')
"   call t.add_map('kwu', 'く')
"   call t.add_map('we', 'ゑ')
"   call t.add_map('wha', 'うぁ')
"   call t.add_map('whe', 'うぇ')
"   call t.add_map('whi', 'うぃ')
"   call t.add_map('who', 'うぉ')
"   call t.add_map('whu', 'う')
"   call t.add_map('wi', 'ゐ')
"   call t.add_map(':',':')
"   call t.add_map(';',';')
"   call t.add_map('!','!')
"   call t.add_map('?','?')
"   call t.add_map('{','『')
"   call t.add_map('}','』')
"   call eskk#register_mode_table('hira', t)
" endfunction

let g:eskk#egg_like_newline = 1
let g:eskk#enable_completion = 1
let g:eskk#select_cand_keys = "aoeuidhts"
let g:eskk#show_annotation = 1
"let g:eskk_revert_henkan_style = "okuri"

"}}}
