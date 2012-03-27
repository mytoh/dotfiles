#!/usr/bin/env gosh

;; trying to copy github.com/rupa/v
;; now only accept one word

(use gauche.process)
(use gauche.parseopt)
(use util.match)
(use file.util)
(use gauche.collection)

(define (viminfo->list)
  (with-input-from-file
    (build-path (home-directory) ".viminfo")
    (lambda ()
      (remove
        (^x (or
              ; remove name with space or unite buffer
              (not (string? x))
              (string-scan x "*unite*")))
        (port-map
          (lambda (line)
            (let ((f (#/^> (.*$)/ line)))
              (when f
                (expand-path (f 1)))))
          read-line)))))

(define (launch-vim argv)
  (run-process (append '(vim) argv) :wait #t)
  )

(define (v word)
  (if (null? word)
    (launch-vim '())
    (if (file-exists? word)
    (launch-vim `(,word))
  (let ((found (filter
                (^s (string-scan s word))
                (viminfo->list))))
     (launch-vim (list (car found)))
    ))))

(define (main args)
  (if (>= (length args) 2)
    (v (cadr args))
    (v '())
    )
  0)
