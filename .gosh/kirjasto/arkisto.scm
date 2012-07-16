
(define-module kirjasto.arkisto
  (export
    file-is-archive?
    )
  (use file.util))
(select-module kirjasto.arkisto)


(define (file-is-archive? file)
  (let ((extension (path-extension file)))
    (cond
      ((or
         (string=? extension "xz")
         (string=? extension "gz")
         (string=? extension "cbz")
         (string=? extension "cbr")
         (string=? extension "cbx")
         (string=? extension "rar")
         (string=? extension "zip"))
       #t)
      (else  #f))))

