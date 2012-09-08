
(define-module tmux.schemeline.segments.tmux-title
  (export
    segment.tmux-title)
  (use gauche.process))
(select-module tmux.schemeline.segments.tmux-title)


(define (segment.tmux-title)
  (process-output->string '(tmux display-message -p "#T"))
  )


