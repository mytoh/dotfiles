#!/usr/bin/env gosh

(use gauche.process)
(use kirjasto)

(define (title)
  (run-process '(tput sc) :wait #t)
                                        ; (run-process '(tput clear) :wait #t)
  (run-process '(tput civis) :wait #t)
  (run-process '(tput dl1) :wait #t)
  (run-process '(tput cup 0 2) :wait #t)
  (display
      (colour-string 160
        (car (sys-uname))))
  (display "pidän kainalosta")
  (newline)
  (run-process '(tput rc) :wait #t))

(define (main args)
  (while #t
    (title)
    (run-process '(sleep 1))))
