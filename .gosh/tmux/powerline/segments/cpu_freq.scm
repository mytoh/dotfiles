
(define-module tmux.powerline.segments.cpu_freq
  (export
    segment.cpu_freq)
  (use gauche.process))
(select-module tmux.powerline.segments.cpu_freq)


(define (segment.cpu_freq)
  (string-append
    "freq: "
    (process-output->string '(sysctl -n dev.cpu.0.freq)))  
  )


