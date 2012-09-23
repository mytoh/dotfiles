
(define-module tmux.schemeline.segments.time
  (export
    segment.time)
  (use srfi-19)
  (use gauche.process))
(select-module tmux.schemeline.segments.time)


(define (print-date)
  (string-append
    (week)
    " #[fg=colour122]> #[default]"
    (months)
    " #[fg=colour122]> #[default]"
    (now)
    ))

(define (week)
  (date->string (current-date)
                "~a"))

(define (months)
  (date->string (current-date)
                "~m/~d"))

(define (now)
  (date->string (current-date)
                "~H:~M"))

(define (segment.time)
  (print-date))


