;;; -*- coding: utf-8; lexical-binding: t -*-
(eval-when-compile
 (require 'cl))

;; http://e-arrows.sakura.ne.jp/2010/03/macros-in-emacs-el.html
(defmacro* my-req (lib &rest body)
  "load library if file is exits"
  (declare (indent 2))
  `(when (locate-library (symbol-name ,lib))
     (require ,lib nil 'noerror)
     ,@body))

(defmacro* my-add-to-load-path (path)
  (declare (indent 1))
  `(when (file-exists-p ,path)
     (add-to-list 'load-path ,path)))

(defmacro* my-set-face-colours (face fore back)
  `(progn
     (set-face-foreground ,face ,fore)
     (set-face-background ,face ,back)))

(defmacro* %url-is-git-p (url)
  `(cond ((or (string-match (rx "git://") ,url)
               (string-match  (rx ".git" (zero-or-one "/") line-end) ,url))
               t)
           (t nil)))

(defmacro* %url-is-github-p (url)
  `(cond ((string-match
            (rx   line-start
                  (one-or-more (or (syntax symbol) (syntax word)))
                  "/"
                  (one-or-more (or (syntax symbol)
                                (syntax word)))
                  line-end)
            ,url)
           t)
         (t nil)))

(defmacro* my-shell-command (command-string)
  (cond
   ((typep command-string 'string)
    `(start-process-shell-command "shell-command" nil ,command-string))))

(defmacro* my-vendor-update-packages (path)
  `(when (file-exists-p ,path)
     (lexical-let ((paths (directory-files ,path t "[^\.]")))
                   (labels ( (directory-is-git-p (p)
                                                    (if (directory-files p nil "\.git$") t nil)))
       (cl-mapc (function* (lambda (d)
                                 (when (directory-is-git-p d)
                                   (progn
                                     (cd-absolute d)
                                     (message "updating vendor plugin %s" d)
                                     (my-shell-command "git pull")
                                     (cd user-emacs-directory)))))
                   paths)))))

(defmacro* my-vendor-install-packages (packages)
  `(dolist (p ,packages)
     (unless (file-exists-p (concat *user-emacs-vendor-directory* (car p)))
       (cond ((%url-is-git-p (cadr p))
              (cd-absolute *user-emacs-vendor-directory* )
              (message "installing plugin " (car p))
              (start-process "shell-command" nil "git" "clone" (cadr p) (car p)))
             ( (%url-is-github-p (cadr p))
              (cd-absolute *user-emacs-vendor-directory* )
              (message "installing %s from github " (car p))
              (start-process "shell-command" nil
                             "git" "clone" (concat "git://github.com/" (cadr p)) (car p))))
       (cd user-emacs-directory))))


(provide 'my-init-macro)
