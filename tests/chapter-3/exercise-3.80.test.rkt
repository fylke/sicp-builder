#lang sicp
(#%require rackunit "../lib.rkt")

;; Your exercises/chapter-3/exercise-3.80.rkt must (#%provide RLC)
;;   (RLC R L C dt) -> a procedure (lambda (vc0 il0) ...) which returns (cons vc il), the pair
;;   of streams of capacitor voltage and inductor current for the series RLC circuit
;;     dvc/dt = -il/C,   dil/dt = vc/L - (R/L) il
;;   with initial values vc0 and il0. Element k is the explicit-Euler value
;;   (v_(k+1) = v_k + dt * dv_k, i_(k+1) = i_k + dt * di_k).
;; Define integral and the stream helpers yourself in the file.

(define (head s n)
  (if (or (= n 0) (null? s))
      '()
      (cons (car s) (head (force (cdr s)) (- n 1)))))

(define (check-list actual expected)
  (check-equal? (length actual) (length expected))
  (for-each (lambda (a e) (check-= a e 1e-9)) actual expected))

(define (euler-vc R L C dt vc il n)
  (if (= n 0)
      '()
      (cons vc (euler-vc R L C dt
                         (+ vc (* dt (/ (- il) C)))
                         (+ il (* dt (- (/ vc L) (* (/ R L) il))))
                         (- n 1)))))

(define (euler-il R L C dt vc il n)
  (if (= n 0)
      '()
      (cons il (euler-il R L C dt
                         (+ vc (* dt (/ (- il) C)))
                         (+ il (* dt (- (/ vc L) (* (/ R L) il))))
                         (- n 1)))))

(test-case "returns a pair of streams starting at the initial values"
  (define RLC (solution "3.80" 'RLC))
  (let ((state ((RLC 1 1 0.2 0.1) 10 0)))
    (check-true (pair? state))
    (check-= (car (car state)) 10 1e-9)
    (check-= (car (cdr state)) 0 1e-9)))

(test-case "capacitor voltage matches Euler (R=1, L=1, C=0.2, dt=0.1, vc0=10, il0=0)"
  (define RLC (solution "3.80" 'RLC))
  (let ((state ((RLC 1 1 0.2 0.1) 10 0)))
    (check-list (head (car state) 10) (euler-vc 1 1 0.2 0.1 10 0 10))))

(test-case "inductor current matches Euler (R=1, L=1, C=0.2, dt=0.1, vc0=10, il0=0)"
  (define RLC (solution "3.80" 'RLC))
  (let ((state ((RLC 1 1 0.2 0.1) 10 0)))
    (check-list (head (cdr state) 10) (euler-il 1 1 0.2 0.1 10 0 10))))

(test-case "different parameters and initial current"
  (define RLC (solution "3.80" 'RLC))
  (let ((state ((RLC 2 0.5 0.25 0.05) 3 4)))
    (check-list (head (car state) 8) (euler-vc 2 0.5 0.25 0.05 3 4 8))
    (check-list (head (cdr state) 8) (euler-il 2 0.5 0.25 0.05 3 4 8))))

(test-case "the voltage oscillates and decays"
  (define RLC (solution "3.80" 'RLC))
  (let ((state ((RLC 1 1 0.2 0.001) 10 0)))
    (let ((vcs (head (car state) 3001)))
      (check-true (< (car (reverse vcs)) 10))
      (check-true (< (apply min vcs) 0)))))
