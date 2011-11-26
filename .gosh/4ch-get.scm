#!/usr/bin/env gosh

(use rfc.http)
(use rfc.uri)
(use gauche.process)
(use file.util)


(define (parse-img line)
 (rxmatch->string #/http\:\/\/images\.4chan\.org\/[^"]+/ line) 
  )

;; "

(define (fetch match)
  (if (string? match)
      (run-process `(wget ,match) :wait #t)) 
  )

(define (get-img str)
  (call-with-input-string str
               (lambda (in) 
                 (port-for-each
                   (lambda (line)
                     (let ((match (parse-img line)))
                          (fetch match)
                          )
                     )
                   (cut read-line in)
                   )))
  )

(define (mkdir dir)
  (make-directory* dir)
  )

(define (cd-up)
  (current-directory "..")
  )


(define (main args)
  (let* ((board (cadr args))
         (thread (caddr args))
         (html (values-ref (http-get  "boards.4chan.org"  (string-append "/" board "/res/" thread)) 2))
         )
        (begin
          (mkdir thread)
          (current-directory thread)
         (get-img html)
         (cd-up)
         )
         )
        )
