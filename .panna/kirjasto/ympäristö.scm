(use gauche.parameter)
(use file.util)

(define gitdir (make-parameter (build-path (home-directory) "local/git")))
(define hgdir  (make-parameter (build-path (home-directory) "local/hg")))
(define svndir (make-parameter (build-path (home-directory) "local/svn")))

(define (use-clang)
     (sys-putenv "CC=clang")
     (sys-putenv "CXX=clang++")
     (sys-putenv "CPP=clang-cpp")
     ; disable all warnings
     (sys-putenv "CPPFLAGS=-w")
     (sys-putenv "CFLAGS=-w")
     ;
     (sys-putenv "NO_WERROR=")
     (sys-putenv "WERROR=")
  )

(define (install)
  (let ((file-list
          (directory-fold
            (tynnyri-directory)
            (lambda (path seed)
              (cons (list
                      path
                      (string-append
                        (panna-directory)
                        (string-scan path
                                     (tynnyri-directory) 'after)))
                    seed))
            '()
            )))
    (for-each
      (^p (make-directory* (sys-dirname (cadr p)))
        (if (not (file-exists? (cadr p)))
          (begin
          (print (string-append
                   "linking file"
                   (make-colour 53
                                (string-scan (cadr p)
                                             (panna-directory) 'after)) ))
          (sys-symlink (car p)
                       (cadr p))
          )
          ; (print (string-append
          ;          (make-colour 39
          ;                       (string-scan (cadr p)
          ;                                    (panna-directory) 'after))
          ;          " exists"))
          ))
      file-list)))

