#lang sicp
(#%require rackunit "../lib.rkt" (only racket/base exn:fail?))

;; Your exercises/chapter-2/exercise-2.68.rkt must (#%provide sample-tree encode encode-symbol)
;;   sample-tree                -- the encoding tree of Exercise 2.67 (A 0, B 10, D 110, C 111)
;;   (encode message tree)      -- the list of bits encoding the list of symbols message
;;   (encode-symbol symbol tree)-- the list of bits encoding one symbol; signals an error if
;;                                 the symbol is not in the tree
;; The Huffman tree representation (make-leaf, make-code-tree, ...) from section 2.3.4 must be
;; defined in your file too.

(test-case "encode-symbol on the sample tree"
  (define sample-tree (solution "2.68" 'sample-tree))
  (define encode-symbol (solution "2.68" 'encode-symbol))
  (check-equal? (encode-symbol 'A sample-tree) '(0))
  (check-equal? (encode-symbol 'B sample-tree) '(1 0))
  (check-equal? (encode-symbol 'D sample-tree) '(1 1 0))
  (check-equal? (encode-symbol 'C sample-tree) '(1 1 1)))

(test-case "encode-symbol signals an error for an unknown symbol"
  (define sample-tree (solution "2.68" 'sample-tree))
  (define encode-symbol (solution "2.68" 'encode-symbol))
  (check-exn exn:fail? (lambda () (encode-symbol 'E sample-tree))))

(test-case "encoding the message of Exercise 2.67 gives sample-message"
  (define sample-tree (solution "2.68" 'sample-tree))
  (define encode (solution "2.68" 'encode))
  (check-equal? (encode '(A D A B B C A) sample-tree)
                '(0 1 1 0 0 1 0 1 0 1 1 1 0)))

(test-case "encoding other messages"
  (define sample-tree (solution "2.68" 'sample-tree))
  (define encode (solution "2.68" 'encode))
  (check-equal? (encode '() sample-tree) '())
  (check-equal? (encode '(C D B A) sample-tree) '(1 1 1 1 1 0 1 0 0))
  (check-equal? (encode '(A A A) sample-tree) '(0 0 0)))

(test-case "encode signals an error if some symbol is unknown"
  (define sample-tree (solution "2.68" 'sample-tree))
  (define encode (solution "2.68" 'encode))
  (check-exn exn:fail? (lambda () (encode '(A B Z) sample-tree))))
