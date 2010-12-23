#!/usr/local/bin/scsh -s
!#

(define vdir (string-append home-directory "/" "local/git/vimperator-plugins/"))

(define plugins (list "_libly.js" "delicious_search.js" "direct_bookmark.js" "encodingSwitcher.js" "maine_coon.js"))


(let loop ((p plugins))
     (if (null? p)
           (display "script finished!")
         (begin 
           (create-symlink (string-append vdir (car p)) (string-append home-directory "/.vimperator/plugin/" (car p)))
           (loop (cdr p)))))

