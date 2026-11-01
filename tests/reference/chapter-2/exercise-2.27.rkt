#lang sicp
(#%provide deep-reverse)

(define (deep-reverse x)
  (define (iter rest result)
    (if (null? rest)
        result
        (iter (cdr rest) (cons (deep-reverse (car rest)) result))))
  (if (pair? x)
      (iter x '())
      x))
