#lang sicp
(#%require rackunit "../lib.rkt")

;; Your exercises/chapter-1/exercise-1.37.rkt must (#%provide cont-frac cont-frac-iter)
;;   (cont-frac n d k)      -- value of the k-term finite continued fraction with numerators (n i)
;;                             and denominators (d i), i = 1..k, by one kind of process
;;   (cont-frac-iter n d k) -- the same, by the other kind (iterative if cont-frac is recursive,
;;                             recursive if cont-frac is iterative)

(define (check-cont-frac cont-frac)
  (check-= (cont-frac (lambda (i) 1.0) (lambda (i) 1.0) 1) 1.0 1e-12)
  (check-= (cont-frac (lambda (i) 1.0) (lambda (i) 1.0) 2) 0.5 1e-12)
  (check-= (cont-frac (lambda (i) 1.0) (lambda (i) 1.0) 3) (/ 2.0 3) 1e-12)
  (check-= (cont-frac (lambda (i) 1.0) (lambda (i) 1.0) 12) 0.6180339887498949 1e-4)
  (check-= (cont-frac (lambda (i) 1.0) (lambda (i) 1.0) 100) 0.6180339887498949 1e-9)
  ;; i-dependent terms: 1/(10 + 2/(10 + 3/10))
  (check-= (cont-frac (lambda (i) i) (lambda (i) 10) 3)
           (/ 1.0 (+ 10 (/ 2.0 (+ 10 (/ 3.0 10)))))
           1e-12)
  ;; 3/(1 + 5/2): checks that the right numerator and denominator are used for each i
  (check-= (cont-frac (lambda (i) (if (= i 1) 3.0 5.0)) (lambda (i) (if (= i 1) 1.0 2.0)) 2)
           (/ 3.0 (+ 1 (/ 5.0 2)))
           1e-12))

(test-case "cont-frac"
  (check-cont-frac (solution "1.37" 'cont-frac)))

(test-case "cont-frac-iter"
  (check-cont-frac (solution "1.37" 'cont-frac-iter)))
