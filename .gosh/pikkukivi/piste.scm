;; dotfiles manager

(define-module pikkukivi.piste
  (export
    piste)
  (use gauche.process)
  (use util.list) ; slices
  (use util.match)
  (use file.util)
  (require-extension (srfi 1 13))    ; iota
  (use kirjasto.tiedosto)
  (use kirjasto.väri))
(select-module pikkukivi.piste)

(define *srcdir* (expand-path "~/local/git/dotfiles"))
(define *dotfiles*
  '(
    ".vim/after"
    ".vim/config"
    ".vim/snippets"
    ".config/fish/config.fish"
    ".config/fish/freebsd.fish"
    ".config/fish/mac.fish"
    ".config/fish/voi-minun-fish.fish"
    ".config/fish/bin"
    ".config/fish/lib"
    ".config/fish/plugins"
    ".config/fish/themes"
    ".config/feh/buttons"
    ".config/feh/keys"
    ".config/feh/themes"
    ".mksh.d"
    ".gosh"
    ".aa"
    ".dwm"
    ".ncmpc"
    ".site"
    ".stumpwm.d"
    ".tcsh.d"
    ".tmux.d"
    ".xcolours"
    ".zsh.d"
    ".Xresources"
    ".bash_profile"
    ".bashrc"
    ".complete.tcsh"
    ".emacs-w3m"
    ".gaucherc"
    ".gtkrc.mine"
    ".inputrc"
    ".mkshrc"
    ".mpdconf"
    ".pentadactylrc"
    ".portmasterrc"
    ".qvwm-theme"
    ".qvwmrc"
    ".rcrc"
    ".rtorrent.rc"
    ".screenrc"
    ".stumpwmrc"
    ".tcshrc"
    ".vimperatorrc"
    ".vimrc"
    ".vimshrc"
    ".xinitrc"
    ".xmodmaprc"
    ".xmonad/xmonad.hs"
    ".zshrc"
))


;; util
(define (path-home-file file)
  (build-path (home-directory) file))

(define (path-src-file file)
  (build-path *srcdir* file))

(define (print-list num lyst)
  (for-each (^f (print (colour-string num f)))
            lyst))

;; link
(define (link-make-symlink files)
  (if (null? files)
    '()
    (let ((file (car files)))
      (cond
        ((file-exists? (path-home-file file))
         (print (string-append (colour-string 1 file) " exists, skip")))
        ((file-is-directory? (sys-dirname (path-home-file file)))
         (link-file-home file))
        (else
          (print (string-append "making ,(sys-dirname (path-home-file file))"))
          (make-directory* (sys-dirname (path-home-file file)))
          (link-file-home file)))
      (link-make-symlink (cdr files)))))

(define (link-file-home file)
  (print (string-append (colour-string 38 file)
                        " linked"))
  (sys-symlink (path-src-file file)
               (path-home-file file)))

;; list


(define (list-not-symlinks lyst)
  (filter (^f (if (and (file-exists? (path-home-file f))
                    (not (file-is-symlink? (path-home-file f))))
                #t #f))
       lyst))

(define (list-symlinks lyst)
  (filter (^f (if (file-is-symlink? (path-home-file f))
                #t #f))
       lyst))

(define (list-managed-symlinks lyst)
  (filter (^f (if (and (file-is-symlink? (path-home-file f))
                    (file-eqv?  (sys-realpath (path-home-file f))
                                 (path-src-file f)))
                #t #f))
          lyst))

(define (list-not-managed-symlinks lyst)
  (remove (^f (if (and (file-is-symlink? (path-home-file f))
                    (file-eqv?  (sys-realpath (path-home-file f))
                                (path-src-file f)))
                #t #f))
          lyst))

(define (list-dotfiles)
  (let ((exist-files (list-not-symlinks *dotfiles*))
        (managed-files (list-managed-symlinks *dotfiles*))
        (not-managed-files (list-not-managed-symlinks *dotfiles*)))
    (print "managed files")
  (print-list 190 managed-files)
  (newline)
    (print "not symlink")
  (print-list 38 exist-files)
  (newline)
    (print "not managed files")
  (print-list 103 not-managed-files)))

;; commands

(define (dot-link)
  (link-make-symlink *dotfiles*))

(define (dot-list)
  (list-dotfiles))


(define (piste args)
  (match (car args)
    ("link"
     (dot-link))
    ((or "list" "ls")
     (dot-list))))
