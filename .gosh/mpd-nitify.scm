#!/usr/bin/env gosh

(use gauche.process)
(use file.util)

(define (mpd-notify)
  (let ((artist (process-output->string "mpc -f '%artist%' current") :wait #t)
        (albun  (process-output->string "mpc -f '%album%'  current") :wait #t)
        (title  (process-output->string "mpc -f '%title%'  current") :wait #t))
    (print artist)
    )
  )

(define (main args)
  (mpd-notify)
  )
