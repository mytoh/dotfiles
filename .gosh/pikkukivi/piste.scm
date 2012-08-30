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

(define *srcdir* (expand-path "~/local/git/dotfiles/"))
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


(define (link-make-symlink files)
  (if (null? files)
    ; (print "link finish")
    '()

    (let ((file (car files)))
      (cond
        ((file-exists? (build-path (home-directory) file))
         (print (string-append (colour-string 1 file) " exists, skip")))
        ((file-is-directory? (sys-dirname (build-path (home-directory) file)))
         (link-file-home file))
        (else
          (print #`"making ,(sys-dirname (build-path (home-directory) file))")
          (make-directory* (sys-dirname (build-path (home-directory) file)))
          (link-file-home file)
          ))
      (link-make-symlink (cdr files)))))

(define (link-file-home file)
  (print (string-append (colour-string 38 file)
                        " linked"))
  (sys-symlink (build-path *srcdir* file)
               (build-path (home-directory) file)))

(define (list-dotfiles)
  (for-each
    (^(f) (cond
            ((file-is-symlink? (build-path (home-directory) f))
               (print (string-append (colour-string 38 f))))
            ((file-exists? (build-path (home-directory) f))
             (print (string-append (colour-string 89 f) " is not symlink")))
            (else
               (print (string-append (colour-string 1 f) " not linked")))))
       *dotfiles*))

;; commands

(define (dot-link)
  (link-make-symlink *dotfiles*))

(define (dot-list)
  (list-dotfiles))


(define (piste args)
  (match (car args)
    ("link"
     (dot-link))
    ("list"
     (dot-list))))
