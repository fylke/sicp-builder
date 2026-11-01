#lang sicp
(#%provide merge-weighted weighted-pairs pairs-a pairs-b)

(define (stream-car s) (car s))
(define (stream-cdr s) (force (cdr s)))

(define (stream-map proc . argstreams)
  (if (null? (car argstreams))
      the-empty-stream
      (cons-stream
       (apply proc (map stream-car argstreams))
       (apply stream-map
              (cons proc (map stream-cdr argstreams))))))

(define (stream-filter pred s)
  (cond ((null? s) the-empty-stream)
        ((pred (stream-car s))
         (cons-stream (stream-car s) (stream-filter pred (stream-cdr s))))
        (else (stream-filter pred (stream-cdr s)))))

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
(define integers (integers-from 1))

(define pairs-a
  (weighted-pairs integers integers (lambda (p) (+ (car p) (cadr p)))))

(define (ok? n) (not (or (= (remainder n 2) 0) (= (remainder n 3) 0) (= (remainder n 5) 0))))

(define pairs-b
  (let ((good (stream-filter ok? integers)))
    (weighted-pairs good good
                    (lambda (p)
                      (+ (* 2 (car p)) (* 3 (cadr p)) (* 5 (car p) (cadr p)))))))
