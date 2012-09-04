(define-module tmux.powerline.segments.tmux-session
  (export
    segment.tmux-session)
  (use gauche.process))
(select-module tmux.powerline.segments.tmux-session)


(define (segment.tmux-session)
  (process-output->string '(tmux display-message -p "#S>"))
  )


