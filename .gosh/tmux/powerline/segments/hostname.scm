

(define-module tmux.powerline.segments.hostname
  (export
    segment.hostname)
  (use gauche.process))
(select-module tmux.powerline.segments.hostname)


(define (print-hostname)
  (sys-gethostname))

(define (segment.hostname)
  (print-hostname)
  )


