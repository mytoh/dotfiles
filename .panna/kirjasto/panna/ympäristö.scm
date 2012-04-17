(define-module panna.ympäristö
(use gauche.parameter)
(use file.util)
(export
  git-kansio
  hg-kansio
  svn-kansio
  
  kaava-kansio

  homepage

  use-clang))
(select-module panna.ympäristö)


(define git-kansio (make-parameter (build-path (sys-getenv "PANNA_PREFIX") "riisi" "git")))
(define svn-kansio (make-parameter (build-path (sys-getenv "PANNA_PREFIX") "riisi" "svn")))
(define hg-kansio (make-parameter (build-path (sys-getenv "PANNA_PREFIX") "riisi" "hg")))

(define homepage (make-parameter "package home url"))

(define (use-clang)
     (sys-putenv "CC=clang")
     (sys-putenv "CC=clang")
     (sys-putenv "CXX=clang++")
     (sys-putenv "CPP=clang-cpp")
     (sys-putenv "OBJC=clang")

     (sys-putenv "NO_WERROR=")
     (sys-putenv "WERROR=")
     ; disable all warnings
     (sys-putenv "CPPFLAGS=-w")
     (sys-putenv "CFLAGS=-w")
  )

(define-constant kaava-kansio
  (build-path (sys-getenv "PANNA_PREFIX")
              "kirjasto"
              "kaava"))


(provide "panna.ympäristö")
