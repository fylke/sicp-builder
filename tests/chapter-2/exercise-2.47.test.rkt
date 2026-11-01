#lang sicp
(#%require rackunit "../lib.rkt")

;; Your exercises/chapter-2/exercise-2.47.rkt must (#%provide make-frame origin-frame
;;                                                  edge1-frame edge2-frame)
;;   (make-frame origin edge1 edge2) -- a frame (use either constructor from the exercise)
;;   (origin-frame f) (edge1-frame f) (edge2-frame f) -- the matching selectors
;; The components can be any objects, so you do not need vectors here.

(test-case "origin-frame"
  (define make-frame (solution "2.47" 'make-frame))
  (define origin-frame (solution "2.47" 'origin-frame))
  (check-equal? (origin-frame (make-frame 'o 'e1 'e2)) 'o)
  (check-equal? (origin-frame (make-frame '(0 . 0) '(1 . 0) '(0 . 1))) '(0 . 0)))

(test-case "edge1-frame"
  (define make-frame (solution "2.47" 'make-frame))
  (define edge1-frame (solution "2.47" 'edge1-frame))
  (check-equal? (edge1-frame (make-frame 'o 'e1 'e2)) 'e1)
  (check-equal? (edge1-frame (make-frame '(0 . 0) '(1 . 0) '(0 . 1))) '(1 . 0)))

(test-case "edge2-frame"
  (define make-frame (solution "2.47" 'make-frame))
  (define edge2-frame (solution "2.47" 'edge2-frame))
  (check-equal? (edge2-frame (make-frame 'o 'e1 'e2)) 'e2)
  (check-equal? (edge2-frame (make-frame '(0 . 0) '(1 . 0) '(0 . 1))) '(0 . 1)))

(test-case "components that are themselves lists"
  (define make-frame (solution "2.47" 'make-frame))
  (define origin-frame (solution "2.47" 'origin-frame))
  (define edge1-frame (solution "2.47" 'edge1-frame))
  (define edge2-frame (solution "2.47" 'edge2-frame))
  (define f (make-frame '(1 2) '(3 4) '(5 6)))
  (check-equal? (origin-frame f) '(1 2))
  (check-equal? (edge1-frame f) '(3 4))
  (check-equal? (edge2-frame f) '(5 6)))
