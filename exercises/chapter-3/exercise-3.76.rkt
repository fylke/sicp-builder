#lang sicp
;; Exercise 3.76
;;
;; Eva Lu Ator has a criticism of
;; Louis’s approach in [Exercise 3.75](../chapter-3/exercise-3.75.rkt).  The program he wrote is not modular,
;; because it intermixes the operation of smoothing with the zero-crossing
;; extraction.  For example, the extractor should not have to be changed if Alyssa
;; finds a better way to condition her input signal.  Help Louis by writing a
;; procedure `smooth` that takes a stream as input and produces a stream in
;; which each element is the average of two successive input stream elements.
;; Then use `smooth` as a component to implement the zero-crossing detector
;; in a more modular style.

;; Test: raco test tests/chapter-3/exercise-3.76.test.rkt
;; Your exercises/chapter-3/exercise-3.76.rkt must (#%provide smooth make-zero-crossings)
;;   (smooth s) -> stream whose elements are the average of two successive elements of s
;;   (make-zero-crossings input-stream last-value) -> the zero-crossing stream of Exercise 3.74,
;;       called as (make-zero-crossings data 0); it must not do any smoothing itself
;; Define sign-change-detector (Exercise 3.74; 0 counts as positive) and stream-map yourself.

