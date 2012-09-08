
(define-module tmux.schemeline.segments.lan-ip
  (export
    segment.lan-ip)
  (use srfi-1)
  (use gauche.process))
(select-module tmux.schemeline.segments.lan-ip)


(define (segment.lan-ip)
  (cadr
    (string-split
      (fifth
        (process-output->string-list '(ifconfig)))
      " ")))


