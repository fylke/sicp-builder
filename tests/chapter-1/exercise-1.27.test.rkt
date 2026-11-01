#lang sicp
(#%require rackunit "../lib.rkt")

;; Your exercises/chapter-1/exercise-1.27.rkt must (#%provide fools-fermat-test?)
;;   (fools-fermat-test? n) -- #t if a^n is congruent to a modulo n for EVERY a with 1 <= a < n,
;;                             #f otherwise (so true for primes and Carmichael numbers)
;; (define expmod yourself)

(test-case "primes pass"
  (define fools-fermat-test? (solution "1.27" 'fools-fermat-test?))
  (check-true (fools-fermat-test? 2))
  (check-true (fools-fermat-test? 3))
  (check-true (fools-fermat-test? 7))
  (check-true (fools-fermat-test? 101))
  (check-true (fools-fermat-test? 997)))

(test-case "Carmichael numbers fool the test"
  (define fools-fermat-test? (solution "1.27" 'fools-fermat-test?))
  (check-true (fools-fermat-test? 561))
  (check-true (fools-fermat-test? 1105))
  (check-true (fools-fermat-test? 1729))
  (check-true (fools-fermat-test? 2465))
  (check-true (fools-fermat-test? 2821))
  (check-true (fools-fermat-test? 6601)))

(test-case "ordinary composites fail"
  (define fools-fermat-test? (solution "1.27" 'fools-fermat-test?))
  (check-false (fools-fermat-test? 4))
  (check-false (fools-fermat-test? 9))
  (check-false (fools-fermat-test? 15))
  (check-false (fools-fermat-test? 91))
  (check-false (fools-fermat-test? 562))
  (check-false (fools-fermat-test? 1000)))
