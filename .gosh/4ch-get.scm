#!/usr/local/bin/gosh 

(use rfc.http)

(define (get-image board thread)
(call-with-output-file "page.html"
 (lambda (out)
   (http-get "boards.4chan.org" "/" board "/res/" thread
             :sink out :flusher (lambda _ #t)))))

(define (main args)
  (get-image "g" "21035125")
  0)
