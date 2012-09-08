#!/usr/bin/env gosh

(use gauche.process)
(use file.util)
(use tmux.schemeline.segments)

(define (main args)
  (print
  (string-append "#[fg=colour234,bg=colour148]" (segment.tmux-session) "#[default]"))
  )


