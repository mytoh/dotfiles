(define-module kirjasto.komento
  (use gauche.process)
  (use file.util)

  (export
    cd
    mkdir


    run-command
    run-command-sudo
    )
)

(select-module kirjasto.komento)

(define (mkdir kansio)
  (if (not (file-exists? kansio))
    (make-directory* kansio)))

(define (cd kansio)
  (if (file-is-directory? kansio)
    (current-directory kansio)))

(define-syntax run-command
  ; run processes
  (syntax-rules ()
    ((_ c1 )
     (run-process c1 :wait #t)
     )
    ((_ c1 c2 ...)
     (begin
       (run-process c1 :wait #t)
       (run-command c2 ...)))))


(define (run-command-sudo command)
  (run-process (append '(sudo) command) :wait #t)
  )
