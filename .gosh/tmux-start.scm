#!/usr/bin/env gosh

(use gauche.process)
(use gauche.parseopt)
(use util.match)
(require-extension (srfi 98))

(define (new-session session . options)
  (run-process `(tmux new-session -d -s ,session ,@options) :wait #t))

(define (new-window session window-name . command)
  (run-process `(tmux new-window -d -t ,session -n ,window-name ,@command) :wait #t))

(define (attach-session session)
  (run-process `(tmux -u2 attach-session -t ,session) :wait #t))

(define (tmux)
  (if (get-environment-variable "TMUX")
    ; inside tmux
    (print "[38;5;1myou're inside of tmux[0m")
    (let ((main-session   "main")
          (second-session "daemon")
          )
      (let* ((p (run-process `(tmux -q has-session -t ,main-session) :wait #t :output :null :error :null))
             (status (process-exit-status p)))
        (if (zero? status)
          ; session exists
          (attach-session main-session)
          ; session not exists
          (begin
            ;; create main session
            (new-session main-session)
            (new-window main-session "vim" "vim")
            (new-window main-session "w3m" "w3m google.com")
            ;; create second session
            (new-session second-session)
            (new-window  second-session "futaba" "fish")
            (new-window  second-session "rtorrent" "rtorrent")

            ; attach main session
            (attach-session main-session)

            ))))))

(define (main args)
  (tmux))
