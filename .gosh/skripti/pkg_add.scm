#!/usr/local/bin/gosh

(use gauche.process)
(use file.util)

(define package-list
  (list
    "fortune-mod-bible"
    "portmaster"
    "psearch"
    "portconf"
    "virtualbox-ose-additions"
    "ja-font-mplus"
    "ja-ibus-skk"
    "nspluginwrapper"
    "firefox"
    "rxvt-unicode"
    "vim"
    "jfbterm"
    "tmux"
    "dmenu"
    "zsh"
    "terminus-font"
    "xorg"
    "thunar"
    "thunar-archive-plugin"
    "thunar-media-tags-plugin"
    "thunar-vcs-plugin"
    "thunar-volman-plugin"
    "linux_base-f10"
    "w3m-m17n-img"
    "icedtea-web"
    ))

(define (pkg-add plist)
  (let loop ((plist plist))
       (if (null? plist)
           (begin
             (newline)
             (print "all packages added"))
           (begin
             (run-process
               `(sudo pkg_add -r ,(car plist))
               :wait #t)
             (loop (cdr plist))))))

(define (main args)
  (pkg-add package-list)
  )
