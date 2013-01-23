
(when (string-equal system-type "berkeley-unix")
  (let ((my-paths `("~/local/bin")))
    (setq exec-path (append my-paths exec-path))
    (setenv "PATH" (mapconcat 'identity my-paths ":"))))

(provide 'my-init-freebsd)
