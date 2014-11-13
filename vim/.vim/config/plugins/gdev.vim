
":Unite gosh_infoを実行します
" nmap gi <Plug>(gosh_info_start_search)
":Unite カーソル位置のシンボルを初期値に:Unite gosh_infoを実行します
" nmap gk <Plug>(gosh_info_start_search_with_cur_keyword)
" imap <C-A> <Plug>(gosh_info_start_search_with_cur_keyword)

"ginfoウィンドウのスクロールアップ・ダウン
" nmap <C-K> <Plug>(gosh_info_row_up)
" nmap <C-J> <Plug>(gosh_info_row_down)
" imap <C-K> <Plug>(gosh_info_row_up)
" imap <C-J> <Plug>(gosh_info_row_down)
"ginfoウィンドウを閉じます
" nmap <C-C> <Plug>(gosh_info_close)
" imap <C-C> <Plug>(gosh_info_close)

"カーソル位置のシンボルが定義されている場所にジャンプ
" nmap <F12> <Plug>(gosh_goto_define)
" nmap <F11> <Plug>(gosh_goto_define_split)

