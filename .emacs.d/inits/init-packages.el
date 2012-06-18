;;; -*- coding: utf-8; lexical-binding: t -*-

;; package.el
(req 'package
     ;; load MELPA
     (add-to-list 'package-archives
                  '("melpa" . "http://melpa.milkbox.net/packages/") t)
     (add-to-list 'package-archives
                  '("marmalade" . "http://marmalade-repo.org/packages/"))
     (package-initialize))



;; rainbow-delimiters
(req 'rainbow-delimiters
     (add-hook 'scheme-mode-hook       'rainbow-delimiters-mode)
     (add-hook 'lisp-mode-hook         'rainbow-delimiters-mode)
     (add-hook 'emacs-lisp-mode-hook   'rainbow-delimiters-mode))

;; auto-complete
(req 'auto-complete
     (req 'auto-complete-config )
     (global-auto-complete-mode t)
     (define-key ac-completing-map (kbd "C-n") 'ac-next)
     (define-key ac-completing-map (kbd "C-p") 'ac-previous)
     (setq ac-dwim t))

;; dired+
(req 'dired+)

;; helm
(req 'helm-config
     (global-set-key (kbd "C-c h") 'helm-mini)
     (global-set-key (kbd "C-x C-f") 'helm-find-files)
     (helm-mode t))

;; icicles
(req 'icicles
     (icy-mode t))

;; rainbow-mode
(req 'rainbow-mode
     (rainbow-mode))

;; expand-region
(req 'expand-region
(global-set-key (kbd "C-@") 'er/expand-region)
(global-set-key (kbd "C-M-@") 'er/contract-region))

;; isearch+
(eval-after-load "isearch" '(require 'isearch+))

;; info+
(eval-after-load "info" '(req 'info+))


;;; marmalade
;; flex-autopair
(req 'flex-autopair
     (flex-autopair-mode 1))

;;; plugins under vendor directory
;; update plugins
(update-vendor-directory *user-emacs-vendor-directory*)
;; powerline
(add-to-load-path (concat *user-emacs-vendor-directory*
                          "emacs-powerline"))
(req 'powerline
     (setq powerline-arrow-shape 'arrow14)   ;; arrow, curve, arrow14
     )
;; nyan-mode
(add-to-load-path (concat *user-emacs-vendor-directory*
                          "nyan-mode"))
;; emux-el github.com/m2ym/emux-el
(add-to-load-path (concat *user-emacs-vendor-directory*
                          "emux-el"))
(req 'emux)

;;; builtin
;; show trailing whitespace
(req 'whitespace
     (setq whitespace-line-column 80)
     (setq whitespace-style '(face
                             trailing
                             lines-tail
                             space-before-tab
                             space-after-tab))
     (global-whitespace-mode t))

;; save curosr position
(req 'saveplace
(setq-default save-place t))



(provide 'init-packages)
