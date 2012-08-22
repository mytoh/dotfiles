
(use file.util)
(use srfi-1)

(define-syntax colour-command
  (syntax-rules ()
    ((_ command regexp-list)
     (with-input-from-process
       command
       (lambda ()
         (port-for-each
           (lambda (in)
             (print
               (regexp-replace* in
                                (apply values regexp-list)
                                ; example:
                                ; #/^>>>/   "[38;5;99m\\0[0m"
                                ; #/^=*>/   "[38;5;39m\\0[0m"
                                )))
                                read-line))))
    ))

(add-load-path ".")



(define (main args)
  (print-repeat)
  )

