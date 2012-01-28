
;;; keymap {{{
;;;
;;;  modifier keys are defined in 
;;;  keytrans.lisp 
;;;
; applications
(defprogram-shortcut terminal :command "exec urxvtc" :key (kbd "c") :map *root-map*)
(defprogram-shortcut browser :command "exec firefox" :key (kbd "f") :map *root-map*)
(defprogram-shortcut filer   :command "exec thunar" :key (kbd "t") :map *root-map*)
(defprogram-shortcut dmenu :command "exec dmenu_run -i -b -nb '#4d3e41' -nf '#947988' -sb '#947988' -sf '#4d3e41' "
                           :key (kbd "d") :map *root-map*)

(define-key *root-map* (kbd "C-.")   "mymenu")

;; window operation
(define-key *root-map* (kbd "C-f")   "fullscreen")
(define-key *top-map*  (kbd "s-RET") "fullscreen")
(define-key *root-map* (kbd "C-o")   "fnext") ; default key "C-t o"
(define-key *top-map*  (kbd "M-TAB") "next")
(define-key *root-map*  (kbd "C-r")   "restart-hard")
 
;;input window keymap
(define-key *input-map* (kbd "C-i") 'input-complete-forward)
(define-key *input-map* (kbd "C-m") 'input-submit)
(define-key *input-map* (kbd "C-h") 'input-delete-backward-char)

;; group key map
(define-key *groups-map* (kbd "f") "gmove media")
(define-key *top-map*   (kbd "M-1") "gselect main")
(define-key *top-map*   (kbd "M-2") "gselect web") 
(define-key *top-map*   (kbd "M-3") "gselect media") 

;;; }}}

