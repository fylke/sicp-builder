#lang sicp
;; Exercise 3.77
;;
;; The `integral` procedure
;; used above was analogous to the “implicit” definition of the infinite stream
;; of integers in 3.5.2.  Alternatively, we can give a definition of
;; `integral` that is more like `integers-starting-from` (also in
;; 3.5.2):
;;
;; ```scheme
;; (define (integral
;;          integrand initial-value dt)
;;   (cons-stream
;;    initial-value
;;    (if (stream-null? integrand)
;;        the-empty-stream
;;        (integral
;;         (stream-cdr integrand)
;;         (+ (* dt (stream-car integrand))
;;            initial-value)
;;         dt))))
;; ```
;;
;; When used in systems with loops, this procedure has the same problem as does
;; our original version of `integral`.  Modify the procedure so that it
;; expects the `integrand` as a delayed argument and hence can be used in the
;; `solve` procedure shown above.

;; Test: raco test tests/chapter-3/exercise-3.77.test.rkt
;; Your exercises/chapter-3/exercise-3.77.rkt must (#%provide integral)
;;   (integral delayed-integrand initial-value dt) -> the stream of the integral of the stream
;;   that (force delayed-integrand) yields; the integrand is passed delayed, e.g.
;;   (integral (delay dy) y0 dt), and must not be forced before the first element is needed.

