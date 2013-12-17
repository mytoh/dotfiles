
function! RestWatch()
  " !restview -l 9999 . &
  " let restview_pid = !pgrep -n -f restview
  " echo !lsof -Fc -a -i -p restview_pid
  :W3mSplit http://localhost:9999
  :wincmd L
endfunction


function! RestW3mReload()
  :wincmd w
  :W3mReload
  :wincmd w
endfunction

command! -nargs=0 RestWatch call RestWatch()
command! -nargs=0 RestW3mReload call RestW3mReload()

autocmd bufwritepost *.rst silent call RestW3mReload()
