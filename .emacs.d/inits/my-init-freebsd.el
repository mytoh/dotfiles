 ;;; -*- coding: utf-8; lexical-binding: t -*-
(when (string-equal system-type "berkeley-unix")
  (let ((my-paths `(,(expand-file-name "~/local/bin"))))
    (dolist (dir my-paths)
      ;; sakito.jp/emacs/emacsshell.html
      (when (and (file-exists-p dir) (not (member dir exec-path)))
        (setenv "PATH" (concat dir ":" (getenv "PATH")))
        (setq exec-path (append `(,dir) exec-path))))))

(provide 'my-init-freebsd)
