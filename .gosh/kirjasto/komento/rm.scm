
;; -*- coding: utf-8 -*-

(define-module kirjasto.komento.rm
  (export rm)
  (use file.util)
  (use gauche.parseopt))
(select-module kirjasto.komento.rm)

(define (rm args)
 (let-args args
           ((verbose "v|verbose")
            . files)
           (cond
             (verbose
               (rm-verbose files))
             (else
               (rm-normal files)))))

(define (rm-normal files)
  (let loop ((files files))
    (cond
      ((null? files)
       '())
      (else
        (let ((file (car files)))
          (cond
            ((file-exists? file)
             (remove-files file)))
          (loop (cdr files)))))))

(define (rm-verbose files)
  (let loop ((files files))
    (cond
      ((null? files)
       '())
      (else
        (let ((file (car files)))
          (cond
            ((file-exists? file)
             (print file)
             (remove-files file)))
          (loop (cdr files)))))))
