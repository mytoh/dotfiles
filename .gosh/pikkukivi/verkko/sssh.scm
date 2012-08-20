
(define-module pikkukivi.verkko.sssh
  (export
    sssh)
  (use gauche.process)
  (use util.list) ; slices
  (use file.util)
  (require-extension (srfi 1 13))    ; iota
  )
(select-module pikkukivi.verkko.sssh)

(define (sssh args)
  (run-process `(ssh ,@args) :wait #t))
