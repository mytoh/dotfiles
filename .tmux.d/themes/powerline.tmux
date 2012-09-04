
# default statusbar colors
set-option -g status-bg colour235
set-option -g status-fg colour195
set-option -g status-attr default

# default window title colors
set-window-option -g window-status-fg colour195
set-window-option -g window-status-bg default
#set-window-option -g window-status-attr dim

# active window title colors
set-window-option -g window-status-current-fg colour130
set-window-option -g window-status-current-bg default
set-window-option -g window-status-current-attr bright

# pane border
set-option -g pane-border-bg default
set-option -g pane-border-fg colour238
set-option -g pane-active-border-bg default
set-option -g pane-active-border-fg colour31

# message text
set-option -g message-bg colour235 #base02
set-option -g message-fg colour166 #orange

# pane number display
set-option -g display-panes-active-colour colour33 #blue
set-option -g display-panes-colour colour166 #orange

# clock
set-window-option -g clock-mode-colour colour64 #green

# statusline
set-option -g status-left "#(gosh ~/.gosh/tmux/powerline/status-left.scm)"
set-option -g status-right "#(gosh ~/.gosh/tmux/powerline/status-right.scm)"
