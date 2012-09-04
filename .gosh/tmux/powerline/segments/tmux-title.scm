
(define-module tmux.powerline.segments.tmux-title
  (export
    segment.tmux-title)
  (use gauche.process))
(select-module tmux.powerline.segments.tmux-title)


(define (segment.tmux-title)
  (process-output->string '(tmux display-message -p "#T"))
  )


