(add-to-list 'load-path
             (concat user-emacs-directory
                                 (file-name-as-directory "inits/progmodes")))
(require 'my-init-gauche)

(provide 'my-init-progmodes)
