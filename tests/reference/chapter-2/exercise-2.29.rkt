#lang sicp
(#%provide make-mobile make-branch left-branch right-branch
           branch-length branch-structure total-weight balanced?)

(define (make-mobile left right) (list left right))
(define (make-branch length structure) (list length structure))
(define (left-branch m) (car m))
(define (right-branch m) (cadr m))
(define (branch-length b) (car b))
(define (branch-structure b) (cadr b))

(define (branch-weight b)
  (let ((s (branch-structure b)))
    (if (pair? s) (total-weight s) s)))
(define (total-weight m)
  (+ (branch-weight (left-branch m)) (branch-weight (right-branch m))))

(define (torque b) (* (branch-length b) (branch-weight b)))
(define (branch-balanced? b)
  (let ((s (branch-structure b)))
    (or (not (pair? s)) (balanced? s))))
(define (balanced? m)
  (and (= (torque (left-branch m)) (torque (right-branch m)))
       (branch-balanced? (left-branch m))
       (branch-balanced? (right-branch m))))
