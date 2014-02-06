;;; init.el -*- lexical-binding: t -*-

(setq navi2ch-mona-enable t)
(setq navi2ch-mona-face-variable 'navi2ch-mona12-face)
(setq navi2ch-message-user-name "")
;; get all article
(setq navi2ch-article-auto-range nil)
;; dont ask on quit
(setq navi2ch-ask-when-exit nil)
;; add host list
(add-to-list 'navi2ch-2ch-host-list "jbbs.shitaraba.com")

;; graphicsmagick
(when (executable-find "gm")
  (setq navi2ch-thumbnail-image-convert-program
        (executable-find "gm convert")))

(defun my-navi2ch-article-header-format-mail (_mail)
  (format " <%s> "
          (cond
           ((string-equal "age" _mail)
            "↑")
           ((string-equal "sage" _mail)
            "↓")
           (t _mail))))

(defun my-navi2ch-article-header-format-function (number name mail date)
  (when (string-match (concat "\\`" navi2ch-article-number-number-regexp
                              "\\'")
                      name)
    (navi2ch-article-set-link-property-subr (match-beginning 0)
                                            (match-end 0)
                                            'number
                                            (match-string 0 name)
                                            name))
  (let ((from-header (navi2ch-propertize "From: "
                                         'face 'navi2ch-article-header-face))
        (from (navi2ch-propertize (concat (format "[%d] " number)
                                          name
                                          (my-navi2ch-article-header-format-mail mail))
                                  'face 'navi2ch-article-header-contents-face))
        (date-header (navi2ch-propertize "📅: "
                                         'face 'navi2ch-article-header-face))
        (date (navi2ch-propertize (funcall navi2ch-article-date-format-function date)
                                  'face
                                  'navi2ch-article-header-contents-face))
        (start 0) next)
    (while start
      (setq next
            (next-single-property-change start 'navi2ch-fusianasan-flag from))
      (when (get-text-property start 'navi2ch-fusianasan-flag from)
        (add-text-properties start (or next (length from))
                             '(face navi2ch-article-header-fusianasan-face)
                             from))
      (setq start next))
    (concat  from date-header date "\n\n")))
(setq navi2ch-article-header-format-function 'my-navi2ch-article-header-format-function)

;; Local Variables:
;; coding: utf-8
;; indent-tabs-mode: nil
;; End:
