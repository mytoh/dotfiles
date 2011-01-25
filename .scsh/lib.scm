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

;;for original see http://d.hatena.jp/zalawcc/20081228/1230464998