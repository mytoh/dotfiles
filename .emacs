
(add-to-list 'load-path "~/.emacs.d/elisp/")
(add-to-list 'load-path "~/.emacs.d/elisp/w3m/")
(add-to-list 'load-path "~/.emacs.d/elisp/navi2ch/")
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
;; save session
;; first, press M-x desktop-save
(desktop-load-default)
(desktop-read)
;; show images
(auto-image-file-mode t)
;; highlight region
(transient-mark-mode t)
;; highlight current line
(global-hl-line-mode nil)
;; flash parens
(show-paren-mode t)
;; line by line scrolling
(setq scroll-step 1 
      scroll-conservatively 10000) 
;; no backup file 
(setq backup-inhibited t)
;; delete autosave file when quit
(setq delete-auto-save-files t)
;; search incase-sensitive
(setq completion-ignore-case t)
;; completion
(partial-completion-mode 1)
;; always show possible completion-mode
(icomplete-mode 1)
;; don't flach cursor
(blink-cursor-mode 0)
;; share clipboard with x
(setq x-select-enable-clipboard t)
;; clock in modeline
(setq display-time-day-and-date t)
(display-time)
;; tool bar
(tool-bar-mode -1)
;; menubar
(menu-bar-mode -1)
;; highlight
(global-font-lock-mode t)
(setq font-lock-maximus-decoration t)

;; set initial frame size, place, font
(if (boundp 'window-system)
    (setq initial-frame-alist
	  (append (list
	           '(vertical-scroll-bars . nil) ;; scroll bars
	           '(width . 179) ;; window width
	           '(height . 52) ;; window height
	           '(top . 0)     ;; window placement
	           '(left . 0)    ;; window placement
	           '(font . "aquafont 11")
	           )
	      initial-frame-alist)))
(setq default-frame-alist initial-frame-alist)

;;(setq initial-scratch-message "")

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
	       (:background "HotPink2"
                        :foreground "midnight blue"
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
(setq scheme-program-name "gosh")
; set encoding to utf-8 
(setq process-coding-system-alist
      (cons '("gosh" utf-8 . utf-8) process-coding-system-alist))
; load cmuscheme.el for scheme program
(autoload 'scheme-mode "cmuscheme" "Major mode for Schem." t)
(autoload 'run-scheme "cmuscheme" "Run an inferior Scheme process." t)
;; split window
;; run scheme in one window
(defun scheme-other-window ()
  "Run scheme on other window"
  (interactive)
  (switch-to-buffer-other-window
   (get-buffer-create "*scheme*"))
  (run-scheme scheme-program-name))
;; call func by Ctrl-c 
(define-key global-map
  "\C-cS" 'scheme-other-window)

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

;; magit 
(require 'magit)

;; emms
(require 'emms)
(require 'emms-setup)
(require 'emms-i18n)
(require 'emms-mode-line)
(require 'emms-player-simple)
(require 'emms-source-file)
(require 'emms-source-playlist)

(emms-devel)
(emms-all)
(emms-default-players)
(setq emms-repeat-playlist t)
(setq emms-info-asynchronously t)
(setq emms-player-list '(emms-player-mplayer))
(setq emms-source-file-default-directory "/Volumes/My Passport/var/musica/")
(setq emms-playlist-buffer-name "*music*")
;; Show the current track each time EMMS
;; starts to play a track with "NP : "
(add-hook 'emms-player-started-hook 'emms-show)
(setq emms-show-format "NP: %s")
;; show time 
(require 'emms-playing-time)
(emms-playing-time 1)
;(emms-mode-line 1)
;; this function from "http://unixforever.blogspot.com/2010/06/sample-emms-emacs-configuration.html"
(setq emms-mode-line-mode-line-function
  (lambda nil
    (let ((track (emms-playlist-current-selected-track)))
      (let ((title (emms-track-get track 'info-title)))
	(let ((name (emms-track-get track 'name)))
	  (if (not (null title))
	      (format emms-mode-line-format title)
	    (if (not (null (string-match "^url: " (emms-track-simple-description track))))
		(format emms-mode-line-format "Internet Radio")
	      (setq name2 (replace-regexp-in-string ".*.\/" "" name))
	      (format emms-mode-line-format name2))))))))
(emms-mode-line-disable)
(emms-mode-line-enable)
(load "emms")
;; keybindings from emacswiki
(global-set-key (kbd "C-c <SPC>") 'emms-pause) 
(global-set-key (kbd "C-c p") 'emms-previous)
(global-set-key (kbd "C-c n") 'emms-next)
(global-set-key (kbd "C-c s") 'emms-stop)
(global-set-key (kbd "C-c f") 'emms-show)
(emms-add-playlist "~/.emacs.d/emms.playlist")

;;; navi2ch
(autoload 'navi2ch' "navi2ch" "Navigator for 2ch for Emacs" t)

(cd "~/")

