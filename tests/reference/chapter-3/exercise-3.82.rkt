#lang sicp
(#%provide estimate-integral)

(define (stream-car s) (car s))
(define (stream-cdr s) (force (cdr s)))

(define (stream-map proc . argstreams)
  (if (null? (car argstreams))
      the-empty-stream
      (cons-stream
       (apply proc (map stream-car argstreams))
       (apply stream-map
              (cons proc (map stream-cdr argstreams))))))

(define (random-in-range low high)
  (+ low (* (random 1.0) (- high low))))

(define (random-in-range-stream low high)
  (cons-stream (random-in-range low high) (random-in-range-stream low high)))

(define (monte-carlo experiment-stream passed failed)
  (define (next passed failed)
    (cons-stream (/ passed (+ passed failed))
                 (monte-carlo (stream-cdr experiment-stream) passed failed)))
  (if (stream-car experiment-stream)
      (next (+ passed 1) failed)
      (next passed (+ failed 1))))

(define (estimate-integral P x1 x2 y1 y2)
  (let ((area (* (- x2 x1) (- y2 y1))))
    (stream-map (lambda (ratio) (* area ratio))
                (monte-carlo (stream-map P
                                         (random-in-range-stream x1 x2)
                                         (random-in-range-stream y1 y2))
                             0 0))))
