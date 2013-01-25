 ;;; -*- coding: utf-8; lexical-binding: t -*-

(add-to-list 'load-path
             (concat user-emacs-directory
                     (file-name-as-directory "inits/progmodes")))
(require 'init-gauche)
(require 'init-elisp)
(require 'init-scheme)

(provide 'init-progmodes)
