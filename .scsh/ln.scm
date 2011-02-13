#!/usr/local/bin/scsh -s
!#

(define gitdir (string-append home-directory "/" "local/git/dotfiles/"))

(define dotfiles (list ".emacs" ".emacs-w3m" ".complete.tcsh" ".twmrc" ".cshrc" ".vim" ".gtkrc-2.0" ".screenrc" ".xinitrc" ".stumpwmrc" ".vimrc" ".vimperatorrc" ".sawfishrc" ".Xresources"))

(let loop ((f dotfiles))
  (if (null? f)
	(begin
        (display "script finished!")
	(newline))
      (begin
        (create-symlink (string-append gitdir (car f)) (string-append home-directory "/" (car f)) 'delete) 
	(display (string-append "symlinking " (car f)))
	(newline)
        (loop (cdr f)))))



