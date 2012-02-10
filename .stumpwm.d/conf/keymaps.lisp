
;;; keymap {{{
;;;
;;;  modifier keys are defined in 
;;;  keytrans.lisp 
;;;
; applications
(defprogram-shortcut terminal :command "exec urxvtc" :key (kbd "c") :map *root-map*)
(defprogram-shortcut browser :command "exec firefox" :key (kbd "f") :map *root-map*)
(defprogram-shortcut filer   :command "exec pcmanfm" :key (kbd "t") :map *root-map*)
(defprogram-shortcut dmenu :command "exec dmenu_run -i -b -nb 'grey' -nf 'magenta' -sb 'grey10' -sf '#4d3e41' "
                           :key (kbd "d") :map *root-map*)

;; github.com/Juev/stumpwm-config
(defmacro defkey-top (key cmd)
  `(define-key *top-map* (kbd ,key) ,cmd))
(defmacro defkeys-top (&rest keys)
  (let ((ks (mapcar #'(lambda (k) (cons 'defkey-top k)) keys)))
    `(progn ,@ks)))

(defmacro defkey-root (key cmd)
  `(define-key *root-map* (kbd ,key) ,cmd))
(defmacro defkeys-root (&rest keys)
  (let ((ks (mapcar #'(lambda (k) (cons 'defkey-root k)) keys)))
    `(progn ,@ks)))

(defmacro defkey-input (key cmd)
  `(define-key *input-map* (kbd ,key) ,cmd))
(defmacro defkeys-input (&rest keys)
  (let ((ks (mapcar #'(lambda (k) (cons 'defkey-input k)) keys)))
    `(progn ,@ks)))

(defkeys-root 
  ("C-."  "mymenu")
  ;; window operation
  ("C-f"   "fullscreen")
  ("C-o"   "fnext") ; default key "C-t o"
  ("C-r"   "restart-hard")
  ("C-s"   "swap-windows")
  ("~"     "rotate-windows")
  ("|"     "toggle-split")
  )

(defkeys-top
  ;; window operation
  ("s-RET" "fullscreen")
  ("M-TAB" "next")
  ;; group key map
  ("M-1" "gselect main")
  ("M-2" "gselect web") 
  ("M-3" "gselect media"))
 
;;input window keymap
(defkeys-input
  ("C-i" 'input-complete-forward)
  ("C-m" 'input-submit)
  ("C-h" 'input-delete-backward-char))

;; group key map
(define-key *groups-map* (kbd "f") "gmove media")

;;; }}}

