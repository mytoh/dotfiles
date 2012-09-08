

(define-module tmux.schemeline.segments.hostname
  (export
    segment.hostname)
  (use gauche.process))
(select-module tmux.schemeline.segments.hostname)


(define (print-hostname)
  (sys-gethostname))

(define (segment.hostname)
  (print-hostname)
  )


