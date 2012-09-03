
(define-module tmux.powerline.segments.time
  (export
    segment.time)
  (use srfi-19)
  (use gauche.process))
(select-module tmux.powerline.segments.time)


(define (print-date)
 (date->string (current-date)
               " ~a ~d. ~b ~H.~M.~S ")
  )

(define (segment.time)
  (print-date)
  )


