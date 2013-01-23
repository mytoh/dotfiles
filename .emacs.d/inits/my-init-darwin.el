
(when (string-equal system-type "darwin")
  (let ((my-paths `(,(expand-file-name "~/local/homebrew/bin"))))
    (dolist (dir my-paths)
      ;; sakito.jp/emacs/emacsshell.html
      (when (and (file-exists-p dir) (not (member dir exec-path)))
        (setenv "PATH" (concat dir ":" (getenv "PATH")))
        (setq exec-path (append `(,dir) exec-path)))))
  (define-key global-map (kbd "<s-return>") 'darwin-toggle-fullscreen))

(defun darwin-toggle-fullscreen ()
  "Toggle full scree on darwin"
  (interactive)
  (set-frame-parameter
   nil 'fullscreen
   (when (not (frame-parameter nil 'fullscreen)) 'fullboth)))

(provide 'my-init-darwin)
