(use gauche.process)
(use file.util)

(define (colour-process command)
  (with-input-from-process command
    (lambda ()
      (port-for-each
        (lambda (in)
          (print
            (regexp-replace* in
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
                             )))
        read-line))))

(define (main args)
(current-directory "/usr/src")
  (colour-process "sudo make cleandir")
  (colour-process "sudo make cleandir")
  (colour-process "sudo make -j3 buildworld")
  (colour-process "sudo make -j3 buildkernel")
  ; (colour-process "sudo make -j3 installkernel")
  )
