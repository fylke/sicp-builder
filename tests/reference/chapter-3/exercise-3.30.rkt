#lang sicp
(#%provide make-wire get-signal set-signal! propagate ripple-carry-adder)

;; --- digital circuit simulator (section 3.3.4), simplified agenda ---
(define (make-wire)
  (let ((signal-value 0) (action-procedures '()))
    (define (set-my-signal! new-value)
      (if (not (= signal-value new-value))
          (begin (set! signal-value new-value)
                 (call-each action-procedures))
          'done))
    (define (accept-action-procedure! proc)
      (set! action-procedures (cons proc action-procedures))
      (proc))
    (define (dispatch m)
      (cond ((eq? m 'get-signal) signal-value)
            ((eq? m 'set-signal!) set-my-signal!)
            ((eq? m 'add-action!) accept-action-procedure!)
            (else (error "Unknown operation: WIRE" m))))
    dispatch))

(define (call-each procedures)
  (if (null? procedures)
      'done
      (begin ((car procedures))
             (call-each (cdr procedures)))))

(define (get-signal wire) (wire 'get-signal))
(define (set-signal! wire new-value) ((wire 'set-signal!) new-value))
(define (add-action! wire action) ((wire 'add-action!) action))

(define current-time 0)
(define agenda '())

(define (insert-agenda! time action)
  (define (insert items)
    (if (or (null? items) (< time (car (car items))))
        (cons (cons time action) items)
        (cons (car items) (insert (cdr items)))))
  (set! agenda (insert agenda)))

(define (after-delay delay action)
  (insert-agenda! (+ current-time delay) action))

(define (propagate)
  (if (null? agenda)
      'done
      (let ((first-item (car agenda)))
        (set! agenda (cdr agenda))
        (set! current-time (car first-item))
        ((cdr first-item))
        (propagate))))

(define (logical-not s) (if (= s 0) 1 0))
(define (logical-and a b) (if (and (= a 1) (= b 1)) 1 0))
(define (logical-or a b) (if (or (= a 1) (= b 1)) 1 0))

(define inverter-delay 2)
(define and-gate-delay 3)
(define or-gate-delay 5)

(define (inverter input output)
  (define (invert-input)
    (let ((new-value (logical-not (get-signal input))))
      (after-delay inverter-delay
                   (lambda () (set-signal! output new-value)))))
  (add-action! input invert-input)
  'ok)

(define (and-gate a1 a2 output)
  (define (and-action-procedure)
    (let ((new-value (logical-and (get-signal a1) (get-signal a2))))
      (after-delay and-gate-delay
                   (lambda () (set-signal! output new-value)))))
  (add-action! a1 and-action-procedure)
  (add-action! a2 and-action-procedure)
  'ok)

(define (or-gate a1 a2 output)
  (define (or-action-procedure)
    (let ((new-value (logical-or (get-signal a1) (get-signal a2))))
      (after-delay or-gate-delay
                   (lambda () (set-signal! output new-value)))))
  (add-action! a1 or-action-procedure)
  (add-action! a2 or-action-procedure)
  'ok)

(define (half-adder a b s c)
  (let ((d (make-wire)) (e (make-wire)))
    (or-gate a b d)
    (and-gate a b c)
    (inverter c e)
    (and-gate d e s)
    'ok))

(define (full-adder a b c-in sum c-out)
  (let ((s (make-wire)) (c1 (make-wire)) (c2 (make-wire)))
    (half-adder b c-in s c1)
    (half-adder a s sum c2)
    (or-gate c1 c2 c-out)
    'ok))

;; --- the exercise ---
;; The last element of each list is the least significant bit; its carry-in is 0.
;; delay: n * full-adder-delay
(define (ripple-carry-adder as bs ss c)
  (let ((c-in (make-wire)))
    (if (null? (cdr as))
        (set-signal! c-in 0)
        (ripple-carry-adder (cdr as) (cdr bs) (cdr ss) c-in))
    (full-adder (car as) (car bs) c-in (car ss) c)))
