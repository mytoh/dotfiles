(add-to-list 'load-path
             (concat user-emacs-directory
                                 (file-name-as-directory "inits/progmodes")))
(require 'my-init-gauche)
(require 'my-init-elisp)

(provide 'my-init-progmodes)
