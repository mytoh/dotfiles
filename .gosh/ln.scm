#!/usr/local/bin/gosh

(use gauche.process)
(use file.util)

(define gitdir "~/local/git/dotfiles/")
(define dotfiles (list
                       ".lighty/etc/lighttpd.conf"
                       ".lighty/etc/modules.conf"
                       ".config/awesome/rc.lua"
                       ".config/Thunar/thunarrc"
                       ".config/mdh/config"
                       ".cshrc"
                       ".cw/make"
                       ".dzen/bin/status"
                       ".emacs.d/init.el"
                       ".emacs-w3m"
                       ".fvwm2rc"
                       ".gosh/ln.scm"
                       ".gosh/stumpwm.scm"
                       ".gosh/git.scm"
                       ".gqview/gqviewrc"
                       ".gsoh/sshfs.scm"
                       ".gtkrc.mine"
                       ".jd/jd.conf"
                       ".ncmpcpp/config"
                       ".mc/ini"
                       ".mpdconf"
                       ".mplayer/config"
                       ".pentadactylrc"
                       ".portmasterrc"
                       ".qvwmrc"
                       ".qvwm-theme"
                       ".stalonetrayrc"
                       ".screenrc"
                       ".stumpwmrc"
                       ".twmrc"
                       ".tmux.conf"
                       ".vim"
                       ".vimrc"
                       ".vimperatorrc"
                       ".wbar"
                       ".xinitrc"
                       ".xmonad/xmonad.hs"
                       ".xmonad/restart.sh"
                       ".Xmodmap"
                       ".Xresources"
                       ".zshrc"))

(define (make-symlink files)
  (let loop ((files files))
       (if (null? files)
           (begin
             (newline)
             (print "finished linking!"))
           (begin
             (make-directory* (sys-dirname (string-append (expand-path "~") (car files))))
             (run-process
               `(ln -sfv
                    ,(string-append (expand-path gitdir) (car files))
                    ,(string-append (expand-path "~") (car files)))
               :wait #t)
             (loop (cdr files))))))


(make-symlink dotfiles)

