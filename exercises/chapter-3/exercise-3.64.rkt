#lang sicp
;; Exercise 3.64
;;
;; Write a procedure
;; `stream-limit` that takes as arguments a stream and a number (the
;; tolerance).  It should examine the stream until it finds two successive
;; elements that differ in absolute value by less than the tolerance, and return
;; the second of the two elements.  Using this, we could compute square roots up
;; to a given tolerance by
;;
;; ```scheme
;; (define (sqrt x tolerance)
;;   (stream-limit (sqrt-stream x) tolerance))
;; ```

;; Test: raco test tests/chapter-3/exercise-3.64.test.rkt
;; Your exercises/chapter-3/exercise-3.64.rkt must (#%provide stream-limit)
;;   (stream-limit s tolerance) -> the second element of the first pair of successive
;;   elements of the stream s whose difference is smaller than tolerance (in absolute value)

