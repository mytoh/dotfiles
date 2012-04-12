
(define-module panna.työkalu
  (export
    load-build-file
    commands
    )

  (use gauche.process)
  (use gauche.parameter)
  (use file.util)
  (use srfi-98)
  )

(select-module panna.työkalu)

(define-constant kaava-kansio
  ; directory contains panna build file
  (build-path (sys-getenv "PANNA_PATH")
              "kirjasto"
              "kaava"))


(define (load-build-file app)
  ; find, load kaava file 
  (load (find-file-in-paths (string-append app ".scm")
                            :paths `(,kaava-kansio)
                            :pred file-is-readable?)))



(define-syntax commands
  ; run processes
  (syntax-rules ()
    ((_ c1 )
     (run-process c1 :wait #t)
     )
    ((_ c1 c2 ...)
     (begin
       (run-process c1 :wait #t)
       (commands c2 ...)))))

