#!/usr/bin/env gosh

(use gauche.process)
(use file.util)
(use tmux.powerline.segments)

(define (main args)
  (print
  (string-append "#[fg=colour22,bg=colour77]" (segment.tmux-session) "#[default]"))
  )


