(require 'cl)

;; package.el
(when (require 'package nil t)
  ;; load MELPA
  (add-to-list 'package-archives
	       '("melpa" . "http://melpa.milkbox.net/packages/") t)
  (package-initialize))

;; personal initialize
(add-to-list 'load-path (concat user-emacs-directory "site-lisp"))
(show-paren-mode)
(global-font-lock-mode t)

;; gauche
(setq process-coding-system-alist
      (cons '("gosh" utf-8 . utf-8) process-coding-system-alist))
(setq scheme-program-name "gosh -i")
(autoload 'scheme-mode "cmuscheme" "Major mode for Scheme." t)
(autoload 'run-scheme  "cmuscheme" "Run an inferior Scheme process." t)


;; rainbow-delimiters
(when (require 'rainbow-delimiters nil 'noerror)
  (add-hook 'scheme-mode-hook       'rainbow-delimiters-mode)
  (add-hook 'lisp-mode-hook         'rainbow-delimiters-mode)
  (add-hook 'emacs-lisp-mode-hook   'rainbow-delimiters-mode))

;; auto-complete
(require 'auto-complete)
(require 'auto-complete-config)
(global-auto-complete-mode t)
(define-key ac-completing-map (kbd "C-n") 'ac-next)
(define-key ac-completing-map (kbd "C-p") 'ac-previous)
(setq ac-dwim t)

;; dired+
(require 'dired+)

;; helm
(when (require 'helm-config nil 'noerror)
  (global-set-key (kbd "C-c h") 'helm-mini)
  (helm-mode 1))

;; icicles
(when (require 'icicles nil 'noerror)
  (icy-mode 1))

;; powerline
(require 'powerline nil 'noerror)
