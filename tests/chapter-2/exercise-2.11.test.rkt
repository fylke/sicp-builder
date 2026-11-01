#lang sicp
(#%require rackunit "../lib.rkt")

;; Your exercises/chapter-2/exercise-2.11.rkt must (#%provide make-interval lower-bound upper-bound
;;                                                  mul-interval)
;;   (make-interval a b) -- the interval from a to b; (lower-bound i), (upper-bound i) its ends
;;   (mul-interval x y)  -- x * y, rewritten by testing the signs of the endpoints
;; You define all of these yourself.

(define (interval-list)
  ;; (lower upper) pairs covering every sign pattern, including zero endpoints
  '((1 2) (3 5) (-2 -1) (-5 -3) (-1 2) (-3 1) (0 3) (-3 0) (0 0) (0 2) (-2 0) (-4 6)))

(define (check-product make-interval lower-bound upper-bound mul-interval a b c d)
  (define p (mul-interval (make-interval a b) (make-interval c d)))
  (define products (list (* a c) (* a d) (* b c) (* b d)))
  (define msg
    (string-append "mul-interval [" (number->string a) "," (number->string b) "] ["
                   (number->string c) "," (number->string d) "]"))
  (check-= (lower-bound p) (apply min products) 1e-9 msg)
  (check-= (upper-bound p) (apply max products) 1e-9 msg))

(test-case "all combinations of sign patterns"
  (define make-interval (solution "2.11" 'make-interval))
  (define lower-bound (solution "2.11" 'lower-bound))
  (define upper-bound (solution "2.11" 'upper-bound))
  (define mul-interval (solution "2.11" 'mul-interval))
  (for-each
   (lambda (x)
     (for-each
      (lambda (y)
        (check-product make-interval lower-bound upper-bound mul-interval
                       (car x) (cadr x) (car y) (cadr y)))
      (interval-list)))
   (interval-list)))

(test-case "a few concrete products"
  (define make-interval (solution "2.11" 'make-interval))
  (define lower-bound (solution "2.11" 'lower-bound))
  (define upper-bound (solution "2.11" 'upper-bound))
  (define mul-interval (solution "2.11" 'mul-interval))
  (define p (mul-interval (make-interval -2 3) (make-interval -4 5)))
  (check-= (lower-bound p) -12 1e-9)
  (check-= (upper-bound p) 15 1e-9)
  (define q (mul-interval (make-interval 2 3) (make-interval 4 5)))
  (check-= (lower-bound q) 8 1e-9)
  (check-= (upper-bound q) 15 1e-9)
  (define r (mul-interval (make-interval -3 -2) (make-interval 4 5)))
  (check-= (lower-bound r) -15 1e-9)
  (check-= (upper-bound r) -8 1e-9))
