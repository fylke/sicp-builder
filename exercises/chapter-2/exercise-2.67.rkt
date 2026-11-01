#lang sicp
;; Exercise 2.67
;;
;; Define an encoding tree and a
;; sample message:
;;
;; ```scheme
;; (define sample-tree
;;   (make-code-tree
;;    (make-leaf 'A 4)
;;    (make-code-tree
;;     (make-leaf 'B 2)
;;     (make-code-tree
;;      (make-leaf 'D 1)
;;      (make-leaf 'C 1)))))
;;
;; (define sample-message
;;   '(0 1 1 0 0 1 0 1 0 1 1 1 0))
;; ```
;;
;; Use the `decode` procedure to decode the message, and give the result.

;; Test: raco test tests/chapter-2/exercise-2.67.test.rkt
;; Your exercises/chapter-2/exercise-2.67.rkt must (#%provide sample-tree sample-message decode)
;;   sample-tree            -- the encoding tree of the exercise (A 0, B 10, D 110, C 111)
;;   sample-message         -- the list of bits (0 1 1 0 0 1 0 1 0 1 1 1 0)
;;   (decode bits tree)     -- the list of symbols that the bits encode according to tree
;; Define sample-tree and sample-message as in the exercise; the Huffman tree representation
;; (make-leaf, make-code-tree, ...) from section 2.3.4 must be defined in your file too.

