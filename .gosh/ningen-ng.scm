#!/usr/bin/env gosh 

(use rfc.http)
(use gauche.charconv)
(use gauche.collection)
(use file.util)

(define (cd dir)
 (if (file-is-directory? dir)
  (current-directory dir)
 )
)

(define (mkdir dir)
 (if (not (file-exists? dir))
  (make-directory* dir)
 )
)

(define (get-thread thread)
  (receive (status head body)
   (http-get "xn--u8jm6cyd8028a.net" (string-append "/1" (http-compose-query "/imgboard.php" `((res ,thread)))))
      (ces-convert body "*jp" "utf-8")
    ) ;receive
  )

(define (parse-image line)
  (let ((match
   (rxmatch->string #/src\/(\d+)[^\"]+/ line)))
       (if match
           (string-append "http://xn--u8jm6cyd8028a.net/1/" match)
           #f))
  )

;; (swget
(define (parse-url url)
  (rxmatch-let (rxmatch #/^http:\/\/([-A-Za-z\d.]+)(:(\d+))?(\/.*)?/ url)
      (#f host #f port path)
      (values host port path)))

(define (swget url)
  (receive (host port path) (parse-url url)
      (let ((file (receive (a fname ext) (decompose-path path) (string-append fname "." ext))))
           (if (not (file-is-readable? file))
               (http-get host path
                         :sink (open-output-file file) :flusher (lambda (s h) (print file) #t))
               )
           ) ;let
  )) ;define
;; )

(define (get-image thread)
  (let ((html (get-thread thread)))
     (call-with-input-string html
        (lambda (in)
          (port-for-each
            (lambda  (line)
              (let ((match (parse-image line)))
                   (if match
                   (swget match))))
              (cut read-line in #t)
            )
          )
        )
     )
  ) ;define

(define (ningen-ng thread)
  (display "[0;34m")
  (print thread)
  (display "[0m")
  (mkdir thread)
  (cd thread)
  (get-image thread)
  (cd "..")
  )


(define (main args)
  (let ((thread (cadr args)))
       (ningen-ng thread)
  )
  )
