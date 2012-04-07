(use file.util)
(use gauche.process)
(require-extension (srfi 98))


(define-constant kaava-kansio
  (build-path (get-environment-variable "PANNA_PATH")
              "kirjasto"
              "kaava"))

(define (install)
  (newline)
  (display (string-append "[38;5;38m" ">>> " "[0m"))
  (print "installing files")
  (let ((file-list
          (directory-fold
            (tynnyri-directory)
            (lambda (path seed)
              (cons (list
                      path
                      (string-append
                        (panna-directory)
                        (string-scan path
                                     (tynnyri-directory) 'after)))
                    seed))
            '())))
    (for-each
      (^p (make-directory* (sys-dirname (cadr p)))
        (if (not (file-exists? (cadr p)))
          (begin
          (print (string-append
                   "linking file "
                   (make-colour 53
                                (string-scan (cadr p)
                                             (panna-directory) 'after)) ))
          (sys-symlink (car p)
                       (cadr p)))))
      file-list)))



(define (load-build-file app)
  (load (find-file-in-paths (string-append app ".scm")
                            :paths `(,kaava-kansio)
                            :pred file-is-readable?)))


(define (edit app)
  (let ((kaava-tiedosto (find-file-in-paths (string-append app ".scm")
                            :paths `(,kaava-kansio)
                            :pred file-is-readable?))
        (editor (get-environment-variable "EDITOR"))
        )

    (if editor
    (run-process `(,editor ,kaava-tiedosto) :wait #t)
    (run-process `(vim     ,kaava-tiedosto) :wait #t))))

(define-syntax commands
  ;;macro for endless loop
  (syntax-rules ()
    ((_ c1 )
     (run-process c1 :wait #t)
     )
    ((_ c1 c2 ...)
     (begin
       (run-process c1 :wait #t)
       (commands c2 ...)))))
