
(define-module pikkukivi
  (use gauche.process)
  (use file.util)
  (use util.match)
  (use util.list)
  (export pikkukivi)
  (extend
    pikkukivi.napa
    pikkukivi.talikko
    pikkukivi.pahvi
    pikkukivi.unpack
    pikkukivi.futaba
    pikkukivi.yotsuba
    pikkukivi.repl
    pikkukivi.ls
    pikkukivi.rm
    pikkukivi.emma
    pikkukivi.colour
    pikkukivi.topless
    pikkukivi.ääliö
    pikkukivi.radio
    ))
(select-module pikkukivi)

(define alias-list
  `(("talikko" ,talikko)
    ("rm"      ,rm)
    ("napa"    ,napa)
    ("pahvi"   ,pahvi)
    ("unpack"  ,unpack)
    ("repl"    ,repl)
    ("ls"     ,ls)
    ("yotsuba" ,yotsuba)
    ("futaba"  ,futaba)
    ("emma"    ,emma)
    ("ääliö"   ,ääliö)
    ("colour"  ,colour)
    ("topless" ,topless)
    ("radio"   ,radio)
    ("mkd"     "mkdir -p")
    ("gsp"     "gosh -ptime")
    ("tm"      "gosh tmux-start.scm")
    ("starwars" "telnet towel.blinkenlights.nl" )
    ("jblive" "mplayer rtsp://videocdn-us.geocdn.scaleengine.net/jblive/jblive.stream" )
    ("sumo" "mplayer -playlist http://sumo.goo.ne.jp/hon_basho/torikumi/eizo_haishin/asx/sumolive.asx" )
    ("sumo2" "mplayer mms://a776.l12513450775.c125134.a.lm.akamaistream.net/D/776/125134/v0001/reflector:50775" )
    ("sumo3" "mplayer mms://a792.l12513450791.c125134.a.lm.akamaistream.net/D/792/125134/v0001/reflector:50791" )
    ))

(define (run command args)
  (let* ((c (assoc-ref alias-list command))
         (cmd (if c (car c) #f)))
    (cond
      ((string? cmd)
       (run-process `(,@(string-split cmd " ") ,@args) :wait #t))
      ((procedure? cmd)
       (cmd args))
      (else
        (print "alias not found"))
      )))

(define (pikkukivi args)
  (run (car args) (cdr args)))
