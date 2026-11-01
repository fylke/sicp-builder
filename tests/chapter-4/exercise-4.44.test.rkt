#lang sicp
;; Your exercises/chapter-4/exercise-4.44.rkt must (#%provide eight-queens-solutions).
;; eight-queens-solutions: (eight-queens-solutions) returns all solutions as lists of column numbers, one per row.
;; No additional definitions are required.
(#%require rackunit "../lib.rkt")

(test-case "search returns all 92 valid eight-queens boards"
  (define f (solution "4.44" 'eight-queens-solutions))
  (define boards (f))
  (define (safe-from? column remaining distance)
    (or (null? remaining)
        (and (not (= column (car remaining)))
             (not (= (abs (- column (car remaining))) distance))
             (safe-from? column (cdr remaining) (+ distance 1)))))
  (define (valid-board? board)
    (and (= (length board) 8)
         (let check ((columns board))
           (or (null? columns)
               (and (safe-from? (car columns) (cdr columns) 1)
                    (check (cdr columns)))))))
  (define (all-valid? remaining)
    (or (null? remaining)
        (and (valid-board? (car remaining))
             (all-valid? (cdr remaining)))))
  (check-equal? (length boards) 92)
  (check-true (all-valid? boards)))
