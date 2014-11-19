#!/usr/local/bin/gosh

;; original scheme script for dzen
;; see http://dzen.geekmode.org/dwiki/doku.php?id=dzen:scheme-monitor
;; this modified versin for stumpwm's mode-line

(use gauche.process)
(use file.util)
(use srfi-1)
(use srfi-13)
(load "sysctl.scm")

;; Cpu settings
(define CPU-CORES (list 0 1))

;; Main loop interval in seconds
(define SLEEP-INTERVAL 1)

;; Utils
(define (for-each-line-from-port proc port)
  (call-with-current-continuation
      (lambda (break)
        (let loop ((line (read-line port)))
             (cond
               ((eof-object? line))
               ((proc line break) (loop (read-line port)))
               (else (loop (read-line port))))))))

(define (call-for-each-line-in-file filename proc)
  (call-with-input-file filename
    (lambda (port)
      (for-each-line-from-port proc port))))

(define (call-for-each-line-in-pipe command proc)
  (call-with-input-process command
                           (lambda (port)
                             (for-each-line-from-port proc port))))

(define (read-last-available-line)
  (if (char-ready?)
    (let ((line (read-line)))
      (or (read-last-available-line) line))
    #f))

;; Cpu Load
(define *CPU-STATS* (make-vector (length CPU-CORES) (list 0 0 0 0)))
(define *CPU-LOADS* (make-vector (length CPU-CORES) 0.0))
;; Memory
(define *MEM-USED* 0)
;; Net
(define *NET-RECEIVE* 0)
(define *NET-TRANSMIT* 0)

;; status
(define (update-cpu-loads)
  (call-for-each-line-in-file "/compat/linux/proc/stat"
                              (lambda (line break)
                                (if (string= line "cpu" 0 3)
                                  (let* ((tokens (string-tokenize line))
                                         (core (string->number (substring/shared (car tokens) 3))))
                                    (if (and core (memv core CPU-CORES))
                                      (let* ((oldstat (vector-ref *CPU-STATS* core))
                                             (newstat (map string->number (take (cdr tokens) 4)))
                                             (diffs (map - newstat oldstat))
                                             (total (/ (fold + 0 diffs) 100.0))
                                             (idle-diff (list-ref diffs 3))
                                             (cpu-load (/ (fold + (- idle-diff) diffs) total)))
                                        (vector-set! *CPU-STATS* core newstat)
                                        (vector-set! *CPU-LOADS* core cpu-load))))))))

(define (update-mem-loads)
  (let* ((file (file->string "/compat/linux/proc/meminfo"))
         (tokens (drop (string-tokenize file) 7))
         (total (string->number(car tokens)))
         (used (string->number(cadr tokens))))
    (set! *MEM-USED* (round->exact (*(/. used total) 100)))))

(define (update-net-loads)
  (call-for-each-line-in-file "/compat/linux/proc/net/dev"
                              (lambda (line break)
                                (if (string= line "eth0" 2 6)
                                  (let* ((tokens (string-tokenize line))
                                         (rx (string->number (cadr tokens)))
                                         (tx (string->number (car (drop tokens 9))))
                                         )
                                    (set! *NET-RECEIVE*  (/. rx (* 1024 1024)))
                                        ;(print *NET-RECEIVE*)
                                    )))))


;; Display status line
(define (display-status-line)
  (let ((information-line (format
                              #f
                            "^9*Cpu:~3@a% ^8*|^n ^6*Mem:~3@a%"
                            (inexact->exact (round (vector-ref *CPU-LOADS* 0)))
                            (percentage (mem-used) (mem-total))
                            )))
    (display information-line)))

(define (main args)
  (update-cpu-loads)
  (sys-sleep SLEEP-INTERVAL)
  (update-cpu-loads)
  (update-mem-loads)
  (update-net-loads)
  (display-status-line)
  )
