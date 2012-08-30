
(define-module pikkukivi
  (use gauche.process)
  (use file.util)
  (use util.match)
  (use util.list)
  (use kirjasto.pääte)
  (use kirjasto.työkalu)
  (export pikkukivi)
  (extend
    pikkukivi.talikko
    pikkukivi.unpack
    pikkukivi.repl
    pikkukivi.ls
    pikkukivi.rm
    pikkukivi.emma
    pikkukivi.colour
    pikkukivi.topless
    pikkukivi.ascii-taide
    pikkukivi.verkko
    pikkukivi.scm
    pikkukivi.launch-app
    pikkukivi.print-path
    ))
(select-module pikkukivi)

(define alias-list
  `(
    (mkd     "mkdir -p")
    (gsp     "gosh -ptime")
    (tm      "gosh tmux-start.scm")
    (starwars "telnet towel.blinkenlights.nl" )
    (jblive "mplayer rtsp://videocdn-us.geocdn.scaleengine.net/jblive/jblive.stream" )
    (sumo "mplayer -playlist http://sumo.goo.ne.jp/hon_basho/torikumi/eizo_haishin/asx/sumolive.asx" )
    (sumo2 "mplayer mms://a776.l12513450775.c125134.a.lm.akamaistream.net/D/776/125134/v0001/reflector:50775" )
    (sumo3 "mplayer mms://a792.l12513450791.c125134.a.lm.akamaistream.net/D/792/125134/v0001/reflector:50791" )

    ; taken from oh-my-zsh
    ; Source: http://aur.archlinux.org/packages/lolbash/lolbash/lolbash.sh
    (wtf "dmesg" )
    (onoz "cat /var/log/errors.log" )
    (rtfm "man" )
    (visible "echo" )
    (invisible "cat" )
    (moar "more" )
    (tldr "less" )
    (alwayz "tail -f" )
    (icanhas "mkdir" )
    (gimmeh "touch" )
    (donotwant "rm" )
    (dowant "cp" )
    (gtfo "mv" )
    (nowai "chmod" )
    (hai "cd" )
    (iz "ls" )
    (plz "pwd" )
    (ihasbucket "df -h" )
    (inur "locate" )
    (iminurbase "finger" )
    (btw "nice" )
    (obtw "nohup" )
    (nomz "ps -aux" )
    (nomnom "killall" )
    (byes "exit" )
    (cya "reboot" )
    (kthxbai "halt" )
    ))

(define (run-alias command args)
  (let* ((c (assoc-ref alias-list (string->symbol command)))
         (cmd (if c (car c) #f)))
    (cond
      ((string? cmd)
       (screen-title command)
       (run-process `(,@(string-split cmd " ") ,@args) :wait #t))
      ((procedure? cmd)
       (screen-title command)
       (cmd args))
      (else
        ((eval-string command) args)  
        ; (print "alias not found")
        )
      )))

(define (pikkukivi args)
  (run-alias (car args) (cdr args)))
