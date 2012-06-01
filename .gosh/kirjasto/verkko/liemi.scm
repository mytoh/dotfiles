;; -*- coding: utf-8 -*-

(define-module kirjasto.verkko.liemi
  (export
    find-all-tags)
  (use rfc.uri))
(select-module kirjasto.verkko.liemi)

(define find-all-tags
          (lambda (tag body)
                     (let loop ((str body))
                    (let  ((match (rxmatch
                                    (string->regexp
                                     (string-append "<" tag "[^>]*>.*?<\/" tag ">"))
                                    str)))
                      (cond
                        (match
                              (cons (match) (loop (match 'after))))
                        (else
                          '()))))))
