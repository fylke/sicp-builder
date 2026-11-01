#lang sicp
(#%provide make-wire get-signal set-signal! propagate or-gate)

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

(define (logical-or a b) (if (or (= a 1) (= b 1)) 1 0))

(define or-gate-delay 5)

;; --- the exercise ---
(define (or-gate a1 a2 output)
  (define (or-action-procedure)
    (let ((new-value (logical-or (get-signal a1) (get-signal a2))))
      (after-delay or-gate-delay
                   (lambda () (set-signal! output new-value)))))
  (add-action! a1 or-action-procedure)
  (add-action! a2 or-action-procedure)
  'ok)
