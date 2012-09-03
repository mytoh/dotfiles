
set-option -g status-left "#(gosh ~/.gosh/tmux/powerline/status-left.scm)"
set-option -g status-right "#(gosh ~/.gosh/tmux/powerline/status-right.scm)"
#set -g status-right ' #[fg=red]#T #[fg=blue]#(uptime |cut -d "," -f 4- |cut -d " " -f 4|sed -e "s/,//") #[fg=colour33]freq:#(sysctl -n dev.cpu.0.freq) #[fg=yellow]%a %d/%m %H:%M:%S#[fg=colour238]'
