;; -*- coding: utf-8 -*-

(define-module kirjasto.verkko.scm
  (export
      url-is-git?)
  (use file.util)
  (use rfc.uri)
  (require-extension
    (srfi 11)))
(select-module kirjasto.verkko.scm)

(define url-is-git?
  (lambda (url)
    (let-values (((scheme user-info hostname port-number path query fragment)
                  (uri-parse url)))
      (cond
       ((string=? scheme "git")
        #t)
       ((if (string? (path-extension path))  
            (string=?  (path-extension path) "git")
            #f)  
        #t)
       (else #f)))))
