#!/usr/bin/env gosh
;
; Conway's Game of Life
;
; Copyright (C) YAMAMIYA Takasi
;
; * reference *
; http://www.cs.utah.edu/plt/mailarch/plt-scheme-2001/msg01385.html
; http://www-2.cs.cmu.edu/afs/cs/project/ai-repository/ai/lang/lisp/code/fun/life.cl

(define clear (lambda () (display "\x1bc")))

(define life-map-random
  (lambda (x y)
    (let make-col ((y y))
      (if (= y 0)
          ()
          (cons (let make-row ((x x))
                  (if (= x 0)
                      ()
                      (cons (even? (sys-random)) (make-row (- x 1)))))
                (make-col (- y 1)))))))

(define life-map-show
  (lambda (board)
    (clear)
    (for-each (lambda (row)
                (for-each (lambda (cell)
                          (display (if cell "O " "  ")))
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
         (life-map-next-when (car top) (cadr top) (caddr top)
                             (car mid) (cadr mid) (caddr mid)
                             (car bot) (cadr bot) (caddr bot))
         (life-map-step-cols (cdr top) (cdr mid) (cdr bot))))))

(define life-map-next-when
  (lambda (c1 c2   c3
           c4 self c5
           c6 c7   c8)
    (let ((ncell
           (apply + (map (lambda (c) (if c 1 0))
                   (list c1 c2 c3 c4 c5 c6 c7 c8)))))
      (if self
          (cond ((= ncell 2) #t)
                ((= ncell 3) #t)
                (else #f))
          (cond ((= ncell 3) #t)
                (else #f))))))

(define life-map-framed
; Add blank cells around the map
  (lambda (board)
    (let ((board-sided
           (map (lambda (row)
                  (cons #f (append row '(#f))))
                board)))
      (let ((blank-row (map
                        (lambda (dummy) #f)
                        (car board-sided))))
        (cons blank-row (append board-sided (list blank-row)))))))

(sys-srandom (sys-time))

(define life-map-run
  (lambda (x y cycle)
    (let run ((board (life-map-random x y)) (count cycle))
      (- count 1)
      (if (zero? count) ()
          (begin
            (life-map-show board)
            (sys-nanosleep 200000000)
            (run (life-map-step board) (- count 1)))))
    (life-map-run x y cycle)))

(life-map-run 40 40 50)

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

