#lang sicp
;; Exercise 2.47
;;
;; Here are two possible
;; constructors for frames:
;;
;; ```scheme
;; (define (make-frame origin edge1 edge2)
;;   (list origin edge1 edge2))
;;
;; (define (make-frame origin edge1 edge2)
;;   (cons origin (cons edge1 edge2)))
;; ```
;;
;; For each constructor supply the appropriate selectors to produce an
;; implementation for frames.

;; Test: raco test tests/chapter-2/exercise-2.47.test.rkt
;; Your exercises/chapter-2/exercise-2.47.rkt must (#%provide make-frame origin-frame
;;                                                  edge1-frame edge2-frame)
;;   (make-frame origin edge1 edge2) -- a frame (use either constructor from the exercise)
;;   (origin-frame f) (edge1-frame f) (edge2-frame f) -- the matching selectors
;; The components can be any objects, so you do not need vectors here.

