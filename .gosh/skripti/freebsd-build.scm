(use gauche.process)
(use file.util)
(use util.match)
(require-extension (srfi 13))


(define-syntax colour-command
  (syntax-rules ()
    ((_ ?command ?regexp ?string ...)
     (with-input-from-process
       ?command
       (lambda ()
         (port-for-each
           (lambda (in)
             (print
               (regexp-replace* in
                                ?regexp ?string
                                ...)))
           read-line))))))

(define (process command)
  (print  (string-concatenate `("[38;5;80m" "==> " "[0m" ,command)))
  (colour-command command
                  #/^>>>/   "[38;5;99m\\0[0m"
                  #/^=*>/   "[38;5;39m\\0[0m"
                  #/^-*/    "[38;5;233m\\0[0m"
                  #/c\+\+\s/ "[38;5;44m\\0[0m"
                  #/(cc)\s/  "[38;5;128m\\0[0m"
                  #/\/(\w*\.cpp)/  "/[38;5;178m\\1[0m"
                  #/\/(\w*\.c)/  "/[38;5;68m\\1[0m"
                  #/(\w*\.o)/  "[38;5;148m\\1[0m"
                  #/(\w*\.(S|s)o)/  "[38;5;28m\\1[0m"
                  )
  (print (string-append "[38;5;218m" "-------------" "[0m"))
  (newline)
  (print command)
  (print
    (string-concatenate
      '("[38;5;80m" "------------" "[0m" ))))

(define (second)
  (process "mount -u /" )
  (process "mount -a -t ufs" )
  (run-process '(mergemaster -p ) :wait #t)
  (current-directory "/usr/src")
  (process "make installworld" )
  (process "yes y | make delete-old" )
  (run-process '(mergemaster ) :wait #t)
  (print "please reboot")
  (print
    " # reboot
    # mount -u /
    # mount -a -t ufs
    # cd /usr/src
    # make delete-old-libs "))

(define (first)
  (current-directory "/usr/src")
  (when (file-exists? "/usr/obj")
    (process "sudo make cleandir")
    (process "sudo make cleandir")
    (process "sudo rm -rfv /usr/obj"))
  (process "sudo make buildworld")
  (process "sudo make buildkernel")
  (process "sudo make installkernel"))




(define (main args)
  (match (cadr args)
    ("first"
     (first))
    ("second"
     (second))
    ))
