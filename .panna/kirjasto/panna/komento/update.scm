
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
                 'svn)))))
    ; update one repository
    (if (not (null-list? pullo))
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
                  '(svn update)))))

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
                              '(svn update)))))
                  repos)))))


(define (main args)
  (if (<= 2 (length args))
    (update (cadr args))
    (update )
    )
  )

