#lang sicp
(#%provide ramanujan-numbers)

(define (stream-car s) (car s))
(define (stream-cdr s) (force (cdr s)))

(define (stream-map proc . argstreams)
  (if (null? (car argstreams))
      the-empty-stream
      (cons-stream
       (apply proc (map stream-car argstreams))
       (apply stream-map
              (cons proc (map stream-cdr argstreams))))))

(define (merge-weighted s1 s2 weight)
  (cond ((null? s1) s2)
        ((null? s2) s1)
        (else
         (let ((x1 (stream-car s1))
               (x2 (stream-car s2)))
           (if (<= (weight x1) (weight x2))
               (cons-stream x1 (merge-weighted (stream-cdr s1) s2 weight))
               (cons-stream x2 (merge-weighted s1 (stream-cdr s2) weight)))))))

(define (weighted-pairs s t weight)
  (cons-stream
   (list (stream-car s) (stream-car t))
   (merge-weighted
    (stream-map (lambda (x) (list (stream-car s) x)) (stream-cdr t))
    (weighted-pairs (stream-cdr s) (stream-cdr t) weight)
    weight)))

(define (integers-from n) (cons-stream n (integers-from (+ n 1))))

(define (cube x) (* x x x))
(define (cube-weight p) (+ (cube (car p)) (cube (cadr p))))

(define cube-sums
  (stream-map cube-weight
              (weighted-pairs (integers-from 1) (integers-from 1) cube-weight)))

(define (ramanujan s)
  (let ((a (stream-car s))
        (b (stream-car (stream-cdr s))))
    (if (= a b)
        (cons-stream a (ramanujan (stream-cdr s)))
        (ramanujan (stream-cdr s)))))

(define ramanujan-numbers (ramanujan cube-sums))
