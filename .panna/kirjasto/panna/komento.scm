(define-module panna.komento
  (export
    link
    edit
    update
    )

  (use gauche.process)
  (use gauche.parameter)
  (use file.util)
  (use srfi-98)
  )

(select-module panna.komento)

(define-constant kaava-kansio
  (build-path (sys-getenv "PANNA_PATH")
              "kirjasto"
              "kaava"))

(define (link app)
  (let* ((kaava  (make-parameter app))
         (panna-kansio   (make-parameter (resolve-path (sys-getenv "PANNA_PATH"))))
         (kellari-kansio (make-parameter (build-path (panna-kansio) "kellari")))
         (tynnyri-kansio (make-parameter (build-path (kellari-kansio) (kaava))))
         )
    (newline)
    (display (string-append "[38;5;38m" ">>> " "[0m"))
    (print "installing files")
    (let ((file-list
            (directory-fold
              (tynnyri-kansio)
              (lambda (path seed)
                (cons (list
                        path
                        (string-append
                          (panna-kansio)
                          (string-scan path
                                       (tynnyri-kansio) 'after)))
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
                                                 (panna-kansio) 'after)) ))
              (sys-symlink (car p)
                           (cadr p)))))
        file-list))))

(define (edit app)
  (let ((kaava-tiedosto (find-file-in-paths (string-append app ".scm")
                                            :paths `(,kaava-kansio)
                                            :pred file-is-readable?))
        (editor (sys-getenv "EDITOR")))

    (if editor
      (run-process `(,editor ,kaava-tiedosto) :wait #t)
      (run-process `(vim     ,kaava-tiedosto) :wait #t))))


(define (update)
  (let ((vcs-directory
          (lambda ()
            (cond
              ((file-exists? (build-path (current-directory) ".hg"))
               'hg)
              ((file-exists? (build-path (current-directory) ".git"))
               'git)
              ((file-exists? (build-path (current-directory) ".svn"))
               'svn)))))
    (ecase (vcs-directory)
           ; error if directory is not vcs directory
           ((hg)
            (run-process '(hg pull) :wait #t)
            (run-process '(hg update) :wait #t))
           ((git)
            (run-process '(git pull) :wait #t))
           ((svn)
            (run-process '(svn update) :wait #t)))))
