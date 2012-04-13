(define-module panna.ympäristö
(use gauche.parameter)
(use file.util)
(export
  git-kansio
  hg-kansio
  svn-kansio

  use-clang))
(select-module panna.ympäristö)


(define git-kansio (make-parameter (build-path (home-directory) "local/git")))
(define hg-kansio  (make-parameter (build-path (home-directory) "local/hg")))
(define svn-kansio (make-parameter (build-path (home-directory) "local/svn")))

(define (use-clang)
     (sys-putenv "CC=clang")
     (sys-putenv "CXX=clang++")
     (sys-putenv "CPP=clang-cpp")
     (sys-putenv "NO_WERROR=")
     (sys-putenv "WERROR=")
     ; disable all warnings
     (sys-putenv "CPPFLAGS=-w")
     (sys-putenv "CFLAGS=-w")
  )


