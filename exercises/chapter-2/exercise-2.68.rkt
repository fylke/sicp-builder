#lang sicp
;; Exercise 2.68
;;
;; The `encode` procedure takes
;; as arguments a message and a tree and produces the list of bits that gives the
;; encoded message.
;;
;; ```scheme
;; (define (encode message tree)
;;   (if (null? message)
;;       '()
;;       (append
;;        (encode-symbol (car message)
;;                       tree)
;;        (encode (cdr message) tree))))
;; ```
;;
;; `Encode-symbol` is a procedure, which you must write, that returns the
;; list of bits that encodes a given symbol according to a given tree.  You should
;; design `encode-symbol` so that it signals an error if the symbol is not in
;; the tree at all.  Test your procedure by encoding the result you obtained in
;; [Exercise 2.67](../chapter-2/exercise-2.67.rkt) with the sample tree and seeing whether it is the same as
;; the original sample message.

;; Test: raco test tests/chapter-2/exercise-2.68.test.rkt
;; Your exercises/chapter-2/exercise-2.68.rkt must (#%provide sample-tree encode encode-symbol)
;;   sample-tree                -- the encoding tree of Exercise 2.67 (A 0, B 10, D 110, C 111)
;;   (encode message tree)      -- the list of bits encoding the list of symbols message
;;   (encode-symbol symbol tree)-- the list of bits encoding one symbol; signals an error if
;;                                 the symbol is not in the tree
;; The Huffman tree representation (make-leaf, make-code-tree, ...) from section 2.3.4 must be
;; defined in your file too.

