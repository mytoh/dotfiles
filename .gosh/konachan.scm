#!/usr/bin/env gosh

(load "util")
(use text.html-lite)
(use sxml.ssax)
(use sxml.sxpath)
(use gauche.parseopt)
(use gauche.collection)
(use srfi-1)

(define (parse-img-url str)
  (let ((url (lambda (line) (rxmatch->string (string->regexp (string-append "http\:\/\/konachan\\.com\/(image|jpeg)\/[^\"]+")) line))))
    (remove not ;; remove #f
            (delete-duplicates
             (call-with-input-string str
                                     (lambda (in)
                                       (port-map
                                        (lambda (line)
                                          (let ((match (url line)))
                                            match))
                                        (cut read-line in #t))))))))

(define (parse-last-page-number str)
  (if-let1 pagination  (rxmatch->string #/<div class\=\"pagination\">.*?<\/div>/
                                        str)
           (let ((page (call-with-input-string  pagination  (lambda (in)
                                                              (ssax:xml->sxml in ())))))
             (caddr (find-max
                     ((node-closure (ntype-names?? '(a))) page)
                     :key (lambda (e) (x->number (caddr e))))
                    ))
           1
           ; (pagination)
           ;(rxmatch->string #/(?:<a href\=\"\/post\?page\=(\d+))/
           ;str 1)
           ; (rxmatch->string  #/\.\.\. <a href\=\"\/post\?page\=\d+\&amp\;tags/
           ;                   str 1)
           ))

(define (parse-url url)
  (rxmatch-let (rxmatch #/^http:\/\/([-A-Za-z\d.]+)(:(\d+))?(\/.*)?/ url)
               (#f host #f port path)
               (values host port path)))

(define (swget url)
  (receive (host port path) (parse-url url)
           (let ((file (receive (a fname ext) (decompose-path path) (string-append fname "." ext))))
             (if (not (file-is-readable? file))
                 (http-get host path
                           :sink (open-output-file file) :flusher (lambda (s h) (print file) #t))))))

(define (get-tags-page page-number tag)
  (receive (status head body)
           (http-get "konachan.com" (string-append "/post?page=" (number->string page-number) "&tags=" tag))
           body ))

(define (get-tags-pages tag)
  (let ((last (x->number (parse-last-page-number (get-tags-page 1 tag)))))
    (dotimes (num last)
      (print (make-colour 99 (+ num 1)))
      (map
       (lambda (u)
         (swget u))
       (parse-img-url (get-tags-page (+ num 1) tag))))))

(define (mkdir dir)
  (if (not (file-exists? dir))
      (make-directory* dir)))

(define (cd dir)
  (if (file-is-directory? dir)
      (current-directory dir)))

(define (main args)
  (let-args (cdr args)
            ((tag "t|tag=s")
             . rest)
            (mkdir tag)
            (cd tag)
            (get-tags-pages tag)
            (cd "..")))

