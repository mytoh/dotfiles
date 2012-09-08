set-option -g status on
set-option -g status-interval 2
set-option -g status-utf8 on
set-option -g status-justify "centre"
set-option -g status-left-length 60
set-option -g status-right-length 90

# statusline
set-option -g status-left "#(~/local/git/tmux-powerline/status-left.sh)"
set-option -g status-right "#(~/local/git/tmux-powerline/status-right.sh)"
