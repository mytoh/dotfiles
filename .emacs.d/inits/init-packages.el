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
     (setq ac-dwim t)
     (setq ac-ignore-case t))

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

;; tabbar
(req 'tabbar
     ;; http://d.hatena.ne.jp/alfad/20100425/1272208744
     ;; http://idita.blog11.fc2.com/blog-entry-810.html
     (tabbar-mode t)
     ;; disbale buttons no left side
     (dolist (btn '(tabbar-home-button
                    tabbar-scroll-right-button
                    tabbar-scroll-left-button))
       (set btn (cons (cons "" nil)
                      (cons "" nil))))
     ;; face
     (set-face-attribute
      'tabbar-default nil :background "black")
     (set-face-attribute
      'tabbar-unselected nil
      :foreground "white"
      :background "black"
      :box '(:line-width 1 :color "white" :style released-button))
     (set-face-attribute
      'tabbar-selected nil
      :foreground "white"
      :background "gray38"
      :box '(:line-width 1 :color "white" :style pressed-button))
     (set-face-attribute
      'tabbar-button nil
      :box '(:line-width 1 :color "gray72" :style released-button))
     (set-face-attribute
      'tabbar-separator nil
      :height 60)

     ;; firefox keybind
     (global-set-key [(control tab)] 'tabbar-forward-tab)
     (global-set-key [(control shift tab)] 'tabbar-backward-tab))

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
;; powerline, github.com/jonathanchu/emacs-powrline
(add-to-load-path (concat *user-emacs-vendor-directory*
                          "emacs-powerline"))
(req 'powerline
     (setq powerline-arrow-shape 'arrow14)   ;; arrow, curve, arrow14
     )
;; nyan-mode, github.com/TeMPOraL/nyan-mode
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
