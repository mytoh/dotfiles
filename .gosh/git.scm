#!/usr/bin/env gosh

(use gauche.process) ; run-process
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
    (rupa           z)
    (clvv           f)
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
    (xorg62         wmfs)
    (shawncplus     ghub)
    )
  )

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

(define (clone-gitdir)
  (let ((clone (lambda (url dirname) (run-process `(git clone ,url ,dirname) :wait #t))))
    (for-each
      (lambda (l)
        (if (not (file-is-directory? (x->string (car l))))
          (clone (cadr l) (car l))
          #t))
      (repo-url-directory-list))
    #t))

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
        ((string? e) (list (sys-basename (path-sans-extension e)) e))
        ((list? e)  
         (if (string? (car e))
           (list (cadr e) (car e))
           (list (cadr e) #`"git://github.com/,(car e)/,(cadr e)")))
        ((symbol? e) (list e #`"git@github.com:mytoh/,|e|"))))
    *repos* ))

(define (main args)
  (let ((previous-directory (current-directory)))
    (current-directory *gitdir*)
    (print (string-append (make-colour 3 "cloning ") "repositories"))
    (clone-gitdir)
    (newline)
    (print (string-append (make-colour 8 "updating ") "repositories"))
    (update-gitdir)
    (clean-gitdir)
    (current-directory previous-directory))
  )


