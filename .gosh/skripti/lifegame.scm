#!/usr/bin/env gosh
;
; Conway's Game of Life
;
; Copyright (C) YAMAMIYA Takasi
;
; * reference *
; http://www.cs.utah.edu/plt/mailarch/plt-scheme-2001/msg01385.html
; http://www-2.cs.cmu.edu/afs/cs/project/ai-repository/ai/lang/lisp/code/fun/life.cl

(use gauche.process)
(require-extension
  (srfi 1))

(define clear (lambda () (display "\x1bc")))

(define life-map-random
  ; yields random list
  (lambda (x y)
    (let make-col ((y y))
      (if (= y 0)
          ()
          (cons (let make-row ((x x))
                  (if (= x 0)
                      ()
                      (cons (if (even? (sys-random))
                              (if (even? (sys-random))
                                     1
                                     2)
                              0)
                            (make-row (- x 1)))))
                (make-col (- y 1)))))))

(define life-map-show
  ; display list with columns
  (lambda (board)
    (clear)
    (for-each
      (lambda (row)
        (for-each
          (lambda (cell)
            (display (cond ((= cell 1) "[38;5;183m██[0m")
                       ((= cell 2) "[38;5;19m██[0m")
                       (else "  "))))
          row)
        (newline))
      board)))

(define life-map-step
  (lambda (board)
    (let next-rows ((board-framed (life-map-framed board)))
      (if (null? (cddr board-framed))
          ()
          (cons
           (life-map-step-cols (car board-framed)
                               (cadr board-framed)
                               (caddr board-framed))

           (next-rows (cdr board-framed)))))))

(define life-map-step-cols
  (lambda (top mid bot)
    (if (null? (cddr top))
        ()
        (cons
         (life-map-next-when (first top) (second top) (third top)
                             (first mid) (second mid) (third mid)
                             (first bot) (second bot) (third bot))
         (life-map-step-cols (cdr top) (cdr mid) (cdr bot))))))

(define life-map-next-when
  (lambda (c1  c2  c3
           c4 self c5
           c6  c7  c8)
    (let ((n1 (count (^x (if (= x 1) #t #f))
                        (list c1 c2 c3 c4 c5 c6 c7 c8)))
          (n2 (count (^x (if (= x 2) #t #f))
                        (list c1 c2 c3 c4 c5 c6 c7 c8)))
          )
      (cond ((= self 1)
          (cond ((= n1 2) 1)
                ((= n1 3) 1)
                (else 0)))
        ((= self 0)
          (cond ((= n1 3) 1)
                ((= n1 6) 1)
                (else 0)))
        ((= self 2)
          (cond ((= n1 3) 2)
                ((= n1 6) 2)
                ((= n2 3) 1)
                (else 0)))
        ))))

(define life-map-framed
; Add blank cells around the map
  (lambda (board)
    (let ((board-sided
           (map (lambda (row)
                  (cons 0 (append row '(0))))
                board)))
      (let ((blank-row (map
                        (lambda (dummy) 0)
                        (car board-sided))))
        (cons blank-row (append board-sided (list blank-row)))))))


(sys-srandom (sys-time))

(define life-map-run
  (lambda (x y cycle)
    (let run ((board (life-map-random x y)) (cycle-count cycle))
      (- cycle-count 1)
      (if (zero? cycle-count) ()
          (begin
            (life-map-show board)
            ; (sys-nanosleep 200000000)
            (sys-nanosleep 200000000)
            (run (life-map-step board) (- cycle-count 1)))))
    (life-map-run x y cycle)))

(define life-run
  (lambda (x y cycle)
  (dynamic-wind
    (^ _ (run-process '(tput "civis"))
      (run-process '(tput "clear")))
    (^ _ (life-map-run x y cycle))
    (^ _ (run-process '(tput "cnorm")))
    )
  )
  )

;             x  y  cycle
(life-run 40 40 330)

; (life-map-show (life-map-random 30 30))
;; metatoys.org/propella/lifeGame
;作業手順メモ
;
;  - 他の人が書いたライフゲームを探す
;  - まず乱数の発生方法を調べる
;  - LifeMap のデータ構造を考える。配列/リスト/ドットペア
;  - 乱数を基にした LifeMap を作成し、とりあえず表示する。
;  - 上下左右の端っこの処理を考える(最初に余分なセルを追加するか、検索時に除外するか。
;  - あるセルの次の代を求める
;  - LifeMap 全体の次の代
;  - タイマの使い方を調べる
;  - 余裕があったら GUI 作成

