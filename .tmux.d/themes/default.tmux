
# set -g status-left '#(tumx set status-interval 10 && tmux refresh)#[fg=colour105]>#S #[fg=colour230,bg=colour232]#[fg=colour238]'
set -g status-left '#(tumx set status-interval 10 && tmux refresh)#[fg=colour105]>#S '
set -g status-right ' #[fg=red]#T #[fg=blue]#(uptime |cut -d "," -f 4- |cut -d " " -f 4|sed -e "s/,//") #[fg=colour33]freq:#(sysctl -n dev.cpu.0.freq) #[fg=yellow]%a %d/%m %H:%M:%S#[fg=colour238]'
