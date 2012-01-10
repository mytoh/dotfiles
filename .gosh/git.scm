#!/usr/local/bin/gosh

(use gauche.process) ; run-process
(use file.util) ; directory-list, current-directory
(load "kirkasto") #; 'make-colour

(define-constant *gitdir*  (expand-path "~/local/git/"))

(define-constant *repos*
  '("git://gauche.git.sourceforge.net/gitroot/gauche/Gauche"
    "git://code.call-cc.org/chicken-core"
    "git://gitorious.org/cmus/cmus.git"
    "git://derf.homelinux.org/feh"
    "git://a-chinaman.com/nuscsh"
    "git://git.savannah.gnu.org/screen.git"
    "git://git.savannah.nongnu.org/stumpwm"
    configs
    dotfiles
    (VoQn          Gauche-Color)
    (shirok        Gauche-makiki)
    (tmbinc        bgrep)
    (ninjaaron     bitocra)
    (koron         chalice)
    (podhmo        gauche-imlib2)
    (adamv         homebrew-alt)
    (adamv         homebrew)
    (rossy2401     img2xterm)
    (trapd00r      ls--)
    (Arrowmaster   mcomix)
    (marcomaggi    nausicaa)
    (robbyrussell  oh-my-zsh)
    (pkgng         pkgng)
    (coderholic    pyradio)
    (bmizerany     roundup)
    (holman        spark)
    (muennich      sxiv)
    (alice0775     userChromejs)
    (Griever       userChromeJS)
    (rkitover      vimpager)
    (GGLucas       vimperator-buftabs)
    (vimpr         vimperator-plugins)
    (rupa           z)
    (zsh-users     zsh-completions)
    (zsh-users     zsh-syntax-highlighting)
    (trapd00r      zsh-syntax-highlighting-filetypes)
    (hchbaw        auto-fu.zsh)
    )
  )

(define (update-gitdir)
  (let ((dirs (list (directory-list (expand-path *gitdir*) :children? #t :add-path? #t))))
    (let loop ((dirs (car dirs)))
      (if (null? dirs)
          (display "update finished!\n")
        (begin
         (display (make-colour 4 "=> "))
         (display (build-path (sys-dirname (car dirs)) (make-colour 3 (sys-basename (car dirs)))))
         (newline)
         (if (file-is-directory? (car dirs))
             (run-process '(git pull) :wait #t :directory (car dirs))
           #t)
         (newline)
         (loop (cdr dirs)))))))

(define (clone-gitdir)
  (let ((clone (lambda (url) (run-process `(git clone ,url) :wait #t))))
       (for-each
         (lambda (l)
           (if (not (file-is-directory? (x->string (car l))))
         (clone (cadr l))
         #t))
         (repo-url-directory-list))
       #t))

(define (repo-url-directory-list)
  (map
    (lambda (e)
      (cond ((string? e) (list (sys-basename (path-sans-extension e)) e))
            ((list? e)  (list (cadr e) #`"git://github.com/,(car e)/,(cadr e)"))
            ((symbol? e) (list e #`"git@github.com:mytoh/,|e|"))))
    *repos*))

(define (main args)
  (let ((previous-directory (current-directory)))
  (current-directory *gitdir*)
  (print (string-append (make-colour 3 "cloning ") "repositories"))
  (clone-gitdir)
  (newline)
  (print (string-append (make-colour 8 "updating ") "repositories"))
  (update-gitdir)
  (current-directory previous-directory)))


