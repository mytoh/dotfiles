(define-module kirjasto.komento
  (use gauche.process)
  (use file.util)

  (export
    cd
    mkdir)
)

(select-module kirjasto.komento)

(define (mkdir kansio)
  (if (not (file-exists? kansio))
    (make-directory* kansio)))

(define (cd kansio)
  (if (file-is-directory? kansio)
    (current-directory kansio)))
