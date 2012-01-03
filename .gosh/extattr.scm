#!/usr/bin/env gosh
; works on only freebsd
(use gauche.process)
(use gauche.parseopt)

(define (write-attr args)
  (let ((attr-name-space (car args))
        (attr-name       (cadr args))
        (attr-value      (caddr args))
       (file-name        (cadddr args)))
    (run-process `(setextattr ,attr-name-space ,attr-name ,attr-value ,file-name))
    (print file-name)
    (print (string-append "[38;5;89m" attr-name-space "[0m" "." "[38;5;30m" attr-name "[0m"
                          " -> "
                          "[38;5;60m" attr-value "[0m"))))

(define (print-attr args)
  (let* ((attr-name-space (car args))
        (attr-name       (cadr args))
        (file-name       (caddr args))
        (str (process-output->string `(getextattr ,attr-name-space ,attr-name ,file-name)))
        (out (string-split str #\space))
        )
    (print (car out))
    (print (string-append "[38;5;89m" attr-name-space "[0m" "." "[38;5;30m" attr-name "[0m"
                          " -> "
                          "[38;5;60m" (cadr out) "[0m"))))

(define (delete-attr args)
  (let ((attr-name-space (car args))
        (attr-name       (cadr args))
       (file-name        (caddr args)))
    (run-process `(rmextattr ,attr-name-space ,attr-name ,file-name))
    (print file-name)
    (display "removed ")
    (print (string-append "[38;5;38m" attr-name-space "[0m" "." "[38;5;30m" attr-name "[0m"))
    )
  )

(define (list-attr args)
  (let* ((attr-name-space (car args))
         (file-name       (cadr args))
         (str (process-output->string `(lsextattr ,attr-name-space ,file-name)))
         (out (string-split str #\space))
         (file (car out))
         (attributes (cdr out))
         )
    (print file)
    (for-each
     (lambda (a)
       (display (string-append "[38;5;30m" a "[0m"))
       (display " ")
       )
     attributes)
    (newline)
    )
  )

(define (main args)
  (let-args (cdr args)
            ((w "w|write")
             (p "p|print")
             (d "d|delete")
             . restargs)
            (cond 
              (w (write-attr restargs))
              (p (print-attr restargs))
              (d (delete-attr restargs))
              (else (list-attr restargs)))))
