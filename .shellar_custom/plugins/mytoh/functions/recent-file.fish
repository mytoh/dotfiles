function recent-file
  command ls -c -t -1  | head -n {$argv[1]}  | tail -n 1
end

