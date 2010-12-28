
(add-to-list 'load-path "~/.emacs.d/elisp")
(add-to-list 'load-path "~/.emacs.d/elisp/w3m/")
(setq default-directory "~/")

;;; This was installed by package-install.el.
;;; This provides support for the package system and
;;; interfacing with ELPA, the package archive.
;;; Move this code earlier if you want to reference
;;; packages in your .emacs.
(when
    (load
     (expand-file-name "~/.emacs.d/elpa/package.el"))
  (package-initialize))

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
;; truncate lines
(setq truncate-lines nil)
(setq truncate-partial-width-windows nil)
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
(setq make-backup-files 0)
;; share clipboard with x
(setq x-select-enable-clipboard t)
;; clock in modeline
(setq display-time-day-and-date t)
(display-time)
;; disable tool bar
(tool-bar-mode -1)
;; enable versioning for backup-files
;;(setq version-control t)
;; save all backup file in this directory
;;(setq backup-directory-alist (quote ((".*" . "~/.emacs.d/backup/"))))

;; set initial frame size, place, font
(if (boundp 'window-system)
    (setq initial-frame-alist
	  (append (list
	           '(vertical-scroll-bars . nil) ;; scroll bars
	           '(width . 176) ;; window width
	           '(height . 52) ;; window height
	           '(top . 0)     ;; window placement
	           '(left . 0)    ;; window placement
;	           '(font . "Inconsolata 11")
	           )
	      initial-frame-alist)))
(setq default-frame-alist initial-frame-alist)

;;;;; faces  ;;;;;
(custom-set-faces
 '(default   ((t
	      (:background "#1c1c1c" 
	       :foreground "#d0d0d0" 
	       :height 80
	       ))))
 '(cursor    ((t
               (:background "white"
               ))))
 '(highlight ((t
	       (:background "DarkGoldenrod4"
		:foreground "snow"
	       ))))
 '(region    ((t
	       (:background "dark slate blue"
	       ))))
 '(modeline ((t
	      (:background "gray30"
	       :foreground "white"
	      ))))
 '(linum    ((t
	      (:inherit shadow :background "gray45"
	      )))))

;; scheme program
(setq scheme-program-name "scsh")
; set encoding to utf-8 
(setq process-coding-system-alist
      (cons '("scsh" utf-8 . utf-8) process-coding-system-alist))
; load cmuscheme.el for scheme program
(autoload 'scheme-mode "cmuscheme" "Major mode for Schem." t)
(autoload 'run-scheme "cmuscheme" "Run an inferior Scheme process." t)


;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;; elisp packages ;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;

;; auto-install
;; original setting see
;; http://d.hatena.ne.jp/xorphitus/20101103/1288776927
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
(require 'w3m-load)

;; anything
(require 'anything-startup)

;; split-root written by rubikitch
(require 'split-root)
(defvar split-root-window-height nil)
(defun display-buffer-function--split-root (buf &optional ignore)
  (let ((window (split-root-window split-root-window-height)))
    (set-window-buffer window buf)
    window))
;for anything window
(setq anything-display-function 'display-buffer-function--split-root)

(cd "~/")

