#lang sicp
;; Exercise 1.27
;;
;; Demonstrate that the Carmichael
;; numbers listed in Footnote 47 really do fool the Fermat test.  That is,
;; write a procedure that takes an integer $n$ and tests whether $a^n$ is
;; congruent to $a$ modulo $n$ for every ${a < n}$, and try your procedure
;; on the given Carmichael numbers.

;; Test: raco test tests/chapter-1/exercise-1.27.test.rkt
;; Your exercises/chapter-1/exercise-1.27.rkt must (#%provide fools-fermat-test?)
;;   (fools-fermat-test? n) -- #t if a^n is congruent to a modulo n for EVERY a with 1 <= a < n,
;;                             #f otherwise (so true for primes and Carmichael numbers)
;; (define expmod yourself)

