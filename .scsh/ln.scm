#!/usr/local/bin/scsh -s
!#

(define gitdir (string-append home-directory "/" "local/git/dotfiles/"))

(define dotfiles (list ".cshrc" ".vim" ".gtkrc-2.0" ".screenrc" ".xinitrc" ".stumpwmrc" ".vimrc" ".vimperatorrc" ".sawfishrc" ".Xresources"))

(let loop ((f dotfiles))
  (if (null? f)
        (display "script finished!")
      (begin
        (create-symlink (string-append gitdir (car f)) (string-append home-directory "/" (car f)) 'delete) 
        (loop (cdr f)))))



