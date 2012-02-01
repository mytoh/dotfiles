#!/usr/local/bin/gosh

(use gauche.process)
(use file.util)

(define gitdir "~/local/git/dotfiles/")
(define dotfiles 
  (list
    ".lighty/etc/lighttpd.conf"
    ".lighty/etc/modules.conf"
    ".config/awesome/rc.lua"
    ".config/Thunar/thunarrc"
    ".config/mdh/config"
    ".config/uzbl/config"
    ".config/xfe/xferc"
    ".cshrc"
    ".cw/make"
    ".dzen/bin/status"
    ".dwm/startdwm"
    ".emacs.d/init.el"
    ".emacs-w3m"
    ".fluxbox/styles/nothing/theme.cfg"
    ".fluxbox/apps"
    ".fluxbox/conkyrc"
    ".fluxbox/conkyrc.rss"
    ".fluxbox/menuconfig"
    ".fluxbox/init"
    ".fluxbox/overlay"
    ".fluxbox/windowmenu"
    ".fluxbox/keys"
    ".fluxbox/slitlist"
    ".fluxbox/lastwallpaper"
    ".fluxbox/startup"
    ".fluxbox/usermenu"
    ".fvwm/config"
    ".gimv/gimvrc"
    ".gosh/git.scm"
    ".gqview/gqviewrc"
    ".gsoh/sshfs.scm"
    ".gtkrc.mine"
    ".gvimrc"
    ".jd/jd.conf"
    ".ncmpcpp/config"
    ".mc/ini"
    ".mpdconf"
    ".mplayer/config"
    ".mkshrc"
    ".pentadactylrc"
    ".portmasterrc"
    ".qvwmrc"
    ".qvwm-theme"
    ".stalonetrayrc"
    ".screenrc"
    ".stumpwmrc"
    ".stumpwm/modeline.scm"
    ".stumpwm/dzen.sh"
    ".torsmorc"
    ".twmrc"
    ".tmux.conf"
    ".vifm/vifmrc"
    ".vifm/colorschemes"
    ".vimrc"
    ".bundles.vim"
    ".vimshrc"
    ".vimperatorrc"
    ".w3m/keymap"
    ".w3m/config"
    ".w3m/mailcap"
    ".wbar"
    ".xinitrc"
    ".xbindkeysrc"
    ".xcolours/dark"
    ".xcolours/darkpastel"
    ".xcolours/darkblue"
    ".xcolours/dzen"
    ".xmonad/xmonad.hs"
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



(define (main args)
  (make-symlink dotfiles)
  )

