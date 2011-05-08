#!/usr/local/bin/gosh

(use gauche.process)
(use file.util)

(define gitdir "~/local/git/dotfiles/")
(define dotfiles (list ".lighty/etc/lighttpd.conf" 
                       ".lighty/etc/modules.conf" 
                       ".emacs.d/init.el" 
                       ".emacs-w3m" 
                       ".fvwm2rc"
                       ".wbar"
                       ".dzen/bin/status" 
                       ".mc/ini" 
                       ".ncmpcpp/config" 
                       ".mpdconf" 
                       ".jd/jd.conf" 
                       ".portmasterrc" 
                       ".mplayer/config" 
                       ".qvwmrc" 
                       ".qvwm-theme" 
                       ".config/awesome/rc.lua" 
                       ".config/Thunar/thunarrc" 
                       ".config/mdh/config" 
                       ".cshrc" 
                       ".gtkrc.mine" 
                       ".cw/make" 
                       ".stalonetrayrc" 
                       ".vim" 
                       ".vimrc" 
                       ".vimperatorrc"
                       ".gtkrc-2.0" 
                       ".screenrc" 
                       ".stumpwmrc"
                       ".xinitrc" 
                       ".xmonad/xmonad.hs" 
                       ".xmonad/restart.sh" 
                       ".Xmodmap" 
                       ".Xresources"))

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

