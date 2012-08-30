
(define-module pikkukivi.print-path
  (export
    print-path)
  (use gauche.process)
  (use util.list) ; slices
  (use util.match)
  (use file.util)
  (use srfi-98)    ; iota
  (use kirjasto.tiedosto)
  (use kirjasto.väri))
(select-module pikkukivi.print-path)


(define (print-path args)
  (for-each print
       (string-split  (get-environment-variable "PATH")
                      ":")))
