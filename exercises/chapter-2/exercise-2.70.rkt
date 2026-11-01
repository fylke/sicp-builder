#lang sicp
;; Exercise 2.70
;;
;; The following eight-symbol
;; alphabet with associated relative frequencies was designed to efficiently
;; encode the lyrics of 1950s rock songs.  (Note that the “symbols” of an
;; “alphabet” need not be individual letters.)
;;
;; ```
;; A    2    NA  16
;; BOOM 1    SHA  3
;; GET  2    YIP  9
;; JOB  2    WAH  1
;; ```
;;
;; Use `generate-huffman-tree` ([Exercise 2.69](../chapter-2/exercise-2.69.rkt)) to generate a
;; corresponding Huffman tree, and use `encode` ([Exercise 2.68](../chapter-2/exercise-2.68.rkt)) to
;; encode the following message:
;;
;; ```
;; Get a job
;; Sha na na na na na na na na
;;
;; Get a job
;; Sha na na na na na na na na
;;
;; Wah yip yip yip yip
;; yip yip yip yip yip
;; Sha boom
;; ```
;;
;; How many bits are required for the encoding?  What is the smallest number of
;; bits that would be needed to encode this song if we used a fixed-length code
;; for the eight-symbol alphabet?

;; Test: raco test tests/chapter-2/exercise-2.70.test.rkt
;; Your exercises/chapter-2/exercise-2.70.rkt must (#%provide generate-huffman-tree encode decode)
;;   (generate-huffman-tree pairs) -- the Huffman tree for a list of (symbol frequency) pairs
;;   (encode message tree)         -- list of bits encoding a list of symbols with tree
;;   (decode bits tree)            -- list of symbols decoded from a list of bits with tree
;; Define these (with the Huffman tree representation and the code of Exercises 2.67-2.69)
;; in your file. The tests build the rock-song tree from the alphabet of the exercise,
;; encode the song, and check the number of bits (84) and that decoding gives the song back.

