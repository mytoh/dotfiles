;; -*- coding: utf-8 -*-

(define-module kirjasto.verkko.palvelin
  (export
   define-page-handler
   )
  (use makiki))
(select-module kirjasto.verkko.palvelin)


(define define-page-handler
  (lambda (rx proc)
    (add-http-handler!
     rx
     (^(req app)
       (respond/ok
        req
        (proc req))))))

