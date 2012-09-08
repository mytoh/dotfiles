(define-module tmux.schemeline.segments
  (extend
    tmux.schemeline.segments.time
    tmux.schemeline.segments.hostname
    tmux.schemeline.segments.cpu-freq
    tmux.schemeline.segments.xkb-layout
    tmux.schemeline.segments.tmux-session
    tmux.schemeline.segments.tmux-title
    tmux.schemeline.segments.wan-ip
    tmux.schemeline.segments.lan-ip
    ))
(select-module tmux.schemeline.segments)

