#lang sicp
;; Exercise 2.69
;;
;; The following procedure takes as
;; its argument a list of symbol-frequency pairs (where no symbol appears in more
;; than one pair) and generates a Huffman encoding tree according to the Huffman
;; algorithm.
;;
;; ```scheme
;; (define (generate-huffman-tree pairs)
;;   (successive-merge
;;    (make-leaf-set pairs)))
;; ```
;;
;; `Make-leaf-set` is the procedure given above that transforms the list of
;; pairs into an ordered set of leaves.  `Successive-merge` is the procedure
;; you must write, using `make-code-tree` to successively merge the
;; smallest-weight elements of the set until there is only one element left, which
;; is the desired Huffman tree.  (This procedure is slightly tricky, but not
;; really complicated.  If you find yourself designing a complex procedure, then
;; you are almost certainly doing something wrong.  You can take significant
;; advantage of the fact that we are using an ordered set representation.)

;; Test: raco test tests/chapter-2/exercise-2.69.test.rkt
;; Your exercises/chapter-2/exercise-2.69.rkt must (#%provide generate-huffman-tree encode decode)
;;   (generate-huffman-tree pairs) -- the Huffman tree for a list of (symbol frequency) pairs
;;   (encode message tree)         -- list of bits encoding a list of symbols with tree
;;   (decode bits tree)            -- list of symbols decoded from a list of bits with tree
;; Define successive-merge and make-leaf-set as well as encode, decode (and encode-symbol)
;; from the previous exercises and the Huffman tree representation of section 2.3.4 in your file.
;; The tests only check round trips and the optimal total length, so tie-breaking is up to you.

