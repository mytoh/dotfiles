
(define-module kirjasto.tiedosto
  (use gauche.process)
  (use gauche.sequence)
  (use file.util)
  (use kirjasto.verkko.avata)
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

(define (string-is-url? str)
  (or ( #/^https?:\/\// str)
    ( #/^http:\/\// str)))

(define (slurp file)
  (cond
    ((file-exists? file)
      (file->string file))
    ((string-is-url? file)
     (open file))
    (else
      (print "file not exists"))))

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
