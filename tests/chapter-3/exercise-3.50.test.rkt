#lang sicp
(#%require rackunit "../lib.rkt")

;; Your exercises/chapter-3/exercise-3.50.rkt must (#%provide stream-map)
;;   (stream-map proc s1 s2 ...) -> the stream of (proc x1 x2 ...) over the elements of the
;;       argument streams, stopping when the first stream runs out; with one stream it is
;;       the ordinary stream-map. It must be lazy (use cons-stream).
;; Define stream-car / stream-cdr yourself in the file (this language does not have them);
;; streams here are pairs whose cdr is a promise: (car s) and (force (cdr s)).

(define (head s n)
  (if (or (= n 0) (null? s))
      '()
      (cons (car s) (head (force (cdr s)) (- n 1)))))

(define (ints n) (cons-stream n (ints (+ n 1))))

(define (from-list l)
  (if (null? l)
      the-empty-stream
      (cons-stream (car l) (from-list (cdr l)))))

(test-case "one stream"
  (define stream-map (solution "3.50" 'stream-map))
  (check-equal? (head (stream-map (lambda (x) (* x x)) (ints 1)) 5) '(1 4 9 16 25)))

(test-case "two streams"
  (define stream-map (solution "3.50" 'stream-map))
  (check-equal? (head (stream-map + (ints 1) (ints 10)) 4) '(11 13 15 17))
  (check-equal? (head (stream-map * (ints 1) (ints 1)) 4) '(1 4 9 16)))

(test-case "three streams"
  (define stream-map (solution "3.50" 'stream-map))
  (check-equal? (head (stream-map + (ints 1) (ints 10) (ints 100)) 3) '(111 114 117))
  (check-equal? (head (stream-map list (ints 1) (ints 2) (ints 3)) 2) '((1 2 3) (2 3 4))))

(test-case "finite streams end the result"
  (define stream-map (solution "3.50" 'stream-map))
  (define result (stream-map + (from-list '(1 2 3)) (from-list '(10 20 30))))
  (check-equal? (head result 10) '(11 22 33))
  (check-equal? (head (stream-map (lambda (x) x) the-empty-stream) 3) '()))

(test-case "the result is lazy: only as much of the inputs is forced as is read"
  (define stream-map (solution "3.50" 'stream-map))
  (define (boom n)
    (cons-stream n (if (= n 4) (error "forced too far") (boom (+ n 1)))))
  (check-equal? (head (stream-map + (boom 1) (boom 1)) 3) '(2 4 6)))

(test-case "infinite streams work on both inputs"
  (define stream-map (solution "3.50" 'stream-map))
  (define ones (cons-stream 1 ones))
  (check-equal? (head (stream-map + ones (ints 0)) 4) '(1 2 3 4)))
