
(define-module pikkukivi.scm.ääliö
  (extend gauche.interactive)
  (export
    ääliö)
  (use gauche.process) ; run-process
  (use gauche.parseopt)
  (use util.match)
  (use file.util) ; directory-list, current-directory
  (use kirjasto.väri)
  (use clojure))

(select-module pikkukivi.scm.ääliö)


(define-constant *gitdir*  (expand-path "~/local/git/"))

(define-constant *repos*
  '(; normal repo
    "git://code.call-cc.org/chicken-core"
    "git://gitorious.org/cmus/cmus.git"
    "git://a-chinaman.com/nuscsh"
    "git://git.sv.gnu.org/screen.git"
    "git://git.savannah.gnu.org/stow.git"
    "git://gitorious.org/fish-shell/fish-shell.git"
    "git://gitorious.org/~otherchirps/fish-shell/otherchirps-fish-shell.git"
    "git://git.infradead.org/get_iplayer.git"
    "git://git.mplayer2.org/mplayer2.git"
    "git://git.informatik.uni-erlangen.de/re06huxa/herbstluftwm"
    "git://opensource.conformal.com/xxxterm.git"
    "git://tron.homeunix.org/cvscvt"
    "git://pcmanfm.git.sourceforge.net/gitroot/pcmanfm/libfm"
    "git://pcmanfm.git.sourceforge.net/gitroot/pcmanfm/pcmanfm"
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
    (trapd00r      ls--)
    (trapd00r      utils trapd00r-utils)
    (trapd00r      configs trapd00r-configs)
    (hchbaw        auto-fu.zsh)
    (buntine       Fractals)
    (SanskritFritz fish_completions)
    (esodax        fishystuff)
    (zmalltalker        fish-nuggets)
    (Nandaka       DanbooruDownloader)
    (frytvm        XS)
    (joelagnel     stumpwm-goodies)
    (sabetts       stumpwm)
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
    (Cloudef        dotfiles-ng   cloudef-dotFiles-ng)
    (Cloudef        milkyhelper)
    (chjj           compton)
    (samirahmed           fu)
    (defunkt        hub)
    (huyz           less.vim)
    (ivmai          bdwgc)
    (ivmai          libatomic_ops)
    (gmarik         vimfiles gmarik-vimfiles)
    (valvallow      lifegame)
    (saironiq       shellscripts)
    (mason-larobina luakit)
    (jwiegley        eshell)
    (robm           dzen)
    (jhawthorn     meh)
    (kahua         Kahua)
    (mozilla       mozilla-central)
    (shadow        shadow)
    (digego         extempore)
    (calvis         cKanren)
    (tlatsas       xcolors)
    (Raynes       fs)
    (webyrd        miniKanren)))

;; update git repository
(define (update-gitdir)
  (let ((dirs (list (directory-list (expand-path *gitdir*) :children? #t :add-path? #t))))
    (let loop ((dirs (car dirs)))
      (cond
        ((null? dirs)
         (display "update finished!\n"))
        (else
          (display (colour-string 4 "=> "))
          (display (colour-string 3 (sys-basename (car dirs))))
          (newline)
          (if (file-is-directory? (car dirs))
            (run-process '(git pull) :wait #t :directory (car dirs))
            #t)
          (newline)
          (loop (cdr dirs)))))))


;; clean git repository with "git gc"
(define (clean-gitdir)
  (let ((dirs (list (directory-list (expand-path *gitdir*) :children? #t :add-path? #t))))
    (let loop ((dirs (car dirs)))
      (cond
        ((null? dirs)
         (display "cleaning finished!\n"))
        (else
          (cond
            ((file-is-directory? (car dirs))
             (display (colour-string 4 "=> "))
             (display (colour-string 3 (sys-basename (car dirs))))
             (newline)
             (run-process '(git gc) :wait #t :directory (car dirs))
             (newline))
            (else  #t))
          (loop (cdr dirs)))))))


;; clone git repository
(define (clone-gitdir)
  (let ((clone (lambda (url dirname) (run-process `(git clone ,url ,dirname) :wait #t))))
    (for-each
      (lambda (l)
        (if-not (file-is-directory? (x->string (car l)))
          (clone (cadr l) (car l))
          #t))
      (repo-url-directory-list))
    #t))

(define (repo-url-directory-list)
  (map
    (lambda (e)
      (cond
        ((string? e)
         ; normal repo
         (list (sys-basename (path-sans-extension e)) e))
        ((list? e)
         (cond
           ((string? (car e))
            ; normal repo
            (list (cadr e) (car e)))
           ((= (length e) 2)
            ; github
            (list (cadr e) #`"git://github.com/,(car e)/,(cadr e)"))
           ; github with renaming
           (else
             (list (caddr e) #`"git://github.com/,(car e)/,(cadr e)"))))
        ((symbol? e)
         ; my github
         (list e #`"git@github.com:mytoh/,|e|"))
        (else
          (list e))))
    *repos* ))

(define (list-repos)
  (map
    (^ (x) (cond
             ((list? x)
              (print
                (string-append (colour-string 33 (x->string (car x)))
                               ": "
                               (colour-string 93 (x->string (cadr x))))))
             (else
               (print x))))
    *repos*))

(define (usage status)
  (exit status "usage: ~a <command> <package-name>\n" *program-name*))


(define (ääliö args)
  (let-args args
    ((#f "h|help" (usage 0))
     . rest)
    (with-cwd *gitdir*
              (match (car rest)
                ;; commands
                ((or "update" "up")
                 (begin
                   (print (string-append (colour-string 8 "updating ") "repositories"))
                   (update-gitdir)))
                ("clean"
                 (clean-gitdir))
                ("list"
                 (list-repos))
                ("clone"
                 (begin
                   (print (string-append (colour-string 3 "cloning ") "repositories"))
                   (clone-gitdir)))
                (_ (usage 1)))))
  0)

