
(define-module pikkukivi.verkko
  (export
    sssh)
  (use gauche.process)
  (use util.list) ; slices
  (use file.util)
  (require-extension (srfi 1 13))    ; iota
  (use kirjasto.komento.työkalu)
  )
(select-module pikkukivi.verkko)


(define (sssh args)
  (screen-title (car args))
  (run-process `(ssh ,@args) :wait #t))
