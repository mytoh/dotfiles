#!/usr/bin/env gosh

(use gauche.process)
(use file.util)

(define (main args)
(run-process '(saku.py))
(run-process '(/Applications/i2p/i2prouter start))
(run-process '(gosh makiki-server.scm))
(run-process '(mpd))
(newline))
