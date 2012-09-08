
(define-module tmux.schemeline.segments.cpu-freq
  (export
    segment.cpu-freq)
  (use gauche.process))
(select-module tmux.schemeline.segments.cpu-freq)


(define (segment.cpu-freq)
  (string-append
    (number->string
      (/. (string->number
            (process-output->string
                            '(sysctl -n dev.cpu.0.freq)))
          1000))
    "GHz"))


