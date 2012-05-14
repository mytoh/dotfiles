#!/usr/local/bin/gosh

(use gauche.process)
(use file.util)
(use kirjasto)

(define gitdir (expand-path "~/local/git/dotfiles/"))
(define dotfiles
  '(
    ".config/fish/config.fish"
    ".config/feh"
    ".gaucherc"
    ".gosh"
    ".dzen/bin/status"
    ".dwm/startdwm"
    ".gimv/gimvrc"
    ".gtkrc.mine"
    ".ncmpcpp/config"
    ".mpdconf"
    ".mplayer/config"
    ".pentadactylrc"
    ".portmasterrc"
    ".screenrc"
    ".stumpwmrc"
    ".vimrc"
    ".bundles.vim"
    ".rtorrent.rc"
    ".vimshrc"
    ".vimperatorrc"
    ".w3m/keymap"
    ".w3m/config"
    ".w3m/mailcap"
    ".xinitrc"
    ".xbindkeysrc"
    ".xcolours/dark"
    ".xcolours/darkpastel"
    ".xcolours/darkblue"
    ".xcolours/dzen"
    ".xmonad/xmonad.hs"
    ".xmodmap"
    ".Xresources"
    ))


(define (make-symlink files)
  (if (null? files)
    (print "link finish")

    (let ((file (car files)))
      (if (or (file-exists? (build-path (home-directory) file))
            (file-is-directory? (build-path (home-directory) file))
            (file-is-symlink? (build-path (home-directory) file)))
        (print #`",(make-colour 1 file) exists!")

          (if (file-is-directory? (sys-dirname (build-path (home-directory) file)))
            (begin
              (print #`"linking ,(make-colour 38 file)")
              (sys-symlink (build-path gitdir file)
                           (build-path (home-directory) file)))
            (begin
              (print #`"making ,(sys-dirname (build-path (home-directory) file))")
            (make-directory* (sys-dirname (build-path (home-directory) file)))
              (print #`"linking ,(make-colour 38 file)")
              (sys-symlink (build-path gitdir file)
                           (build-path (home-directory) file)))
            ))
      (make-symlink (cdr files)))))



(define (main args)
  (make-symlink dotfiles)
  )

