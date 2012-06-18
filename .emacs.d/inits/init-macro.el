;;; -*- coding: utf-8; lexical-binding: t -*-
(eval-when-compile
 (require 'cl))

;; http://e-arrows.sakura.ne.jp/2010/03/macros-in-emacs-el.html
(defmacro req (lib &rest body)
  "load library if file is exits"
  `(when (locate-library (symbol-name ,lib))
     (require ,lib nil 'noerror)
     ,@body))

(defmacro add-to-load-path (path)
  `(when (file-exists-p ,path)
     (add-to-list 'load-path ,path)))

(defmacro set-face-colours (face fore back)
`(progn
(set-face-foreground ,face ,fore)
(set-face-background ,face ,back)))

(defmacro update-vendor-directory (path)
  `(lexical-let ((paths (directory-files ,path t "[^\.]"))
        (directory-is-git-p (function (lambda (p)
                                (if (directory-files p nil "\.git$") t nil)))))
       (mapc
        (function (lambda (d)
                    (when (funcall directory-is-git-p d)
                      (progn
                        (cd d)
                        (message "updating vendor plugin %s" d)
                        (start-process "git" nil "git" "pull")))))
        paths)))

(provide 'init-macro)
