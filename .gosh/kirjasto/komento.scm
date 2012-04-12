(define-module kirjasto.komento
  (export
    cd
    mkdir)

  (use gauche.process)
  (use file.util)
  )

(select-module kirjasto.komento)

(define (mkdir kansio)
  (if (not (file-exists? kansio))
    (make-directory* kansio)))

(define (cd kansio)
  (if (file-is-directory? kansio)
    (current-directory kansio)))
