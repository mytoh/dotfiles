(use gauche.process)
(use file.util)

(define-syntax colour-command
  (syntax-rules ()
    ((_ command r1 s1 ...)
     (with-input-from-process
       command
       (lambda ()
         (port-for-each
           (lambda (in)
             (print
               (regexp-replace* in
                                r1 s1
                                ...
                                )))
                                read-line))))
    ))

(define (process command)
  (print  (string-append "[38;5;80m" "==> " "[0m" commad))
  (colour-command command
                  #/^>>>/   "[38;5;99m\\0[0m"
                  #/^=*>/   "[38;5;39m\\0[0m"
                  #/^-*/    "[38;5;233m\\0[0m"
                  #/c\+\+\s/ "[38;5;44m\\0[0m"
                  #/(cc)\s/  "[38;5;128m\\0[0m"
                  #/\/(\w*\.cpp)/  "/[38;5;178m\\1[0m"
                  #/\/(\w*\.c)/  "/[38;5;68m\\1[0m"
                  #/(\w*\.o)/  "[38;5;148m\\1[0m"
                  #/(\w*\.So)/  "[38;5;248m\\1[0m"
                  #/(\w*\.so)/  "[38;5;248m\\1[0m"
                  )
  (prit (string-append "[38;5;218m" "-------------" "[0m"))
  )

(define (main args)
  (current-directory "/usr/src")
  (process "sudo make cleandir")
  (process "sudo make cleandir")
  (process "sudo make -j3 buildworld")
  (process "sudo make -j3 buildkernel")
  (process "sudo make -j3 installkernel")
  )
