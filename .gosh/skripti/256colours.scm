#!/usr/bin/env gosh

(use gauche.process)
(use gauche.parseopt)
(use util.match)
(use file.util)
(require-extension
  (srfi 1))

(define (system-colours)
  (print "System colors")
  (for-each
    (lambda (s)
      (display
        (format "[48;5;~Am  " s)))
    (iota 8))
  (display "[0m")
  (newline)
  (for-each
    (lambda (s)
      (display
        (format "[48;5;~Am  " s)))
    (iota 8 8))
  (display "[0m")
  (newline))

(define (colour-cube)
  (newline)
  (print "Colour cube, 6x6x6:")
  (let ((ls (iota 6)))
    (for-each
      (lambda (g)
        (for-each
          (lambda (r)
            (for-each
              (lambda (b)
                (display (format "[48;5;~Am  " (+ 16 (* r 36) (* g 6) b))))
              ls)
            (display "[0m "))
          ls)
        (newline))
      ls)))

(define (print-grayscale)
  (print "Grayscale ramp")
  (for-each
    (lambda (s)
      (display
        (format "[48;5;~Am  " s)))
    (let loop ((ls 232))
      (when (< ls 256)
        (cons ls (loop (+ ls 1))))
      ))
  (display "[0m")
  (newline))

(define (main args)
  (system-colours)
  (colour-cube)
  (print-grayscale))
