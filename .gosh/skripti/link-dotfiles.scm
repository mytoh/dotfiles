#!/usr/local/bin/gosh

(use gauche.process)
(use file.util)
(use kirjasto)

(define gitdir (expand-path "~/local/git/dotfiles/"))
(define *dotfiles*
  '(
    ".vim/after"
))


(define (make-symlink files)
  (if (null? files)
    (print "link finish")

    (let ((file (car files)))
      (if (or (file-exists? (build-path (home-directory) file))
            (file-is-directory? (build-path (home-directory) file))
            (file-is-symlink? (build-path (home-directory) file)))
        (print #`",(colour-string 1 file) exists!")

          (if (file-is-directory? (sys-dirname (build-path (home-directory) file)))
            (begin
              (print #`"linking ,(colour-string 38 file)")
              (sys-symlink (build-path gitdir file)
                           (build-path (home-directory) file)))
            (begin
              (print #`"making ,(sys-dirname (build-path (home-directory) file))")
            (make-directory* (sys-dirname (build-path (home-directory) file)))
              (print #`"linking ,(colour-string 38 file)")
              (sys-symlink (build-path gitdir file)
                           (build-path (home-directory) file)))
            ))
      (make-symlink (cdr files)))))



(define (main args)
  (make-symlink dotfiles)
  )

