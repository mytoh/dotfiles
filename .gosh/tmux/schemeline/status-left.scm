#!/usr/bin/env gosh

(use gauche.process)
(use file.util)
(use tmux.schemeline.segments)
(use tmux.schemeline.lib)

(define (main args)
  (print
    (string-append
      (make-segment "234" "148" segment.tmux-session)
      ; (make-segment "255" "24" segment.lan-ip)
      ))
  )


