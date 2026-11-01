#lang sicp
(#%provide eight-queens-solutions)

(define (flat-map procedure values)
  (if (null? values)
      '()
      (append (procedure (car values))
              (flat-map procedure (cdr values)))))

(define (safe? column previous-columns)
  (define (check remaining distance)
    (or (null? remaining)
        (and (not (= column (car remaining)))
             (not (= (abs (- column (car remaining))) distance))
             (check (cdr remaining) (+ distance 1)))))
  (check previous-columns 1))

(define (eight-queens-solutions)
  (define columns '(1 2 3 4 5 6 7 8))
  (define (place row previous-columns)
    (if (> row 8)
        (list (reverse previous-columns))
        (flat-map
         (lambda (column)
           (if (safe? column previous-columns)
               (place (+ row 1) (cons column previous-columns))
               '()))
         columns)))
  (place 1 '()))
