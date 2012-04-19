(define-module panna.komento
  (use gauche.process)
  (use gauche.parameter)
  (use file.util)
  (use srfi-98)
  (use srfi-1)
  (use panna.työkalu)

  (export
    print-homepage
    uninstall
    environment
    info
    test
    initialize
    )
  )

(select-module panna.komento)

(define-constant kaava-kansio
  (build-path (sys-getenv "PANNA_PREFIX")
              "kirjasto"
              "kaava"))




(define (print-homepage pullo)
  )

(define (uninstall pullo)
  ()
  )

(define (info pullo)
  )

(define (environment))

(define (test)
  (print *args*)
  )

(define (initialize pullo)
  (load (find-file-in-paths (string-append pullo ".scm")
                            :paths `(,kaava-kansio) 
                            :pred file-is-readable?))
  ; (print pullo)
  ; (print (riisi))
  )


(provide "panna/komento")
