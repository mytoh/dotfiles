
(define-module panna.työkalu
  (use gauche.process)
  (use gauche.parameter)
  (use file.util)
  (require-extension (srfi 98))
  (export
    load-build-file
    colour-string
    commands
    )
  )
(select-module panna.työkalu)


(define-constant kaava-kansio
  ; directory contains panna build file
  (build-path (sys-getenv "PANNA_PREFIX")
              "kirjasto"
              "kaava"))

(define (load-build-file pullo)
  ; find, load kaava file 
  (load (find-file-in-paths (string-append pullo ".scm")
                            :paths `(,kaava-kansio)
                            :pred file-is-readable?)
        ))

(define-syntax commands
  ; run processes
  (syntax-rules ()
    ((_ c1 )
     (run-process c1 :wait #t))
    ((_ c1 c2 ...)
     (begin
       (run-process c1 :wait #t)
       (commands c2 ...)))))

(define (colour-string colour-number str)
  ;; take any -> return string
  (string-append "[38;5;" (x->string colour-number) "m" (x->string str) "[0m"))

(provide "panna.työkalu")
