
(add-to-list 'load-path "~/.emacs.d/elisp")
(add-to-list 'load-path "~/.emacs.d/elisp/w3m/")
(setq default-directory "~/")

;; encodings
(set-language-environment "Japanese")
(set-default-coding-systems 'utf-8)
(set-terminal-coding-system 'utf-8)
(setq file-name-coding-system 'utf-8)
(set-clipboard-coding-system 'utf-8)
(setq default-buffer-file-coding-system 'utf-8)
(prefer-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(set-buffer-file-coding-system 'utf-8-unix)
;(utf-translate-cjk-mode t)

;;disable startup message
(setq inhibit-startup-screen -1)
;; highlight region
(transient-mark-mode t)
;; highlight current line
(global-hl-line-mode t)
;; flash parens
(show-paren-mode t)
;; line by line scrolling
(setq scroll-step 1 
      scroll-conservatively 10000) 
;; backup file 
(setq make-backup-files nil)
;; share clipboard with x
(setq x-select-enable-clipboard t)
;; clock
(setq display-time-day-and-date t)
(display-time)
;; disable tool bar
(tool-bar-mode -1)
;; enable versioning for backup-files
(setq version-control t)
;; save all backup file in this directory
(setq backup-directory-alist (quote ((".*" . "~/.emacs.d/backup/"))))

;;;;;;;;;;;;;;;;;;  
;;;;; colors ;;;;;
;;;;;;;;;;;;;;;;;;
(custom-set-faces
 '(default ((t
	     (:background "#1c1c1c" :foreground "#d0d0d0")
	     )))
 '(cursor ((((class color)
             (background dark))
            (:background "#00AA00"))
           (((class color)
	     (background light))
            (:background "#999999"))
	   (t ())
	   )))

;; scheme program
(setq scheme-program-name "scsh")
; set encoding to utf-8 
(setq process-coding-system-alist
      (cons '("scsh" utf-8 . utf-8) process-coding-system-alist))
; load cmuscheme.el for scheme program
(autoload 'scheme-mode "cmuscheme" "Major mode for Schem." t)
(autoload 'run-scheme "cmuscheme" "Run an inferior Scheme process." t)

;; startup 


;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;; elisp packages ;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;

;; auto-install
;; original setting see
;; http://d.hatena.ne.jp/xorphitus/20101103/1288776927
;; M-x install-elisp
(when (require 'auto-install nil t)
  (setq auto-install-directory "~/.emacs.d/elisp/")
  ;; update package names
  (auto-install-update-emacswiki-package-name t)
  ;; enable install-elisp functions
  (auto-install-compatibility-setup))

;; auto-complete.el
(require 'auto-complete)
(global-auto-complete-mode t)

;; w3m 
;; for cvs version, following command
;; cvs -d :pserver:anonymous@cvs.namazu.org:/storage/cvsroot login
;; cvs -d :pserver:anonymous@cvs.namazu.org:/storage/cvsroot co emacs-w3m
;; cd emacs-w3m
;; autoconf
;; ./configure --with-lispdir=/home/mytoh/.emacs.d/elisp/w3m --with-icondir=/home/mytoh/.emacs.d/icons
;; make && sudo make install && sudo make install-icons30
(require 'w3m-load)

(cd "~/")
