 ;;; -*- coding: utf-8; lexical-binding: t -*-

(eval-when-compile (require 'init-macro))
(require 'init-func)
(require 'init-setting)
(require 'init-package)
(require 'init-key)
(require 'init-hook)
(require 'init-face)
(require 'init-vendor)

;; system
(require 'init-darwin)
(require 'init-freebsd)

(require 'init-progmodes)

(provide 'init-load)
