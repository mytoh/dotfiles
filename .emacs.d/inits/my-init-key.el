;;; -*- coding: utf-8; lexical-binding: t -*-

;; make prefix key
(define-prefix-command 'my-original-map)
(define-key global-map (kbd "C-q") 'my-original-map)
(define-key my-original-map (kbd "C-q") 'quoted-insert)

;; no split 
(global-set-key (kbd "C-x C-b") 'buffer-menu)

;; indent
(define-key lisp-interaction-mode-map (kbd "C-m") 'newline-and-indent)
(define-key emacs-lisp-mode-map  (kbd "C-m") 'newline-and-indent)


(provide 'my-init-key)
