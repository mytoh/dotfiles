#!/usr/bin/env gosh

;; trying to copy github.com/rupa/v
;; now only accept one word

(use gauche.process)
(use gauche.parseopt)
(use gauche.sequence)
(use util.match)
(use file.util)
(require-extension (srfi 13))

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
  (run-process (append '(vim -X) argv) 
               :wait #t)
  )

(define (v word)
  (if (null? word)
    ; just lauche vim
    (launch-vim '())

    ; launch vim with existing file
    (if (file-exists? word)
    (launch-vim `(,word))

    ; search from viminfo file
  (let ((found (filter
                (^s (string-scan (string-downcase s) word))
                (viminfo->list))))
     (launch-vim (list (car found)))
    ))))

(define (main args)
  (if (>= (length args) 2)
    (v (cadr args))
    (v '())
    )
  0)
