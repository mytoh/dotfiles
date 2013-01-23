
(when (string-equal system-type "darwin")
  (let ((my-paths `("~/local/homebrew/bin")))
    (setq exec-path (append my-paths exec-path))
    (setenv "PATH" (mapconcat 'identity my-paths ":")))
  (define-key global-map (kbd "<s-return>") 'darwin-toggle-fullscreen))

(defun darwin-toggle-fullscreen ()
  "Toggle full scree on darwin"
  (interactive)
  (set-frame-parameter
   nil 'fullscreen
   (when (not (frame-parameter nil 'fullscreen)) 'fullboth)))

(provide 'my-init-darwin)
