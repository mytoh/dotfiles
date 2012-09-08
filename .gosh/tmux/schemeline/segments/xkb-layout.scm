
(define-module tmux.schemeline.segments.xkb-layout
  (export
    segment.xkb-layout)
  (use gauche.process)
  (use srfi-1))
(select-module tmux.schemeline.segments.xkb-layout)

(define (segment.xkb-layout)
  (last (string-split (last (process-output->string-list "setxkbmap -query -v")) " ")))

