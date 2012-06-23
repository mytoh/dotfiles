;http://practical-scheme.net/wiliki/wiliki.cgi?Gauche%3aEditingWithEmacs
; gauche
(setq process-coding-system-alist
      (cons '("gosh" utf-8 . utf-8) process-coding-system-alist))
(setq scheme-program-name "gosh -i")
(autoload 'scheme-mode "cmuscheme" "Major mode for Scheme." t)
(autoload 'run-scheme  "cmuscheme" "Run an inferior Scheme process." t)


; http://valvallow.blogspot.jp/2011/03/emacs-scheme-gauche.html
(defun my-scheme-other-window ()
  "run scheme on other window"
  (interactive)
  (split-window-horizontally 90)
  (let ((buf-name (buffer-name (current-buffer))))
    (switch-to-buffer-other-window
   (get-buffer-create "*scheme*"))
  (run-scheme scheme-program-name)
  (switch-to-buffer-other-window
   (get-buffer-create buf-name))))

(defun my-scheme-mode-hook ()
          (local-set-key  (kbd "C-c S") 'my-scheme-other-window)
          (local-set-key (kbd "C-m") 'newline-and-indent))
(add-hook 'scheme-mode-hook 'my-scheme-mode-hook)


;; function from emacswiki.org/emacs/AddKeywords
(defun my-scheme-add-keywords (face-name keyword-rules)
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

  (my-scheme-add-keywords
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
    (2 . multiple-value-bind )
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
   (1 . exit)
   ))

(my-scheme-add-keywords
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
   (1 . length)
   (1 . null?)
   (1 . list)
   (1 . cons)
   (1 . fold )
   (1 . car)
   (1 . cdr)
   (1 . cadr)
   (1 . caddr)
   (1 . not)
   (1 . zero?)
   (1 . erroro)
   (1 . newline)
   (1 . display)
   (1 . print)
   (1 . load)
   (1 . >=)
   (1 . x->number)
   (1 . read-line)
   (1 . rx-match->string)
   (1 . port-for-each)
   (1 . cut)
   (1 . read-line)
   (1 . values-ref)
   (1 . ces-convert)
   (1 . file-exists?)
   (1 . file-is-directory? )
   (1 . sys-symlink)
   (1 . sys-dirname)
 
   (1 . sys-setenv)
   (1 . sys-unsetenv)
   (1 . sys-getenv)
 
   (1 . rxmatch->string)
   (1 . string->regexp)
   (1 . string-scan)
   (1 . string-split)
 
   ;; sxml
   (1 . ssax:xml->sxml)
 
   ;; makiki
   (1 . define-http-handler)
   (1 . start-http-server)

   ;; file.util
   (1 . current-directory)
   (1 . directory-list)
   (1 . directory-list2)
   (1 . directory-fold)
   (1 .  home-directory)
   (1 .  temporary-directory)
   (1 .  make-directory*)
   (1 .  create-directory*)
   (1 .  remove-directory*)
   (1 .  delete-directory*)
   (1 .  copy-directory*)
   (1 .  create-directory-tree)
   (1 .  check-directory-tree)
   (1 .  build-path)
   (1 .  resolve-path)
   (1 .  expand-path)
   (1 .  simplify-path)
   (1 .  decompose-path)
   (1 .  absolute-path?)
   (1 .  relative-path?)
   (1 .  find-file-in-paths)
   (1 .  path-separator)
   (1 .  path-extension)
   (1 .  path-sans-extension)
   (1 .  path-swap-extension)
   (1 .  file-is-readable?)
   (1 .  file-is-writable?)
   (1 .  file-is-executable?)
   (1 .  file-is-symlink?)
   (1 .  file-type)
   (1 .  file-perm)
   (1 .  file-mode)
   (1 .  file-ino)
   (1 .  file-dev)
   (1 .  file-rdev)
   (1 .  file-nlink)
   (1 .  file-uid)
   (1 .  file-gid)
   (1 .  file-size)
   (1 .  file-mtime)
   (1 .  file-atime)
   (1 .  file-ctime)
   (1 .  file-eq?)
   (1 .  file-eqv?)
   (1 .  file-equal?)
   (1 .  file-device=?)
   (1 .  file-mtime=?)
   (1 .  file-mtime<?)
   (1 .  file-mtime<=?)
   (1 .  file-mtime>?)
   (1 .  file-mtime>=?)
   (1 .  file-atime=?)
   (1 .  file-atime<?)
   (1 .  file-atime<=?)
   (1 .  file-atime>?)
   (1 .  file-atime>=?)
   (1 .  file-ctime=?)
   (1 .  file-ctime<?)
   (1 .  file-ctime<=?)
   (1 .  file-ctime>?)
   (1 .  file-ctime>=?)
   (1 .  touch-file)
   (1 .  touch-files)
   (1 .  copy-file)
   (1 .  move-file)
   (1 .  remove-files)
   (1 .  delete-files)
   (1 .  null-device)
   (1 .  console-device)
   (1 .  file->string)
   (1 .  file->string-list)
   (1 .  file->list)
   (1 .  file->sexp-list)
   (1 .  <lock-file-failure>)
   (1 .  with-lock-file)

   ;; gauche.process
   (1 . run-process)
 
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
 
   ;; srfi-1
   (1 . remove)
   (1 . delete-duplicates)
   (1 . zip)
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
                                 (one-or-more (or numeric
                                                  (in " \t\n" )))
                                 ;(one-or-more
                                 ;(one-or-more (in " \n\t"))
                                 ;(submatch (one-or-more numeric)))
                                                                  ))
                           (2 'font-lock-variable-name-face)
                           (3 'font-lock-type-face))
                          ;; (export some-function)
                          (,(rx (and
                                 (syntax open-parenthesis) "export" (zero-or-more (in " \t\n"))
                                 (submatch
                                  (one-or-more  (or (syntax word)
                                                    (syntax symbol)
                                                    (in " \t\n"))))
                                 ))
                           1  'font-lock-variable-name-face)
                          ;; (export some-function)
  ;                        (,(rx (and
  ;                               (syntax open-parenthesis) "export" (zero-or-more (in " \t\n"))
  ;                               (one-or-more (or (syntax word)
  ;                                                (syntax symbol)
  ;                                                (in " \t\n")))
  ;                               (syntax close-parenthesis)))
  ;                         (,(rx (or (syntax word)
  ;                                   (syntax symbol)))
  ;                          (match-end 2)
  ;                          (goto-char (match-end 0))
  ;                          (0 font-lock-type-face t)))
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
                          ;; #`
                          (,(rx "#`")
                           0 'font-lock-warning-face)
                          ;; #t #f
                          (,(rx (or  "#t" "#f"))
                           0 'font-lock-warning-face)
                          ))


;; scheme mode recognition
(add-to-list 'auto-mode-alist '("\\.leh\\'" .  scheme-mode))

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





