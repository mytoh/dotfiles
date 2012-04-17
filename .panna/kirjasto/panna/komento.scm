(define-module panna.komento
  (use gauche.process)
  (use gauche.parameter)
  (use file.util)
  (use srfi-98)
  (use srfi-1)
  (use panna.työkalu)

  (export
    link
    edit
    update
    list-package
    print-homepage
    uninstall
    environment
    info
    test
    initialize
    )
  )

(select-module panna.komento)

(define-constant kaava-kansio
  (build-path (sys-getenv "PANNA_PREFIX")
              "kirjasto"
              "kaava"))


(define (edit pullo)
  (let ((kaava-tiedosto (find-file-in-paths (string-append pullo ".scm")
                                            :paths `(,kaava-kansio)
                                            :pred file-is-readable?))
        (editor (sys-getenv "EDITOR")))

    (if editor
      (run-process `(,editor ,kaava-tiedosto) :wait #t)
      (run-process `(vim     ,kaava-tiedosto) :wait #t))))




(define (list-package)
  (let* ((panna   (make-parameter (resolve-path (sys-getenv "PANNA_PREFIX"))))
         (kellari (make-parameter (build-path (panna) "kellari"))))
    (map print
         (directory-list (kellari) :children? #t))))

(define (print-homepage pullo)
  )

(define (uninstall pullo)
  ()
  )

(define (info pullo)
  )

(define (environment))

(define (test)
  (print *args*)
  )

(define (initialize pullo)
  (load (find-file-in-paths (string-append pullo ".scm")
                            :paths `(,kaava-kansio) 
                            :pred file-is-readable?))
  ; (print pullo)
  ; (print (riisi))
  )


(provide "panna/komento")
