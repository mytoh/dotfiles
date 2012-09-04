(define-module tmux.powerline.segments
  (extend
    tmux.powerline.segments.time
    tmux.powerline.segments.hostname
    tmux.powerline.segments.cpu_freq
    tmux.powerline.segments.xkb-layout
    tmux.powerline.segments.tmux-session
    tmux.powerline.segments.tmux-title
    ))
(select-module tmux.powerline.segments)

