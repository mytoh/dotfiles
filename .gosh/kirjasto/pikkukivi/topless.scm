(define-module pikkukivi.topless
  (export topless)
  (use gauche.process)
  (use kirjasto.komento.työkalu)
  (use kirjasto.väri)
  (use kirjasto.merkkijono)
  (require-extension (srfi 1 13 27))
  )
(select-module pikkukivi.topless)

(define (topless args)
  (dynamic-wind 
  (run-process '(tput sc) :wait #t)  
  (let loop ()

    (run-process '(tput cl) :wait #t)
    (run-process `(,@args) :wait #t)
    (sys-sleep #e2e0)
    (run-process '(tput cl) :wait #t)
    (loop)) 
  (run-process '(tput rc) :wait #t))  
  )
