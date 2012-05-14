#!/usr/bin/env gosh

(use gauche.net)
(use rfc.http)
(use gauche.parseopt)
(use gauche.collection)
(use kirjasto)

(define (parse-img-url str)
  (let ((url (lambda (line) 
               (rxmatch->string 
                 (string->regexp 
                   (string-append "\/upimg\/[^\"]+")) 
                 line))))
    (remove not ;; remove #f
             (call-with-input-string str
                                     (lambda (in)
                                       (port-map
                                        (lambda (line)
                                          (let ((match (url line)))
                                               (if match
                                            (string-append "http://vanilla.nu-ma.net" match)
                                            #f)))
                                        (cut read-line in #t)))))))



(define (get-thread id)
  (receive (status head body)
              (http-get "vanilla.nu-ma.net" (string-append "/thread.php?threadId=" (x->string id)))
              body
  )
 )

(define (get-images id)
      (map
       (lambda (u)
         (swget u))
       (parse-img-url (get-thread id))))

(define (main args)
  (let-args (cdr args)
            ((threadid "i|id=s")
             . rest)
            (mkdir threadid)
            (cd threadid)
            (get-images threadid)
            (cd "..")
))
