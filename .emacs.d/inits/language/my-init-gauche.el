;;http://practical-scheme.net/wiliki/wiliki.cgi?Gauche%3aEditingWithEmacs
;; gauche
(setq process-coding-system-alist
      (cons '("gosh" utf-8 . utf-8) process-coding-system-alist))
(setq scheme-program-name "gosh -i")
(autoload 'scheme-mode "cmuscheme" "Major mode for Scheme." t)
(autoload 'run-scheme  "cmuscheme" "Run an inferior Scheme process." t)
(defun scheme-other-window ()
  "run scheme on other window"
  (interactive)
  (switch-to-buffer-other-window
   (get-buffer-create "*scheme*"))
  (run-scheme scheme-program-name))

(add-hook 'scheme-mode-hook
          '(lambda  ()  (local-set-key  (kbd "C-c S") 'scheme-other-window)))

;; function from emacswiki.org/emacs/AddKeywords
(defun scheme-add-keywords (face-name keyword-rules)
   (let* ((keyword-list (mapcar #'(lambda (x)
                                   (symbol-name (cdr x)))
                                keyword-rules))
          (keyword-regexp (concat "(\\("
                                  (regexp-opt keyword-list)
                                  "\\)[ \n]")))
     (font-lock-add-keywords 'scheme-mode
                             `((,keyword-regexp 1 ',face-name))))
   (mapc #'(lambda (x)
             (put (cdr x)
                  'scheme-indent-function
                  (car x)))
         keyword-rules))

  (scheme-add-keywords
  'font-lock-keyword-face
  '((0 . use)
    (0 . require)
    (0 . require-extension)
    (1 . export)
    (1 . define-constant)
    (1 . and-let*)
    (0 . begin0)
    (1 . call-with-client-socket)
    (1 . call-with-input-conversion)
    (1 . call-with-input-file)
    (1 . call-with-input-process )
    (1 . call-with-input-string )
    (1 . call-with-iterator)
    (1 . call-with-output-conversion)
    (1 . call-with-output-file)
    (0 . call-with-output-string)
    (1 . call-with-temporary-file)
    (1 . call-with-values )
    (1 . dolist)
    (1 . dotimes )
    (2 . if-match)
    (1 . let*-values )
    (2 . let-args )
    (2 . let-keywords* )
    (2 . let-match)
    (2 . let-optionals* )
    (1 . let-syntax )
    (1 . let-values)
    (1 . let/cc )
    (2 . let1)
    (1 . letrec-syntax )
    (1 . make )
    (2  . multiple-value-bind )
    (1 . parameterize )
    (1 . parse-options )
    (2 . receive )
    (1 . rxmatch-case )
    (0 . rxmatch-cond )
    (2 . rxmatch-if  )
    (2 . rxmatch-let )
    (1 . syntax-rules )
    (1 . unless )
    (1 . until )
    (1 . when )
    (1 . while )
    (1 . with-builder)
    (0 . with-error-handler)
    (1 . with-error-to-port )
    (1 . with-input-conversion )
    (1 . with-input-from-port )
    (1 . with-input-from-process)
    (1 . with-input-from-string )
    (1 . with-iterator )
    (1 . with-module)
    (1 . with-output-conversion)
    (1 . with-output-to-port )
    (1 . with-output-to-process )
    (1 . with-output-to-string )
    (1 . with-port-locking )
    (1 . with-string-io )
    (1 . with-time-counter)
    (1 . with-signal-handlers )
    (1 . select-module)
    ))

(scheme-add-keywords
 'font-lock-function-name-face
 '(
   (1 . open-input-string )
   (1 . add-load-path)
   (1 . string=?)
   (1 . string-append)
   (1 . string->symbol)
   (1 . null-list?)
   (1 . eq?)
   (1 . string?)
   (1 . llength)
   (1 . null?)
   (1 . car)
   (1 . cdr)
   (1 . cadr)
   (1 . not)
   (1 . zero?)
   (1 . erroro)
   (1 . exit)
   (1 . newline)
   (1 . display)
   (1 . print)
    (1 . load)
   (1 . >=)
   (1 . rx-match->string)
   (1 . port-for-each)
   (1 . cut)
   (1 . read-line)
   (1 . values-ref)
   (1 . ces-convert)

   (1 . sys-setenv)
   (1 . sys-unsetenv)
   (1 . sys-getenv)

   (1 . rxmatch->string)
   (1 . string->regexp)

   ;; sxml
   (1 . ssax:xml->sxml)

   ;; makiki
   (1 . define-http-handler)
   (1 . start-http-server)

   ;; file.util
   (1 . run-process)
   (1 . build-path)
   (1 . directory-list2)

   ;; rfc.http
   (1 . http-user-agent)
   (1 . make-http-connection)
   (1 . reset-http-connection)
   (1 .  http-compose-query)
   (1 .  http-compose-form-data)
   (1 .  http-proxy)
   (1 .  http-request)
   (1 .  http-null-receiver)
   (1 .  http-string-receiver)
   (1 .  http-oport-receiver)
   (1 .  http-file-receiver)
   (1 .  http-cond-receiver)
   (1 .  http-null-sender)
   (1 .  http-string-sender)
   (1 .  http-blob-sender)
   (1 .  http-file-sender)
   (1 .  http-multipart-sender)
   (1 .  http-get)
   (1 .  http-head)
   (1 .  http-post)
   (1 .  http-put)
   (1 .  http-delete)
   (1 .  http-default-auth-handler)
   (1 .  http-default-redirect-handler)
   (1 .  http-secure-connection-available?)

   ;; rfc.uri

   ;; util.match
   (1 . match)

   ;; text.tree
   (1 . tree->string)

   ;; gacuhe.parameter
   (1 . make-parameter)
   ))


(font-lock-add-keywords 'scheme-mode
                        `(
                          ;; (use module)
                          (,(rx (and
                                 (syntax open-parenthesis)  "use" (zero-or-more (in " \t\n"))
                                 (submatch (one-or-more
                                            (submatch (or (syntax word)
                                                          (syntax symbol)))))
                                 (syntax close-parenthesis)))
                           1 'font-lock-variable-name-face)
                          ;; (require-extension (srfi 1))
                          (,(rx (and
                                 (syntax open-parenthesis) "require-extension" (zero-or-more (in "  \t\n"))
                                 (syntax open-parenthesis)
                                 (submatch
                                  "srfi")
                                 (one-or-more
                                 (one-or-more (in " \n\t"))
                                 (submatch (one-or-more numeric)))
                                 (syntax close-parenthesis)
                                 (syntax close-parenthesis)
                                 ))
                           (1 'font-lock-variable-name-face)
                           (2 'font-lock-type-face))
                          ;; (export some-function)
                          (,(rx (and
                                 (syntax open-parenthesis) "export" (zero-or-more (in " \t\n"))
                                 (submatch
                                  (one-or-more  (or (syntax word)
                                                 (syntax symbol))))))
                           1  'font-lock-variable-name-face)
                          ;; (select-module module)
                          (,(rx (and
                                  (syntax open-parenthesis) "select-module" (zero-or-more (in " \t\n"))
                                  (submatch
                                   (one-or-more (or (syntax symbol)
                                    (syntax word))))))
                             1  'font-lock-type-face)
                          ;; ,@
                          (,(rx ",@")
                           0 'font-lock-warning-face)
                          ;; #t #f
                          (,(rx (or  "#t" "#f"))
                           0 'font-lock-warning-face)
                          ))


;; scheme mode recognition
(add-to-list 'auto-mode-alist '("\\.leh\\'" . scheme-mode))

;;http://d.hatena.ne.jp/kobapan/20091205/1259972925
;; scheme-mode-hook
(defvar ac-source-scheme
  '((candidates
      (lambda ()
         (my-req 'scheme-complete)
         (all-completions ac-target (car (scheme-current-env))))))
  "Source for scheme keywords.")
(add-hook 'scheme-mode-hook
          (lambda ()
              (add-to-list 'ac-sources 'ac-source-scheme)))

(provide 'my-init-gauche)
