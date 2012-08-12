;; -*- coding: utf-8 -*-

(define-module kirjasto.verkko.scm
  (export
    url-is-git?
    url-is-hg?
    url-is-svn?
    url-is-cvs?
    url-is-bzr?
    url-is-fossil?) 
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
  (or ( #/^https?:\/\/(.+?\.)?googlecode\.com\/hg/ url)
        ( #/^hg:\/\// url)
        ( #/^http:\/\/hg\./ url)
        ( #/^http:\/\/(.+?\/)\/hg/ url)))

(define (url-is-svn? url)
  (or ( #/^https?:\/\/(.+?\.)?googlecode\.com\/svn/ url)
        ( #/^https?:\/\/(.+?\.)?sourceforge\.net\/svnroot/ url)
        ( #/^svn:\/\// url)
        ( #/^svn\+http:\/\// url)
        ( #/^http:\/\/svn.apache.org\/repos/ url)
        ( #/^http:\/\/svn\./ url)))

(define (url-is-bzr? url)
  (cond (( #/^bzr:\/\// url) #t)
        (else #f)))

(define (url-is-fossil? url)
  (cond (( #/^fossil:\/\// url) #t)
        (else #f)))

(define (url-is-cvs? url)
  (cond (( #/^cvs:\/\// url) #t)
        (else #f)))
