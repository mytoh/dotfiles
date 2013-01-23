(add-to-list 'load-path
             (concat user-emacs-directory
                     (file-name-as-directory "inits/progmodes")))
(require 'my-init-gauche)
(require 'my-init-elisp)
(require 'my-init-scheme)

(provide 'my-init-progmodes)
