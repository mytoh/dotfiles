#!/usr/bin/env gosh

(use rfc.http)
(use rfc.uri)
(use gauche.process)
(use file.util)

(define (usage )
  (format (current-error-port)
          "Usage: ~a board thread \n" "get")
  (exit 2))

(define (parse-img line)
 (rxmatch->string #/http\:\/\/images\.4chan\.org\/[^"]+/ line) 
 )

;; "

(define (fetch match)
  (if (string? match)
    (run-process `(wget -nc ,match) :wait #t)) 
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
 (if (not (file-exists? dir))
  (make-directory* dir)
 )
)

(define (cd dir)
 (if (file-is-directory? dir)
  (current-directory dir)
 )
)


(define (main args)
  (if (null? (cdr args))
      (usage)
 (let* ((board (cadr args))
        (thread (caddr args))
        (html (values-ref (http-get  "boards.4chan.org"  (string-append "/" board "/res/" thread)) 2))
       )
  (begin
   (mkdir thread)
   (cd thread)
   (get-img html)
   (cd "..")
  ))
 )
)
