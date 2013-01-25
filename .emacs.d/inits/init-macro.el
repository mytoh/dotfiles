;;; -*- coding: utf-8; lexical-binding: t -*-
(eval-when-compile
  (require 'cl))

;; http://e-arrows.sakura.ne.jp/2010/03/macros-in-emacs-el.html
(defmacro* req (lib &rest body)
  "load library if file is exits"
  (cl-declare (indent 1))
  `(when (locate-library (symbol-name ,lib))
     (require ,lib nil 'noerror)
     ,@body))

(defmacro* add-hook-fn (name &rest body)
  "(add-hook-fn 'php-mode-hook
                  (require 'symfony)
                  (setq tab-width 2)"
  `(add-hook ,name #'(lambda () ,@body)))

;; (append-to-list exec-path
;;                 '("/usr/bin" "/bin"
;;                   "/usr/sbin" "/sbin"))
(defmacro* append-to-list (to lst)
  `(setq ,to (append ,lst ,to)))

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



(defmacro* my-vendor-update-packages (path)
  `(when (file-exists-p ,path)
     (lexical-let ((paths (directory-files ,path t "[^\.]")))
       (labels ( (directory-is-git-p (p)
                                     (if (directory-files p nil "\.git$") t nil)))
         (cl-mapc #'(lambda (d)
                      (when (directory-is-git-p d)
                        (progn
                          (cd-absolute d)
                          (message "updating vendor plugin %s" d)
                          (shell-command "git pull")
                          (cd user-emacs-directory))))
                  paths)))))


(defmacro* my-vendor-install-packages (packages)
  `(dolist (p ,packages)
     (if (not (file-exists-p *user-emacs-vendor-directory*))
         (make-directory *user-emacs-vendor-directory*))
     (unless (file-exists-p (concat *user-emacs-vendor-directory* (car p)))
       (cond ((%url-is-git-p (cadr p))
              (cd-absolute *user-emacs-vendor-directory* )
              (message "installing plugin " (car p))
              (shell-command (concat  "git clone " (cadr p) " " (car p))
                             *user-emacs-vendor-directory*)
              (byte-recompile-directory (concat *user-emacs-vendor-directory* (car p))))
             ( (%url-is-github-p (cadr p))
               (cd-absolute *user-emacs-vendor-directory* )
               (message "installing %s from github " (car p))
               (shell-command  (concat "git clone git://github.com/" (cadr p) " " (car p)) )
               (byte-recompile-directory (concat *user-emacs-vendor-directory* (car p))))
             (cd user-emacs-directory)))))


(provide 'init-macro)
