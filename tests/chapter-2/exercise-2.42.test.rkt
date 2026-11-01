#lang sicp
(#%require rackunit "../lib.rkt")

;; Your exercises/chapter-2/exercise-2.42.rkt must (#%provide queens empty-board adjoin-position safe?)
;;   (queens board-size)               -- the list of all solutions of the n-queens puzzle
;;   empty-board                       -- the representation of a board with no queens
;;   (adjoin-position row col positions) -- positions with a queen at (row, col) added
;;   (safe? k positions)               -- is the queen in column k (the most recently adjoined
;;                                        one) safe from all the others?
;; You define all of these yourself, plus the supporting procedures (flatmap, filter,
;; enumerate-interval, ...). Positions are your own representation.

(define (queens-at positions-spec)
  ;; positions-spec: list of (row col), the newest queen (column k) first
  (define adjoin-position (solution "2.42" 'adjoin-position))
  (define empty-board (solution "2.42" 'empty-board))
  (define (build spec)
    (if (null? spec)
        empty-board
        (adjoin-position (car (car spec)) (cadr (car spec)) (build (cdr spec)))))
  (build positions-spec))

(test-case "number of solutions of the n-queens puzzle"
  (define queens (solution "2.42" 'queens))
  (check-equal? (length (queens 1)) 1)
  (check-equal? (length (queens 2)) 0)
  (check-equal? (length (queens 3)) 0)
  (check-equal? (length (queens 4)) 2)
  (check-equal? (length (queens 5)) 10)
  (check-equal? (length (queens 6)) 4))

(test-case "eight queens has 92 solutions"
  (define queens (solution "2.42" 'queens))
  (check-equal? (length (queens 8)) 92))

(test-case "solutions are all different"
  (define queens (solution "2.42" 'queens))
  (define (distinct? l)
    (or (null? l) (and (not (member (car l) (cdr l))) (distinct? (cdr l)))))
  (check-true (distinct? (queens 6)))
  (check-true (distinct? (queens 5))))

(test-case "safe? accepts non-attacking queens"
  (define safe? (solution "2.42" 'safe?))
  (check-true (safe? 1 (queens-at '((1 1)))))
  (check-true (safe? 2 (queens-at '((3 2) (1 1)))))
  (check-true (safe? 3 (queens-at '((5 3) (3 2) (1 1)))))
  (check-true (safe? 2 (queens-at '((2 2) (4 1)))))
  (check-true (safe? 4 (queens-at '((2 4) (4 3) (1 2) (3 1))))))

(test-case "safe? rejects a queen in the same row"
  (define safe? (solution "2.42" 'safe?))
  (check-false (safe? 2 (queens-at '((1 2) (1 1)))))
  (check-false (safe? 3 (queens-at '((1 3) (3 2) (1 1))))))

(test-case "safe? rejects a queen on a diagonal"
  (define safe? (solution "2.42" 'safe?))
  (check-false (safe? 2 (queens-at '((2 2) (1 1)))))
  (check-false (safe? 2 (queens-at '((2 2) (3 1)))))
  (check-false (safe? 3 (queens-at '((2 3) (3 2) (1 1)))))
  (check-false (safe? 3 (queens-at '((4 3) (3 2) (1 1)))))
  (check-false (safe? 3 (queens-at '((5 3) (4 2) (1 1)))))
  (check-false (safe? 3 (queens-at '((1 3) (5 2) (3 1))))))
