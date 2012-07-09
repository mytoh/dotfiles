;; -*- coding: utf-8 -*-

(define-module kirjasto.verkko.scm
  (export
    url-is-git?
    url-is-hg?
    url-is-svn?
    url-is-cvs?
    url-is-bzr?)
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

(define (url-is-hg? url)
  (cond ((rxmatch->string #/^https?:\/\/(.+?\.)?googlecode\.com\/hg/ url) #t)
        ((rxmatch->string #/^hg:\/\// url) #t)
        ((rxmatch->string #/^http:\/\/hg\./ url) #t)
        (else #f)))

(define (url-is-svn? url)
  (cond ((rxmatch->string #/^https?:\/\/(.+?\.)?googlecode\.com\/svn/ url) #t)
        ((rxmatch->string #/^https?:\/\/(.+?\.)?sourceforge\.net\/svnroot/ url) #t)
        ((rxmatch->string #/^svn:\/\// url) #t)
        ((rxmatch->string #/^svn\+http:\/\// url) #t)
        ((rxmatch->string #/^http:\/\/svn.apache.org\/repos/ url) #t)
        ((rxmatch->string #/^http:\/\/svn\./ url) #t)
        (else #f)))

(define (url-is-bzr? url)
  (cond ((rxmatch->string #/^bzr:\/\// url) #t)
        (else #f)))

(define (url-is-fossil? url)
  (cond ((rxmatch->string #/^fossil:\/\// url) #t)
        (else #f)))

(define (url-is-cvs? url)
  (cond ((rxmatch->string #/^cvs:\/\// url) #t)
        (else #f)))
