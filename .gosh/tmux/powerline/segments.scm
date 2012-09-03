(define-module tmux.powerline.segments
  (extend tmux.powerline.segments.tmux-session-info
    tmux.powerline.segments.time
    tmux.powerline.segments.hostname
    ))
(select-module tmux.powerline.segments)

