;;; -*- coding: utf-8; lexical-binding: t -*-
;; personal initialize
;; plugin directory
(setq *user-emacs-vendor-directory* (concat user-emacs-directory (file-name-as-directory "vendor")))
;; user elisps
(add-to-load-path (concat user-emacs-directory "elisp"))
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

;;; faces

(set-face-colours 'default "#d0d0d0" "gray7")
(set-face-colours 'highlight "white" "gray11")
(set-face-colours 'modeline "white"  "gray30")
(set-face-colours 'mode-line-buffer-id "linen" "gray15")

;;(set-face-font 'default "Konatu-12")

(set-face-foreground 'font-lock-comment-face "gray35")
(set-face-background 'region "dark slate blue")
(set-face-background 'cursor  "white")

(custom-set-faces
 '(default
    ((t (:height 110
         )))))

;; transparent 
;; http://www.emacswiki.org/emacs/TransparentEmacs
(set-frame-parameter (selected-frame) 'alpha '(85 50))
(add-to-list 'default-frame-alist '(alpha 85 50))

;; gauche
(setq process-coding-system-alist
      (cons '("gosh" utf-8 . utf-8) process-coding-system-alist))
(setq scheme-program-name "gosh -i")
(autoload 'scheme-mode "cmuscheme" "Major mode for Scheme." t)
(autoload 'run-scheme  "cmuscheme" "Run an inferior Scheme process." t)

(provide 'init-setting)
