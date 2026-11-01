#lang sicp
(#%require rackunit "../lib.rkt")

;; Your exercises/chapter-3/exercise-3.30.rkt must
;;   (#%provide make-wire get-signal set-signal! propagate ripple-carry-adder)
;; The digital-circuit simulator of section 3.3.4 is NOT part of the exercise: copy the
;; book's code (wires, agenda, inverter, and-gate, or-gate, half-adder, full-adder) into
;; your file and add ripple-carry-adder.
;;   (make-wire) (get-signal wire) (set-signal! wire v) (propagate)  -> as in the book
;;   (ripple-carry-adder as bs ss c) -> as, bs, ss are lists of n wires (A1..An, B1..Bn,
;;       S1..Sn); c is the carry-out wire. A1 is the MOST significant bit and An the
;;       least significant one (as in Figure 3.27); the last full-adder's carry-in is 0.

(define (make-wires make-wire n)
  (if (= n 0) '() (cons (make-wire) (make-wires make-wire (- n 1)))))

;; bits of v, most significant first, n bits
(define (bits v n)
  (define (build i acc)
    (if (= i n)
        acc
        (build (+ i 1) (cons (remainder (quotient v (expt 2 i)) 2) acc))))
  (build 0 '()))

(define (set-all! set-signal! wires values)
  (if (not (null? wires))
      (begin (set-signal! (car wires) (car values))
             (set-all! set-signal! (cdr wires) (cdr values)))))

(define (read-all get-signal wires)
  (map get-signal wires))

(define (run-add n x y)
  (let* ((make-wire (solution "3.30" 'make-wire))
         (get-signal (solution "3.30" 'get-signal))
         (set-signal! (solution "3.30" 'set-signal!))
         (propagate (solution "3.30" 'propagate))
         (ripple-carry-adder (solution "3.30" 'ripple-carry-adder))
         (as (make-wires make-wire n))
         (bs (make-wires make-wire n))
         (ss (make-wires make-wire n))
         (c (make-wire)))
    (ripple-carry-adder as bs ss c)
    (set-all! set-signal! as (bits x n))
    (set-all! set-signal! bs (bits y n))
    (propagate)
    (list (read-all get-signal ss) (get-signal c))))

(define (expected n x y)
  (let ((sum (+ x y)))
    (list (bits (remainder sum (expt 2 n)) n)
          (quotient sum (expt 2 n)))))

(test-case "adds two 1-bit numbers"
  (check-equal? (run-add 1 0 0) (expected 1 0 0))
  (check-equal? (run-add 1 1 0) (expected 1 1 0))
  (check-equal? (run-add 1 1 1) (expected 1 1 1)))

(test-case "adds 3-bit numbers: 3 + 2 and 5 + 3 (carry out)"
  (check-equal? (run-add 3 3 2) '((1 0 1) 0))
  (check-equal? (run-add 3 5 3) '((0 0 0) 1))
  (check-equal? (run-add 3 7 7) '((1 1 0) 1)))

(test-case "carry ripples through every bit"
  (check-equal? (run-add 4 15 1) '((0 0 0 0) 1))
  (check-equal? (run-add 4 7 1) '((1 0 0 0) 0)))

(test-case "all pairs of 3-bit numbers"
  (define (loop x y)
    (cond ((= x 8) (check-true #t))
          ((= y 8) (loop (+ x 1) 0))
          (else (check-equal? (run-add 3 x y) (expected 3 x y))
                (loop x (+ y 1)))))
  (loop 0 0))
