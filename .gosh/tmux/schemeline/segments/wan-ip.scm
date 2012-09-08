

(define-module tmux.schemeline.segments.wan-ip
  (export
    segment.wan-ip)
  (use kirjasto.verkko.avata)
  (use gauche.process))
(select-module tmux.schemeline.segments.wan-ip)


(define (segment.wan-ip)
  (open "http://whatismyip.akamai.com"))


