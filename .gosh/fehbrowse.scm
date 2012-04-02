#!/usr/bin/env gosh

(use gauche.process)
(use gauche.parseopt)
(use util.match)
(use file.util)
(load "unpack.scm")

(define (usage status) (exit status "usage: ~a <file>\n" *program-name*))

(define (file-is-archive? file)
  (let ((extension (path-extension file)))
    (if (or (string=? extension "xz")
          (string=? extension "gz")
          (string=? extension "cbz")
          (string=? extension "cbr")
          (string=? extension "zip")
          )
      #t
      #f
      )))


(define (main args)
  (let-args (cdr args) ((#f "h|help" (usage 0)) . args)
    (match (car args)
      ((? file-is-directory? dir)
       (run-process `(feh "-F" ,dir)) :wait #t)
      ((? file-is-archive? file)
       (let ((temp (build-path 
                               (temporary-directory)
                               "fehbrowse" 
                               (string-incomplete->complete 
                                 (sys-basename 
                                   (path-sans-extension file))))))
         (make-directory* temp)
         (unpack file temp)
         (run-process `(feh -F -Z -r -q ,temp) :wait #t)
         (run-process `(rm -rf ,temp) :wait #t)
         ))
      ((? file-is-regular? file)
       (run-process `(feh -Z -F  -q --start-at ,(sys-realpath file) ,(sys-dirname (sys-realpath file))) :wait #t))
      (_ (usage 1))))
  0)
