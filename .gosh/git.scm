#!/usr/bin/env gosh

(use gauche.process) ; run-process
(use gauche.parseopt)
(use util.match)
(use file.util) ; directory-list, current-directory
(use kirjasto) #; 'make-colour

(define-constant *gitdir*  (expand-path "~/local/git/"))

(define-constant *repos*
  '(; normal repo
    "git://gauche.git.sourceforge.net/gitroot/gauche/Gauche"
    "git://code.call-cc.org/chicken-core"
    "git://gitorious.org/cmus/cmus.git"
    "git://derf.homelinux.org/feh"
    "git://a-chinaman.com/nuscsh"
    "git://git.sv.gnu.org/screen.git"
    "git://git.savannah.gnu.org/stow.git"
    "git://git.savannah.nongnu.org/stumpwm"
    "git://gitorious.org/fish-shell/fish-shell.git"
    "git://gitorious.org/~otherchirps/fish-shell/otherchirps-fish-shell.git"
    "git://gitorious.org/~ridiculousfish/fish-shell/fishfish.git"
    "git://git.infradead.org/get_iplayer.git"
    "git://git.mplayer2.org/mplayer2.git"
    "git://repo.or.cz/ncmpcpp.git"
    "git://git.informatik.uni-erlangen.de/re06huxa/herbstluftwm"
    "git://opensource.conformal.com/xxxterm.git"
    "git://tron.homeunix.org/cvscvt"
    "git://liferea.git.sourceforge.net/gitroot/liferea/liferea"
    "git://sox.git.sourceforge.net/gitroot/sox/sox"
    ; repo with other name
    ("git://git.sourceforge.jp/gitroot/ninix-aya/master.git"  "ninix-aya")
    ; minun github repo
    configs
    dotfiles
    ; github repo
    (VoQn          Gauche-Color)
    (shirok        Gauche-makiki)
    (shirok        Gauche-gtk2)
    (podhmo        gauche-imlib2)
    (naoyat        gauche-naoyat-lib)
    (aharisu       Gauche-SDL)
    (okuoku        mosh)
    (tmbinc        bgrep)
    (ninjaaron     bitocra)
    (koron         chalice)
    (adamv         homebrew-alt)
    (adamv         homebrew)
    (rossy2401     img2xterm)
    (trapd00r      ls--)
    (Arrowmaster   mcomix)
    (marcomaggi    nausicaa)
    (robbyrussell  oh-my-zsh)
    (pkgng         pkgng)
    (coderholic    pyradio)
    (bmizerany     roundup)
    (holman        spark)
    (muennich      sxiv)
    (alice0775     userChrome.js)
    (Griever       userChromeJS)
    (rkitover      vimpager)
    (GGLucas       vimperator-buftabs)
    (vimpr         vimperator-plugins)
    (caisui        vimperator)
    (clvv           fasd)
    (rupa           z)
    (rupa           v)
    (sjl            z-fish)
    (zsh-users     zsh-completions)
    (zsh-users     zsh-syntax-highlighting)
    (trapd00r      zsh-syntax-highlighting-filetypes)
    (hchbaw        auto-fu.zsh)
    (buntine       Fractals)
    (SanskritFritz fish_completions)
    (esodax        fishystuff)
    (zmalltalker        fish-nuggets)
    (Nandaka       DanbooruDownloader)
    (frytvm        XS)
    (joelagnel     stumpwm-goodies)
    (dss-project   dswm)
    (aredridel      es-shell)
    (ThomasAdam     tmux)
    (midgetspy      Sick-Beard)
    (mooz           percol)
    (trizen         gtk-youtube-viewer)
    (trizen         youtube-viewer)
    (xorg62         wmfs)
    (shawncplus     ghub)
    (86me           pentadactyl-scripts)
    (lf94           dwm-lee)
    (Cloudef        monsterwm-xcb)
    (Cloudef        dotFiles   cloudef-dotFiles)
    (Cloudef        milkyhelper)
    (chjj           compton)
    (samirahmed           fu)
    (defunkt        hub)
    (huyz           less.vim)
    (ivmai          bdwgc)
    (ivmai          libatomic_ops)
    (gmarik         vimfiles gmarik-vimfiles)
    (valvallow      lifegame)
    (gitster        git)
    )
  )

;; update git repository
(define (update-gitdir)
  (let ((dirs (list (directory-list (expand-path *gitdir*) :children? #t :add-path? #t))))
    (let loop ((dirs (car dirs)))
      (if (null? dirs)
        (display "update finished!\n")
        (begin
          (display (make-colour 4 "=> "))
          (display (make-colour 3 (sys-basename (car dirs))))
          (newline)
          (if (file-is-directory? (car dirs))
            (run-process '(git pull) :wait #t :directory (car dirs))
            #t)
          (newline)
          (loop (cdr dirs)))))))

;; clone git repository
(define (clone-gitdir)
  (let ((clone (lambda (url dirname) (run-process `(git clone ,url ,dirname) :wait #t))))
    (for-each
      (lambda (l)
        (if (not (file-is-directory? (x->string (car l))))
          (clone (cadr l) (car l))
          #t))
      (repo-url-directory-list))
    #t))


;; clean git repository with "git gc"
(define (clean-gitdir)
  (let ((dirs (list (directory-list (expand-path *gitdir*) :children? #t :add-path? #t))))
    (let loop ((dirs (car dirs)))
      (if (null? dirs)
        (display "cleaning finished!\n")
        (begin
          (if (file-is-directory? (car dirs))
            (begin
              (display (make-colour 4 "=> "))
              (display (make-colour 3 (sys-basename (car dirs))))
              (newline)
              (run-process '(git gc) :wait #t :directory (car dirs))
              (newline))
            #t)
          (loop (cdr dirs)))))))


(define (repo-url-directory-list)
  (map
    (lambda (e)
      (cond
        ; normal repo
        ((string? e) (list (sys-basename (path-sans-extension e)) e))
        ((list? e)
         (if (string? (car e))
           (list (cadr e) (car e))
             ; github
             (if (null? (cddr e))
             (list (cadr e) #`"git://github.com/,(car e)/,(cadr e)")
             ; github with renaming
             (list (caddr e) #`"git://github.com/,(car e)/,(cadr e)")
              )
             ))
        ; my github
        ((symbol? e) (list e #`"git@github.com:mytoh/,|e|"))))
    *repos* ))

(define (usage status)
  (exit status "usage: ~a <command> <package-name>\n" *program-name*))


(define (main args)
    (let-args (cdr args)
      ((#f "h|help" (usage 0))
       . rest)
      (let ((previous-directory (current-directory)))
        (current-directory *gitdir*)
        (match (car rest)
          ;; commands
          ((or "update" "up")
           (begin
             (print (string-append (make-colour 8 "updating ") "repositories"))
             (update-gitdir)))
          ("clean"
           (clean-gitdir))
          ("clone"
           (begin
             (print (string-append (make-colour 3 "cloning ") "repositories"))
             (clone-gitdir)))
          (_ (usage 1)))
        (current-directory previous-directory)
        ))
  0)

    ; (print (string-append (make-colour 3 "cloning ") "repositories"))
    ; (clone-gitdir)
    ; (newline)
    ; (print (string-append (make-colour 8 "updating ") "repositories"))
    ; (update-gitdir)
    ; (clean-gitdir)
