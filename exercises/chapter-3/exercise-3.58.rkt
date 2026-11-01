#lang sicp
;; Exercise 3.58
;;
;; Give an interpretation of the
;; stream computed by the following procedure:
;;
;; ```scheme
;; (define (expand num den radix)
;;   (cons-stream
;;    (quotient (* num radix) den)
;;    (expand (remainder (* num radix) den)
;;            den
;;            radix)))
;; ```
;;
;; (`Quotient` is a primitive that returns the integer quotient of two
;; integers.)  What are the successive elements produced by `(expand 1 7
;; 10)`?  What is produced by `(expand 3 8 10)`?

;; Test: raco test tests/chapter-3/exercise-3.58.test.rkt
;; Your exercises/chapter-3/exercise-3.58.rkt must (#%provide expand)
;;   (expand num den radix) -> the book's stream of digits of num/den in the given radix:
;;       its first element is (quotient (* num radix) den) and the rest is
;;       (expand (remainder (* num radix) den) den radix)
;; (Type the procedure in as given, with cons-stream.)

