;;; -*- coding: utf-8; lexical-binding: t -*-
;; personal initialize
;; plugin directory
(setq *user-emacs-vendor-directory* (expand-file-name (concat user-emacs-directory (file-name-as-directory "vendor"))))
;; user elisps
(my-add-to-load-path (concat user-emacs-directory "elisp"))

;;disable startup message
(setq inhibit-startup-screen -1)
(show-paren-mode)

;; syntax highlight
(global-font-lock-mode t)
(setq font-lock-maximum-decoration t)

;; read symlinked file
(setq vc-follow-symlinks t)

;; encodings
(prefer-coding-system 'utf-8-unix)

;; start server
(if window-system
      (server-start))

;; use space instead of tab
(setq-default tab-width 4 indent-tabs-mode nil)
(setq indent-line-function 'indent-relative-maybe)
;; show info on mode-line
(progn
  (setq display-time-24hr-format t)
  (setq display-time-day-and-date t)
  (display-time)
  (line-number-mode t)
  (column-number-mode t))
;; change yes-no to y-n
(fset 'yes-or-no-p 'y-or-n-p)
;; show images
(auto-image-file-mode t)
;; highlight region
(transient-mark-mode t)
;; highlight current line
(global-hl-line-mode nil)
;; smooth scrolling
(setq redisplay-dont-pause t
      scroll-margin 1
      scroll-step 1
      scroll-conservatively 10000
      scroll-preserve-screen-position 1)
;; disable bars
(menu-bar-mode t)
(tool-bar-mode -1)
;; delete whole line with C-k once
(setq kill-whole-line t)
;; enable rectangular mode
(cua-mode t)
(setq cua-enable-cua-keys nil) ; don't make fancy keymaps
;; delete auto save file when exit
(setq delete-auto-save-files t)
;; ignore case
(setq completion-ignore-case t)
(setq read-file-name-completion-ignore-case t)
;; alaways show completions
(icomplete-mode t)
;; show function name
(which-function-mode t)
;; enable lexical binding
(setq lexical-binding t)
;; save buffer history
(savehist-mode 1)
(setq history-length 100)
;; disable bell
(setq ring-bell-function nil)
(setq visible-bell nil)
;; no warnings when compile
(setq byte-compile-warnings '(not cl-functions))

;; dont split verticaly
(setq split-height-threshold nil)
(setq split-width-threshold nil)

;; backup and autosave
(setq *my-backup-directory*
      (file-name-as-directory (concat user-emacs-directory "backup")))
(setq *my-autosave-directory*
      (file-name-as-directory (concat user-emacs-directory "autosave")))
(setq auto-save-file-name-transforms
      `((".*" ,(concat *my-autosave-directory* "\\1") t)))
(setq backup-directory-alist
      `((".*" . ,*my-backup-directory*)))
(make-directory *my-autosave-directory* t)
(make-directory *my-backup-directory* t)

;; save more recent files
(setq recentf-max-saved-items 100)
;; undo
(setq undo-limit 100000)
(setq undo-string-limit 1300000)


(provide 'my-init-setting)
