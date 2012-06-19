
(defun my-after-init-hook ()
;(setq debug-on-error t)
)

(add-hook 'after-init-hook 'my-after-init-hook)

;; dired
(add-hook 'dired-load-hook
(function (lambda () (load "dired-x"))))

(provide 'my-init-hook)
