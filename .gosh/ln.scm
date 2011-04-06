#!/usr/local/bin/gosh

(use gauche.process)
(use file.util)

(define gitdir "~/local/git/dotfiles/")
(define dotfiles (list ".dzen/bin/status" ".mc/ini" ".ncmpcpp/config" ".mpdconf" ".portmasterrc" ".mplayer/config" ".qvwmrc" ".qvwm-theme" ".config/awesome/rc.lua" ".cshrc" ".cw/make" ".stalonetrayrc" ".screenrc" ".vimrc" ".gtkrc-2.0" ".xinitrc" ".emacs" ".emacs-w3m" ".Xresources"))

(define (make-symlink files) 
  (let loop ((files files))
       (if (null? files)
             (display "finished linking!\n")
           (begin 
             (make-directory* (sys-dirname (string-append (expand-path "~") (car files))))
             (run-process 
               `(ln -sfv 
                    ,(string-append (expand-path gitdir) (car files)) 
                    ,(string-append (expand-path "~") (car files)))
               :wait #t)
             (loop (cdr files))))))


(make-symlink dotfiles)
