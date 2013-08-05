function recent-file --argument dir
  command ls -c -t -1  | head -n {$dir}  | tail -n 1
end

