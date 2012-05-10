#!/usr/bin/env gosh

(use gauche.process)
(use gauche.parseopt)
(use util.match)
(require-extension (srfi 98))

(define (new-session session window-name . options)
   (if (not (has-sessin? session))  
  (run-process `(tmux new-session -d -s ,session -n ,window-name ,@options) :wait #t)))

(define (new-window session window-number window-name . command)
  (run-process `(tmux new-window
                      -d
                      -t ,(string-append  session ":" (number->string window-number))
                      -n ,window-name ,@command) :wait #t))

(define (attach-session session)
  (run-process `(tmux -u2 attach-session -t ,session) :wait #t))

(define  (has-sessin? session)
  (let* ((p (run-process `(tmux -q has-session -t ,session) :wait #t :output :null :error :null))
         (status (process-exit-status p)))
    (if (zero? status)
      #t
      #f)))

(define (tmux)
  (if (get-environment-variable "TMUX")
    ; inside tmux
    (print "[38;5;1myou're inside of tmux[0m")
    (let ((main-session   "main")
          (second-session "daemon")
          )
      (if (has-sessin? main-session)
          ; session exists
          (attach-session main-session)
          ; session not exists
          (begin

            ;; create main session
            (new-session main-session "main")
            (new-window main-session 1 "vim" "vim")
            (new-window main-session 2 "w3m" "w3m google.com")

            ;; create second session
            (new-session second-session "futaba")
            (new-window  second-session 1 "4ch" "fish")
            (new-window  second-session 2 "danbooru" "fish")
            ; (new-window  second-session "rtorrent" "rtorrent")

            ; attach main session
            (attach-session main-session))))))

(define (main args)
  (tmux))