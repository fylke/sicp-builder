#lang sicp
(#%provide e-approx)

(define (cont-frac n d k)
  (define (iter i result)
    (if (= i 0)
        result
        (iter (- i 1) (/ (n i) (+ (d i) result)))))
  (iter k 0))

(define (e-approx k)
  (+ 2.0
     (cont-frac (lambda (i) 1.0)
                (lambda (i)
                  (if (= (remainder i 3) 2)
                      (* 2 (/ (+ i 1) 3))
                      1))
                k)))
