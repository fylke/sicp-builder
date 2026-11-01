#lang sicp
(#%require rackunit "../lib.rkt")

;; Your exercises/chapter-1/exercise-1.04.rkt must (#%provide a-plus-abs-b)
;;   (a-plus-abs-b a b) -- computes a + |b|, as in the book's
;;   (define (a-plus-abs-b a b) ((if (> b 0) + -) a b))

(test-case "positive b"
  (define a-plus-abs-b (solution "1.04" 'a-plus-abs-b))
  (check-equal? (a-plus-abs-b 3 4) 7)
  (check-equal? (a-plus-abs-b -3 4) 1))

(test-case "negative b"
  (define a-plus-abs-b (solution "1.04" 'a-plus-abs-b))
  (check-equal? (a-plus-abs-b 3 -4) 7)
  (check-equal? (a-plus-abs-b -3 -4) 1))

(test-case "zero b"
  (define a-plus-abs-b (solution "1.04" 'a-plus-abs-b))
  (check-equal? (a-plus-abs-b 5 0) 5))
