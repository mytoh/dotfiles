
(define-module kirjasto.tiedosto
  (use gauche.process)
  (use gauche.sequence)
  (use file.util)
  (use kirjasto.verkko.avata)
  (require-extension
    (srfi 11 13))
  (export
    cat-file ))
(select-module kirjasto.tiedosto)

(define (cat-file args)
  (cond
    ((list? args)
     (for-each (^ (file)
                 (call-with-input-file file
                   (^ (in)
                     (copy-port in (current-output-port)))))
               args))
    ((string? args)
     (call-with-input-file args
       (^ (in)
         (copy-port in (current-output-port)))))))

