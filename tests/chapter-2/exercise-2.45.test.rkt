#lang sicp
(#%require rackunit "../lib.rkt")

;; Your exercises/chapter-2/exercise-2.45.rkt must (#%provide split)
;;   (split first-combine second-combine) -- returns a procedure (painter n) such that
;;       (split beside below)  behaves like right-split
;;       (split below beside)  behaves like up-split
;;   i.e. (go painter 0) is painter, and otherwise
;;       (first-combine painter (second-combine smaller smaller))
;;   where smaller is (go painter (- n 1)).
;; The tests use stand-ins for beside and below that just build lists, so you do not
;; need any painters.

(define (beside a b) (list 'beside a b))
(define (below a b) (list 'below a b))

(test-case "right-split = (split beside below)"
  (define split (solution "2.45" 'split))
  (define right-split (split beside below))
  (check-equal? (right-split 'p 0) 'p)
  (check-equal? (right-split 'p 1) '(beside p (below p p)))
  (check-equal? (right-split 'p 2)
                '(beside p (below (beside p (below p p)) (beside p (below p p))))))

(test-case "up-split = (split below beside)"
  (define split (solution "2.45" 'split))
  (define up-split (split below beside))
  (check-equal? (up-split 'p 0) 'p)
  (check-equal? (up-split 'p 1) '(below p (beside p p)))
  (check-equal? (up-split 'p 2)
                '(below p (beside (below p (beside p p)) (below p (beside p p))))))

(test-case "any pair of combining procedures"
  (define split (solution "2.45" 'split))
  (define go (split (lambda (a b) (list 'X a b)) (lambda (a b) (list 'Y a b))))
  (check-equal? (go 'q 1) '(X q (Y q q)))
  (check-equal? (go 'q 0) 'q))

(test-case "split can be used more than once"
  (define split (solution "2.45" 'split))
  (define right-split (split beside below))
  (define up-split (split below beside))
  (check-equal? (right-split 'a 1) '(beside a (below a a)))
  (check-equal? (up-split 'b 1) '(below b (beside b b)))
  (check-equal? (right-split 'c 1) '(beside c (below c c))))
