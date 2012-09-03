(define-module tmux.powerline.segments.tmux-session-info
  (export
    segment.tmux-session-info)
  (use gauche.process))
(select-module tmux.powerline.segments.tmux-session-info)


(define (segment.tmux-session-info)
  (process-output->string '(tmux display-message -p "#S"))
  )


