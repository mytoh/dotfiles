
setw -g mode-keys vi

unbind C-b
set -g prefix C-z
unbind C-z
unbind z
#bind C-z send-prefix

# screen ^C c
unbind ^C
bind ^C new-window

# detach ^D d
unbind ^D
bind ^D detach

# next ^N sp n
unbind ^N
bind ^N next-window

# prev ^P p ^?
unbind ^P
bind ^P previous-window

# quit \
unbind q
bind q confirm-before "kill-session"

# kill k
unbind k
bind k confirm-before "kill-window"

# redisplay ^L l
unbind l
bind l refresh-client

# list sessions
unbind L
bind L list-sessions

# split window
unbind S
bind S split-window -h
unbind s
bind s split-window -v

# :kB: focus up
unbind Tab
bind Tab select-pane -t:.+
unbind BTab
bind BTab select-pane -t:.-

# reload setting
unbind C-r
bind C-r source-file $HOME/.tmux.conf

# split window and execute command
bind e command-prompt "split-window -p 65 'exec %%'"

# cycle window or pane
#bind C-z run "tmux last-pane || tmux last-window || tmux new-window"

# resize keys
unbind C-h
unbind C-l
unbind C-j
unbind C-k
bind -r C-h resize-pane -L 3
bind -r C-l resize-pane -R 3
bind -r C-j resize-pane -D 3
bind -r C-k resize-pane -U 3

# change layout with active pane as main pane
# d.hatena.ne.jp/bannyan/20111204
bind -r H select-layout main-vertical \; swap-pane -s : -t 0 \; select-pane -t 0 \; resize-pane -R 9
bind -r K select-layout main-horizontal \; swap-pane -s : -t 0 \; select-pane -t 0 \; resize-pane -D 18


# toggle maximize window
#bind } run "if [[ $(tmux list-window) =~ tmux-zoom ]]; then tmux last-window; tmux swap-pane -s tmux-zoom.0; tmux kill-window -t tmux-zoom; else tmux new-window -d -n tmux-zoom 'clear && echo TMUX ZOOM && read'; tmux swap-pane -s tmux-zoom.0; tmux select-window -t tmux-zoom;fi"

