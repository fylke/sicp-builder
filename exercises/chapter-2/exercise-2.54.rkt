#lang sicp
;; Exercise 2.54
;;
;; Two lists are said to be
;; `equal?` if they contain equal elements arranged in the same order.  For
;; example,
;;
;; ```scheme
;; (equal? '(this is a list)
;;         '(this is a list))
;; ```
;;
;; is true, but
;;
;; ```scheme
;; (equal? '(this is a list)
;;         '(this (is a) list))
;; ```
;;
;; is false.  To be more precise, we can define `equal?`  recursively in
;; terms of the basic `eq?` equality of symbols by saying that `a` and
;; `b` are `equal?` if they are both symbols and the symbols are
;; `eq?`, or if they are both lists such that `(car a)` is `equal?`
;; to `(car b)` and `(cdr a)` is `equal?` to `(cdr b)`.  Using
;; this idea, implement `equal?` as a procedure.[^1]
;;
;; [^1]: In practice,
;; programmers use `equal?` to compare lists that contain numbers as well as
;; symbols.  Numbers are not considered to be symbols.  The question of whether
;; two numerically equal numbers (as tested by `=`) are also `eq?` is
;; highly implementation-dependent.  A better definition of `equal?` (such as
;; the one that comes as a primitive in Scheme) would also stipulate that if
;; `a` and `b` are both numbers, then `a` and `b` are
;; `equal?` if they are numerically equal.

;; Test: raco test tests/chapter-2/exercise-2.54.test.rkt
;; Your exercises/chapter-2/exercise-2.54.rkt must (#%provide equal?)
;;   (equal? a b) -- true if a and b are the same symbol, or lists of equal? elements in the
;;                   same order. Define it yourself (it shadows the built-in in your file) using
;;                   only eq? on symbols plus car/cdr; numbers are not tested.

