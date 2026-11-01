#lang sicp
(#%require rackunit "../lib.rkt")

;; Your exercises/chapter-2/exercise-2.67.rkt must (#%provide sample-tree sample-message decode)
;;   sample-tree            -- the encoding tree of the exercise (A 0, B 10, D 110, C 111)
;;   sample-message         -- the list of bits (0 1 1 0 0 1 0 1 0 1 1 1 0)
;;   (decode bits tree)     -- the list of symbols that the bits encode according to tree
;; Define sample-tree and sample-message as in the exercise; the Huffman tree representation
;; (make-leaf, make-code-tree, ...) from section 2.3.4 must be defined in your file too.

(test-case "sample-message is the one from the exercise"
  (define sample-message (solution "2.67" 'sample-message))
  (check-equal? sample-message '(0 1 1 0 0 1 0 1 0 1 1 1 0)))

(test-case "decoding the sample message"
  (define sample-tree (solution "2.67" 'sample-tree))
  (define sample-message (solution "2.67" 'sample-message))
  (define decode (solution "2.67" 'decode))
  (check-equal? (decode sample-message sample-tree) '(A D A B B C A)))

(test-case "decoding single symbols"
  (define sample-tree (solution "2.67" 'sample-tree))
  (define decode (solution "2.67" 'decode))
  (check-equal? (decode '(0) sample-tree) '(A))
  (check-equal? (decode '(1 0) sample-tree) '(B))
  (check-equal? (decode '(1 1 0) sample-tree) '(D))
  (check-equal? (decode '(1 1 1) sample-tree) '(C)))

(test-case "decoding the empty message"
  (define sample-tree (solution "2.67" 'sample-tree))
  (define decode (solution "2.67" 'decode))
  (check-equal? (decode '() sample-tree) '()))

(test-case "decoding other messages"
  (define sample-tree (solution "2.67" 'sample-tree))
  (define decode (solution "2.67" 'decode))
  (check-equal? (decode '(0 0 0) sample-tree) '(A A A))
  (check-equal? (decode '(1 1 1 1 1 0 1 0 0) sample-tree) '(C D B A)))
