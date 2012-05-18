
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
  (sys-putenv "CPP=clang-cpp")
  (sys-putenv "CXX=clang++")
  (sys-putenv "CXXCPP=clang-cpp")
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
       (let* ((p (run-process c :wait #t))
              (status (process-exit-status p)))
         (if (not  (zero? status) )
           (error #`"command fail with status ,status" c)))))
    ((_ c1 c2 ...)
     (begin
       (system c1)
       (system c2 ...)))))













(provide "panna/kaava")
