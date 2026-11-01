#lang sicp
(#%provide RLC)

(define (stream-car s) (car s))
(define (stream-cdr s) (force (cdr s)))

(define (stream-map proc . argstreams)
  (if (null? (car argstreams))
      the-empty-stream
      (cons-stream
       (apply proc (map stream-car argstreams))
       (apply stream-map
              (cons proc (map stream-cdr argstreams))))))

(define (add-streams s1 s2) (stream-map + s1 s2))

(define (scale-stream stream factor)
  (stream-map (lambda (x) (* x factor)) stream))

(define (integral delayed-integrand initial-value dt)
  (define int
    (cons-stream initial-value
                 (let ((integrand (force delayed-integrand)))
                   (add-streams (scale-stream integrand dt) int))))
  int)

(define (RLC R L C dt)
  (lambda (vc0 il0)
    (let ((vc '*) (il '*) (dvc '*) (dil '*))
      (set! vc (integral (delay dvc) vc0 dt))
      (set! il (integral (delay dil) il0 dt))
      (set! dvc (scale-stream il (/ -1 C)))
      (set! dil (add-streams (scale-stream vc (/ 1 L))
                             (scale-stream il (- (/ R L)))))
      (cons vc il))))
