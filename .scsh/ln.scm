#!/usr/local/bin/scsh -s
!#

(define gitdir "/home/mytoh/local/git/dotfiles/")

(define dotfiles (list ".cshrc" ".vim" ".gtkrc-2.0" ".screenrc" ".xinitrc" ".stumpwmrc" ".vimrc" ".vimperatorrc" ".sawfishrc" ".Xresources"))

(define (link f)
  (let loop ((f f))
  (if (null? f)
        (display "script finished!")
      (begin
        (create-symlink (string-append gitdir (car f)) (string-append home-directory "/" (car f))) 
        (loop (cdr f))))))

(link dotfiles)


