 ;;; -*- coding: utf-8; lexical-binding: t -*-

(defun my-after-init-hook ()
                                        ;(setq debug-on-error t))
  (add-hook 'after-init-hook 'my-after-init-hook))

;; (defun my-after-save-hook ()
;;   (if (string-match "my-init-*"
;;                     (buffer-file-name))
;;       (save-excursion
;;         (byte-compile-file (buffer-file-name)))))
;; (add-hook 'after-save-hook
;;           'my-after-save-hook)



;; dired
(add-hook 'dired-load-hook
          (function (lambda () (load "dired-x"))))
(setq dired-guess-shell-alist-user
      `(( ,(rx  "."
                (or "jpg"
                    "png"
                    "bmp"
                    "gif")
                line-end)
          "kuva")))

(provide 'my-init-hook)
