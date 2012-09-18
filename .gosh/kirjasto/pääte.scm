
(define-module kirjasto.pääte
  (use gauche.process)
  (use file.util)
  (export
    screen-title
    print-repeat

    tput-cr
    tput-cursor-invisible
    tput-cursor-normal
    tput-clr-bol
    tput-clr-eol))
(select-module kirjasto.pääte)

(define (screen-title command)
  (cond (equal?  (sys-basename (sys-getenv "SHELL"))
                 "tcsh")
    (display (string-append "_" command ""))
    (else
      (display (string-append "k" command "\\")))))

(define (window-name command)
  (display  (string-append "]2;" command  "\a")))

(define (print-repeat string-list inter)
  (for-each (^i (format #t  "~a\r" i)
              (flush)
              (sys-select #f #f #f inter))
            string-list))

(define (tput-cr)
  (run-process '(tput cr) :wait #t))

(define (tput-cursor-invisible)
  (run-process '(tput civis) :wait #t))

(define (tput-cursor-normal)
  (run-process '(tput cnorm) :wait #t))

(define (tput-clr-bol)
  (run-process '(tput el1) :wait #t))

(define (tput-clr-eol)
  (run-process '(tput el) :wait #t))
