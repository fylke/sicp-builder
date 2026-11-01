#lang sicp
;; Exercise 1.4
;;
;; Observe that our model of
;; evaluation allows for combinations whose operators are compound expressions.
;; Use this observation to describe the behavior of the following procedure:
;;
;; ```scheme
;; (define (a-plus-abs-b a b)
;;   ((if (> b 0) + -) a b))
;; ```

;; Test: raco test tests/chapter-1/exercise-1.04.test.rkt
;; Your exercises/chapter-1/exercise-1.04.rkt must (#%provide a-plus-abs-b)
;;   (a-plus-abs-b a b) -- computes a + |b|, as in the book's
;;   (define (a-plus-abs-b a b) ((if (> b 0) + -) a b))

