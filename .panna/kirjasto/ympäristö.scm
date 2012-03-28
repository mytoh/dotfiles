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
