
(define-module kirjasto.pääte
  (use gauche.process)
  (use file.util)
  (export
    screen-title
    print-repeat
    )
  )

(select-module kirjasto.pääte)

(define (screen-title command)
  (display (string-append "k" command "\\")))

(define (print-repeat string-list inter)
  (for-each (^i (format (current-output-port) "~a\r" i)
              (flush)
              (sys-select #f #f #f inter))
            string-list))
