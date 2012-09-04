#!/usr/bin/env gosh

(use gauche.process)
(use file.util)
(use tmux.powerline.segments)
(use tmux.powerline.lib)


(define (main args)
  (print
    (make-segment "239" "119" segment.tmux-title)
    (make-segment "15"  "69" segment.hostname)
    (make-segment "17" "193" segment.cpu_freq)
    (make-segment "239" "79" segment.xkb-layout)

    (make-segment "239" "179" segment.time)
    ))
