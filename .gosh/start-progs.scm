#!/usr/bin/env gosh

(use gauche.process)
(use file.util)

(define (main args)
(run-process '(saku.py))
(run-process '(/Applications/i2p/i2prouter start))
(run-process `(lighttpd -f ,(expand-path "~/.lighty/etc/lighttpd.conf")))
(run-process '(mpd))
(newline))
