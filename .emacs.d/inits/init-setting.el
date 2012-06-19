;;; -*- coding: utf-8; lexical-binding: t -*-
;; personal initialize
;; plugin directory
(setq *user-emacs-vendor-directory* (concat user-emacs-directory (file-name-as-directory "vendor")))
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
(set-language-environment 'Japanese)
(set-default-coding-systems 'utf-8-unix)
(set-terminal-coding-system 'utf-8-unix)
(setq file-name-coding-system 'utf-8-unix)
(set-clipboard-coding-system 'utf-8-unix)
(setq buffer-file-coding-system 'utf-8-unix)
(prefer-coding-system 'utf-8-unix)
(set-keyboard-coding-system 'utf-8-unix)
(set-buffer-file-coding-system 'utf-8-unix)

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
;; line by line scrolling
(setq scroll-step 1)
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
(setq history-length 3000)
;; disable bell
(setq ring-bell-function nil)
(setq visible-bell nil)
;; show buffer list by C-x b
(iswitchb-mode t)

;; gauche
(setq process-coding-system-alist
      (cons '("gosh" utf-8 . utf-8) process-coding-system-alist))
(setq scheme-program-name "gosh -i")
(autoload 'scheme-mode "cmuscheme" "Major mode for Scheme." t)
(autoload 'run-scheme  "cmuscheme" "Run an inferior Scheme process." t)

(provide 'init-setting)
