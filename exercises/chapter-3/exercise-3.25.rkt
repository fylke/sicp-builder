#lang sicp
;; Exercise 3.25
;;
;; Generalizing one- and
;; two-dimensional tables, show how to implement a table in which values are
;; stored under an arbitrary number of keys and different values may be stored
;; under different numbers of keys.  The `lookup` and `insert!`
;; procedures should take as input a list of keys used to access the table.

;; Test: raco test tests/chapter-3/exercise-3.25.test.rkt
;; Your exercises/chapter-3/exercise-3.25.rkt must (#%provide make-table lookup insert!)
;;   (make-table)                   -> a new empty table
;;   (insert! keys value table)     -> stores value under the list of keys (any length >= 1)
;;   (lookup keys table)            -> the value stored under exactly that list of keys,
;;                                     or #f if there is none
;; Values stored under different numbers of keys must coexist, including a value under
;; (a) alongside values under (a b) and (a b c).

