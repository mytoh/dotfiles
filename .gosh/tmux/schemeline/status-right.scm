#!/usr/bin/env gosh

(use gauche.process)
(use file.util)
(use tmux.schemeline.segments)
(use tmux.schemeline.lib)


(define (main args)
  (print
    (make-segment "234" "148" segment.tmux-title)
    (make-segment "0"  "33" segment.hostname)
    (make-segment "136" "240" segment.cpu-freq)
    (make-segment "117" "125" segment.xkb-layout)
    (make-segment "255" "24" segment.lan-ip)

    (make-segment "136" "235" segment.time)
    ))
