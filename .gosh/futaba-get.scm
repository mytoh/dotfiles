#!/usr/bin/env gosh

(use rfc.http)
(use rfc.uri)
(use gauche.process)
(use gauche.charconv)
(use file.util)


(define (usage )
  (format (current-error-port)
          "Usage: ~a board thread \n" "get")
  (exit 2))

(define (parse-img line board)
  (rxmatch->string (string->regexp (string-append "http\:\/\/(\\w+)\\.2chan\\.net\/(\\w+)\/" board "\/src\/[^\"]+")) line) 
 )

;; "

(define (fetch match)
  (if (string? match)
    (run-process `(wget -nc ,match) :wait #t)) 
  )

(define (get-img str board)
 (call-with-input-string str
  (lambda (in) 
   (port-for-each
    (lambda (line)
     (let ((match (parse-img line board)))
      (fetch match)
     )
    )
    (cut read-line in #t)
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

(define (get-html b t)
  (cond ((string=? b "l") ; 二次元壁紙
         (values-ref (http-get  "dat.2chan.net"  (string-append "/" b "/res/" t ".htm" )) 2))
        ))


(define (main args)
  (if (null? (cdr args))
      (usage)
 (let* ((board (cadr args))
        (thread (caddr args))
        (html (ces-convert (get-html board thread) "*jp" "utf-8"))
       )
  (begin
   (mkdir thread)
   (cd thread)
   (get-img html board)
   (cd "..")
  ))
 )
)
