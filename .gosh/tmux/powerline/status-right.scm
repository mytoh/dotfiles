#!/usr/bin/env gosh

(use gauche.process)
(use file.util)
(use tmux.powerline.segments)

(define (main args)
  (print
  (string-append "#[fg=colour52,bg=colour139]" (segment.hostname) "#[default]")
  (string-append "#[fg=colour22,bg=colour179]" (segment.time) "#[default]")
  )
  )
