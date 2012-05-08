(use gauche.parameter)
(use file.util)
(use panna)


(define (link pullo)
  (let* ((kaava  (make-parameter pullo))
         (panna-kansio   (make-parameter (resolve-path (sys-getenv "OLUTPANIMO"))))
         (kellari-kansio (make-parameter (build-path (panna-kansio) "kellari")))
         (tynnyri-kansio (make-parameter (build-path (kellari-kansio) (kaava)))))
    (current-directory (panna-kansio))

    (newline)
    (display (string-append "[38;5;38m" ">>> " "[0m"))
    (print "symlinking files")
    (letrec ((relative-path
               (lambda (p)
                 (fold
                   (lambda (e str)
                     (string-append "../" str)
                     )
                   (simplify-path
                     (string-append
                       "."
                       (string-scan p
                                    (panna-kansio)
                                    'after)))
                   (string-split  (sys-dirname  (simplify-path
                                                  (string-append
                                                    "."
                                                    (string-scan p
                                                                 (tynnyri-kansio)
                                                                 'after))))
                                  #/\//))))
             (file-list
               (directory-fold
                 (tynnyri-kansio)
                 (lambda (path seed)
                   (cons (list
                           (relative-path
                             path
                             )
                           ; (string-scan  path
                           ;               (panna-kansio)
                           ;               'after)
                           (simplify-path (string-append "." (string-scan path
                                                                          (tynnyri-kansio)
                                                                          'after))))
                         seed))
                 '())))
      (for-each
        (^p
          (if  (not (file-exists? (sys-dirname (cadr p))))
          (make-directory* (sys-dirname (cadr p))))
          (if (not (file-exists? (cadr p)))
            (begin
              (print (string-append
                       "linking file "
                       (colour-string 163
                                      (cadr  p))))
              (sys-symlink (car p)
                           (cadr p)))))
        file-list))))

(define (install-package pullo)
  (let* ((panna   (resolve-path (sys-getenv "OLUTPANIMO")))
         (kellari (build-path panna "kellari"))
         (tynnyri (build-path kellari pullo))
         (riisi   (build-path panna "riisi" pullo)))
    (load (find-file-in-paths (string-append pullo ".scm")
                              :paths `(,kaava-kansio)
                              :pred file-is-readable?))

    (current-directory riisi)
    (print  (current-directory))
    (print tynnyri)
    (install tynnyri)
    (link pullo)))


(define (main args)
  (install-package (cadr args)))
