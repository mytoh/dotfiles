#!/usr/bin/env gosh

(use gauche.net)
(use file.util)
(use rfc.http)

(define (parse-url url)
  (rxmatch-let (rxmatch #/^http:\/\/([-A-Za-z\d.]+)(:(\d+))?(\/.*)?/ url)
      (#f host #f port path)
      (values host port path)))

(define (get url)
  (receive (host port path) (parse-url url)
    (call-with-output-file
      (receive (a fname ext) (decompose-path path) (string-append fname "." ext))
     (lambda (out)
       (http-get host path
            :sink out :flusher (lambda _ #t))))))

(define (main args)
      (get (cadr args)))

