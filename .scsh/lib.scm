;;for original see 
;; http://d.hatena.jp/zalawcc/20081228/1230464998
;; http://www.shido.info/lisp/scheme_syntax.html


(define-syntax r
  (syntax-rules ()
    ((_ pf ...)
     (run pf ...))))

(define-syntax ls
  (syntax-rules ()
    ((_)
     (run (ls)))
    ((ls arg ...)
     (run (gls arg ...)))))

(define-syntax ll
  (syntax-rules ()
    ((_ arg ...)
     (run (gls -lh --color=auto arg ...)))))

(define-syntax la 
  (syntax-rules ()
    ((_ arg ...)
     (run (gls -lah --color=auto arg ...)))))

(define-syntax cd 
  (syntax-rules ()
    ((_)
     (begin
       (setenv "OLDPWD" (cwd))
       (chdir)
       (setenv "PWD" (cwd))))
    ((_ dir)
     (let ((oldpwd (getenv "OLDPWD")))
       (setenv "OLDPWD" (cwd))
       (chdir (if (eq? '- 'dir)
                  oldpwd
                  (symbol->string 'dir)))
       (setenv "PWD" (cwd))))))

(define-syntax pwd
  (syntax-rules ()
    ((_)
     (run (pwd)))))

(define-syntax forever
  (syntax-rules ()
    ((_ e1 e2 ...)
     (let loop () e1 e2 ... (loop)))))

(define call/cc
  call-with-current-continuation)

(define-syntax when
  (syntax-rules ()
    ((_ pred b1 ...)
     (if pred (begin b1 ...)))))

(define-syntax while
  (syntax-rules ()
    ((_ pred b1 ...)
     (let loop ()
       (when pred b1 ... (loop))))))

(define-syntax for
  (syntax-rules ()
    ((_ (i from to) b1 ...)
     (let loop ((i from))
       (when (< i to)
             b1 ...
             (loop (+ 1 i)))))))

     
