#lang sicp
(#%require rackunit "../lib.rkt")

;; Your exercises/chapter-1/exercise-1.28.rkt must (#%provide miller-rabin-test fast-prime?)
;;   (miller-rabin-test n)  -- ONE Miller-Rabin trial with a random a in [1, n-1], for odd n >= 3;
;;                             always #t for a prime n, usually #f for a composite n
;;   (fast-prime? n times)  -- #t if `times` random trials all pass (odd n >= 3)
;; (define expmod, which signals nontrivial square roots of 1, yourself)

(test-case "a single trial always accepts primes"
  (define miller-rabin-test (solution "1.28" 'miller-rabin-test))
  (for-each (lambda (p)
              (do ((i 0 (+ i 1)))
                  ((= i 30))
                (check-true (miller-rabin-test p))))
            '(3 5 7 13 97 1009 10007 1000003)))

(test-case "fast-prime? accepts primes"
  (define fast-prime? (solution "1.28" 'fast-prime?))
  (for-each (lambda (p) (check-true (fast-prime? p 30)))
            '(3 5 7 11 101 1009 7919 104729 1000003 2147483647)))

(test-case "fast-prime? rejects ordinary composites"
  (define fast-prime? (solution "1.28" 'fast-prime?))
  (for-each (lambda (n) (check-false (fast-prime? n 30)))
            '(9 15 21 25 27 91 221 1001 100001)))

(test-case "fast-prime? rejects Carmichael numbers"
  (define fast-prime? (solution "1.28" 'fast-prime?))
  (for-each (lambda (n) (check-false (fast-prime? n 30)))
            '(561 1105 1729 2465 2821 6601 8911 10585 252601)))
