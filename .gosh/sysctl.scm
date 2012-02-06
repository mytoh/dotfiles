#!/usr/bin/env gosh

;; http://www.cyberciti.biz/files/scripts/freebsd-memory.pl.txt
;; 

(use gauche.process)

(define (sysctl name) 
  (string->number 
    (process-output->string `(sysctl -n ,name))))

(define (readable number)
  (round->exact (/. number (* 1024 1024)))
  )

(define (percentage dividend divisor)
 (round->exact 
   (* (/. dividend divisor)
    100)))

(define (mem-free)
   (* (sysctl "vm.stats.vm.v_free_count")
     (sysctl "hw.pagesize")))

(define (mem-inactive)
  (* (sysctl "vm.stats.vm.v_inactive_count")
     (sysctl "hw.pagesize")))

(define (mem-cache)
  (* (sysctl "vm.stats.vm.v_cache_count")
     (sysctl "hw.pagesize")))

(define (mem-all)
  (* (sysctl "vm.stats.vm.v_page_count")
     (sysctl "hw.pagesize")))

(define (mem-total)
  (sysctl "hw.physmem"))

(define (mem-used)
  (- (mem-total) (mem-avail))
  )

(define (mem-avail)
   (+ (mem-inactive) (mem-cache) (mem-free)))
