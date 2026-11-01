#lang sicp
;; Exercise 1.31
;;
;; - (a) The `sum` procedure is only the simplest of a vast number of similar
;; abstractions that can be captured as higher-order procedures.[^1]  Write an analogous
;; procedure called `product` that returns the product of the values of a
;; function at points over a given range.  Show how to define `factorial` in
;; terms of `product`.  Also use `product` to compute approximations to
;; $\pi$ using the formula[^2]
;;
;;       $$
;;       \frac{\pi}{4} \,=\, {\frac{2\cdot 4\cdot 4\cdot 6\cdot 6\cdot 8\cdot\cdots}
;;                            {3\cdot 3\cdot 5\cdot 5\cdot 7\cdot 7\cdot\cdots}.}
;;       $$
;;
;; - (b) If your `product` procedure generates a recursive process, write one that
;; generates an iterative process.  If it generates an iterative process, write
;; one that generates a recursive process.
;;
;; [^1]: The
;; intent of [Exercise 1.31](../chapter-1/exercise-1.31.rkt) through [Exercise 1.33](../chapter-1/exercise-1.33.rkt) is to demonstrate the
;; expressive power that is attained by using an appropriate abstraction to
;; consolidate many seemingly disparate operations.  However, though accumulation
;; and filtering are elegant ideas, our hands are somewhat tied in using them at
;; this point since we do not yet have data structures to provide suitable means
;; of combination for these abstractions.  We will return to these ideas in
;; 2.2.3 when we show how to use *sequences* as interfaces
;; for combining filters and accumulators to build even more powerful
;; abstractions.  We will see there how these methods really come into their own
;; as a powerful and elegant approach to designing programs.
;;
;; [^2]: This formula was discovered by the
;; seventeenth-century English mathematician John Wallis.

;; Test: raco test tests/chapter-1/exercise-1.31.test.rkt
;; Your exercises/chapter-1/exercise-1.31.rkt must (#%provide product product-iter factorial pi-approx)
;;   (product term a next b)      -- product of (term x) for x = a, (next a), ... while x <= b (empty product is 1)
;;   (product-iter term a next b) -- the same, by the other kind of process (iterative if `product`
;;                                   is recursive, or recursive if `product` is iterative)
;;   (factorial n)                -- n!, defined with product (factorial 0 = 1)
;;   (pi-approx n)                -- approximation of pi from Wallis's formula using n steps
;;                                   (accurate to about 3 decimals for n = 10000)

