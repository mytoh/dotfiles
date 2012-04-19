(use file.util)
(use panna)
(use gauche.parameter)


(define (link pullo)
  (let* ((kaava  (make-parameter pullo))
         (panna-kansio   (make-parameter (resolve-path (sys-getenv "PANNA_PREFIX"))))
         (kellari-kansio (make-parameter (build-path (panna-kansio) "kellari")))
         (tynnyri-kansio (make-parameter (build-path (kellari-kansio) (kaava)))))

    (newline)
    (display (string-append "[38;5;38m" ">>> " "[0m"))
    (print "symlinking files")
    (let ((file-list
            (directory-fold
              (tynnyri-kansio)
              (lambda (path seed)
                (cons (list
                        path
                        (string-append
                          (panna-kansio)
                          (string-scan path
                                       (tynnyri-kansio)
                                       'after)))
                      seed))
              '())))
      (for-each
        (^p (make-directory* (sys-dirname (cadr p)))
          (if (not (file-exists? (cadr p)))
            (begin
              (print (string-append
                       "linking file "
                       (colour-string 163
                                     (string-scan (cadr p)
                                                  (panna-kansio) 
                                                  'after))))
              (sys-symlink (car p)
                           (cadr p)))))
        file-list))))

(define (install-package pullo)
  (let* (
        (panna   (resolve-path (sys-getenv "PANNA_PREFIX")))
        (kellari (build-path panna "kellari"))
        (tynnyri (build-path kellari pullo)) 
        (riisi   (build-path panna "riisi" pullo))
        )
  (load (find-file-in-paths (string-append pullo ".scm")
                            :paths `(,kaava-kansio) 
                            :pred file-is-readable?))

  (current-directory riisi)
  (install tynnyri)
  (link pullo)
    ))


(define (main args)
  (install-package (cadr args))
  )
