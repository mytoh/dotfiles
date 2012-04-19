
(define-module panna.kaava
(use gauche.parameter)
(use gauche.process)
(use file.util)
(export
  system
  homepage

  use-clang
  ))
(select-module panna.kaava)

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

(define homepage (make-parameter "unknown"))


(define-syntax system
  ; run processes
  (syntax-rules ()
    ((_ c )
     (begin
       (display "[38;5;99m>>> [0m")
       (for-each (lambda (s) (display #`",s ")) c)
       (newline)
     (run-process c :wait #t)))
    ((_ c1 c2 ...)
     (begin
       (display "[38;5;99m>>> [0m")
       (for-each (lambda (s) (display #`",s ")) c1)
       (newline)
       (run-process c1 :wait #t)
       (system c2 ...)))))













(provide "panna/kaava")
