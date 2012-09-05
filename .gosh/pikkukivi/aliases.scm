
(define-module pikkukivi.aliases
  (export
    commands
    alias-list)
  (use gauche.process)
  (use util.list) ; slices
  (use util.match)
  (use file.util)
  (require-extension (srfi 1 13))    ; iota
  (use kirjasto.tiedosto)
  (use kirjasto.väri))
(select-module pikkukivi.aliases)

(define alias-list
  `(
    (mkd     "mkdir -p")
    (gsp     "gosh -ptime")
    (starwars "telnet towel.blinkenlights.nl" )
    (jblive "mplayer rtsp://videocdn-us.geocdn.scaleengine.net/jblive/jblive.stream" )
    (sumo "mplayer -playlist http://sumo.goo.ne.jp/hon_basho/torikumi/eizo_haishin/asx/sumolive.asx" )
    (sumo2 "mplayer mms://a776.l12513450775.c125134.a.lm.akamaistream.net/D/776/125134/v0001/reflector:50775" )
    (sumo3 "mplayer mms://a792.l12513450791.c125134.a.lm.akamaistream.net/D/792/125134/v0001/reflector:50791" )
    ))

(define (commands args)
  (let ((pk-commands
          (concatenate (map (lambda (m)
                              (module-exports (find-module (car m))))
                            (library-fold 'pikkukivi.* acons '()))))
        (alias-commands
          (map car alias-list)))
    (for-each print
      (sort
        (delete-duplicates
          (append pk-commands alias-commands))
        (lambda (x y) (string<?  (symbol->string x)
                                 (symbol->string y)))))))
