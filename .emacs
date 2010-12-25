
(setq load-path (cons "~/.emacs.d/elisp" load-path))
(add-to-list 'load-path "~/.emacs.d/elisp/w3m/")
;;disable startup message
(setq inhibit-startup-screen -1)
;; highlight region
(transient-mark-mode t)
;; highlight current line
(global-hl-line-mode nil)
;; flash paren
(show-paren-mode t)
;; line by line scrolling
(setq scroll-step 1) 
;; backup file 
(setq make-backup-files nil)
;; share clipboard with x
(setq x-select-enable-clipboard t)
;; disable tool bar
(tool-bar-mode nil)
;; enable versioning for backup-files
(setq version-control t)
;; save all backup file in this directory
(setq backup-directory-alist (quote ((".*" . "~/.emacs.d/backup/"))))

;; colors 
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

;; install-elisp.el
(require 'install-elisp)
(setq install-elisp-repository-directory "~/.emacs.d/elisp/")

;; auto-complete.el
(require 'auto-complete)
(global-auto-complete-mode t)

;; w3m 
(require 'w3m-load)

