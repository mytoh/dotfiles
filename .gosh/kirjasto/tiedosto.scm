
(define-module kirjasto.tiedosto
  (use gauche.process)
  (use gauche.sequence)
  (use file.util)
  (require-extension
    (srfi 11 13))
  (export
    cat-file

    spit
    slurp))
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

(define (slurp file)
  #;clojure
  (file->string file))

(define (spit file string :key (append? #f))
  (cond
    (append?
      (call-with-output-file file
                             (^ (in)
                               (display string in))
                             :if-exists :append))
    (else
      (call-with-output-file file
                             (^ (in)
                               (display string in))))))
