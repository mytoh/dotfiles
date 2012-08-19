
(define-module kirjasto.tiedosto
  (use gauche.process)
  (use gauche.sequence)
  (use file.util)
  (require-extension
    (srfi 11 13))
  (export
    cat-file
    ))
(select-module kirjasto.tiedosto)

(define (cat-file args)
  (cond
    ((list? args)  
     (for-each (lambda (file)
                 (call-with-input-file file
                                       (lambda (in)
                                         (copy-port in (current-output-port)))))
               args))))
