#!/usr/bin/env gosh

(use gauche.process)
(use file.util)

(define (mpd-notify)
  (let ((artist (process-output->string "mpc -f '%artist%' current"))
        (album  (process-output->string "mpc -f '%album%'  current"))
        (title  (process-output->string "mpc -f '%title%'  current")))
    (print artist)
    (print album)
    (print title)))

(define (main args)
  (mpd-notify)
  )
