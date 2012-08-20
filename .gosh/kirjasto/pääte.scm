
(define-module kirjasto.pääte
  (use gauche.process)
  (use file.util)
  (export
    screen-title
    )
  )

(select-module kirjasto.pääte)

(define (screen-title command)
  (display (string-append "k" command "\\")))
