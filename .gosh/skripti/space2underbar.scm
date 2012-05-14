#!/usr/bin/env gosh

(use file.util)
(use text.tr)

(define (main args)
  (let ((snames (glob "*[ ]*")))
       (map
         (lambda (f)
           (let ((uname (string-tr f " " "_")))
                (move-file f uname)
                (print uname)
                )
           )
         snames)
       )
  )
