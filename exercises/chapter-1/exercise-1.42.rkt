#lang sicp
;; Exercise 1.42
;;
;; Let $f$ and $g$ be two
;; one-argument functions.  The *composition* $f$ after $g$ is defined
;; to be the function ${x \mapsto f(g(x))}$.  Define a procedure
;; `compose` that implements composition.  For example, if `inc` is a
;; procedure that adds 1 to its argument,
;;
;; ```scheme
;; ((compose square inc) 6)
;; 49
;; ```

;; Test: raco test tests/chapter-1/exercise-1.42.test.rkt
;; Your exercises/chapter-1/exercise-1.42.rkt must (#%provide compose)
;;   (compose f g) -- the procedure x -> (f (g x))

