
(use file.util)
(use panna)
(use srfi-1)
(use gauche.parameter)

(define (update . pullo)
  (let* ( (vcs-directory
            (lambda (dir)
              (cond
                ((file-exists? (build-path dir ".hg"))
                 'hg)
                ((file-exists? (build-path dir ".git"))
                 'git)
                ((file-exists? (build-path dir ".svn"))
                 'svn)
                ((file-exists? (build-path dir "CVS"))
                 'cvs)
                ))))
    (if (not (null-list? pullo))
      ; update one repository
      (let  ((riisi (build-path (sys-getenv "PANNA_PREFIX")
                                "riisi" (car pullo ))))
        (current-directory riisi)
        (display (colour-string 155 ">>> "))
        (display "updating ")
        (display (colour-string 99 (last (string-split (current-directory) "/"))))
        (newline)
        (ecase (vcs-directory riisi)
               ((hg)
                (commands
                  '(hg pull)
                  '(hg update)))
               ((git)
                (commands
                  '(git pull --rebase)))
               ((svn)
                (commands
                  '(svn update)))
               ((cvs)
                (commands
                  '(cvs update)))
               ))

      ; update all repositories
      (let* ((riisi-kansio (build-path (sys-getenv "PANNA_PREFIX")
                                       "riisi"))
             (repos  (directory-list riisi-kansio :children? #t :add-path? #t))
             )
        (for-each (lambda (repo)
                    (current-directory repo)
                    (display (colour-string 155 ">>> "))
                    (display "updating ")
                    (display (colour-string 100 (last (string-split repo "/"))))
                    (newline)
                    (ecase (vcs-directory (current-directory))
                           ((hg)
                            (commands
                              '(hg pull)
                              '(hg update)))
                           ((git)
                            (commands
                              '(git pull --rebase)))
                           ((svn)
                            (commands
                              '(svn update)))
                           ((cvs)
                            (commands
                              '(cvs update)))
                           ))
                  repos)))))


(define (main args)
  (if (<= 2 (length args))
    (update (cadr args))
    (update )
    )
  )

