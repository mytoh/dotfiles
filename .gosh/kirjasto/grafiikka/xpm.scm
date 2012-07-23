;; -*- coding: utf-8 -*-

(define-module kirjasto.grafiikka.xpm
  (export
   make-xpm)
  (use file.util))
(select-module kirjasto.grafiikka.xpm)

(define-syntax make-xpm
  (syntax-rules ()
    ((_ ?name ?data ...)
     (cond
      ((file-is-readable? ?name)
       ?name)
      (else
       (call-with-output-file
           ?name
         (lambda (out)
           (format
            out ?data
            ...))
         :if-exists #f
         :if-does-not-exist :create)
       ?name)))))

