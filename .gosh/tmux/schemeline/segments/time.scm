
(define-module tmux.schemeline.segments.time
  (export
    segment.time)
  (use srfi-19)
  (use gauche.process))
(select-module tmux.schemeline.segments.time)


(define (print-date)
 (date->string (current-date)
              "~a < ~Y-~m-~d < ~H:~M.~S"))

(define (segment.time)
  (print-date))


