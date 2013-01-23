
(when (string-equal system-type "darwin")
  (let ((my-paths `("~/local/homebrew/bin")))
    (setq exec-path (append my-paths exec-path))
    (setenv "PATH" (mapconcat 'identity my-paths ":"))))

(provide 'my-init-darwin)
