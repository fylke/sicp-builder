#lang sicp
(#%provide struct-3 struct-4 struct-7 struct-cycle)

;; each structure is made of exactly three pairs
(define struct-3 (list 'a 'b 'c))

(define struct-4
  (let* ((c (cons 'x '()))
         (b (cons c '())))
    (cons b c)))

(define struct-7
  (let* ((p3 (cons 'a 'b))
         (p2 (cons p3 p3)))
    (cons p2 p2)))

(define struct-cycle
  (let ((x (list 'a 'b 'c)))
    (set-cdr! (cddr x) x)
    x))
