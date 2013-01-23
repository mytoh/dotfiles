 ;;; -*- coding: utf-8; lexical-binding: t -*-

(add-to-list 'auto-mode-alist '("\\.emacs-w3m\\'" .  emacs-lisp-mode))

(font-lock-add-keywords
 'emacs-lisp-mode
 '(("'\\([0-9a-zA-Z-]*\\)" (1 'font-lock-variable-name-face))))

(defun my-buffer-enable-reindent ()
  (interactive)
  (add-hook 'before-save-hook 'my-indent-buffer nil t))

(add-hook 'emacs-lisp-mode-hook 'my-buffer-enable-reindent)
(add-hook 'emacs-lisp-mode-hook 'checkdoc-minor-mode)


(provide 'my-init-elisp)
