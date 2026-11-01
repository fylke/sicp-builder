#lang sicp
;; Exercise 3.71
;;
;; Numbers that can be expressed as
;; the sum of two cubes in more than one way are sometimes called
;; *Ramanujan numbers*, in honor of the mathematician Srinivasa
;; Ramanujan.[^1] Ordered streams of pairs provide an elegant
;; solution to the problem of computing these numbers.  To find a number that can
;; be written as the sum of two cubes in two different ways, we need only generate
;; the stream of pairs of integers ${(i, j)}$ weighted according to the sum
;; ${i^3 + j^3}$ (see [Exercise 3.70](../chapter-3/exercise-3.70.rkt)), then search the stream for two
;; consecutive pairs with the same weight.  Write a procedure to generate the
;; Ramanujan numbers.  The first such number is 1,729.  What are the next five?
;;
;; [^1]: To quote from G. H. Hardy’s obituary of Ramanujan (Hardy 1921):
;; “It was Mr. Littlewood (I believe) who remarked that ‘every positive
;; integer was one of his friends.’  I remember once going to see him when he was
;; lying ill at Putney.  I had ridden in taxi-cab No. 1729, and remarked that the
;; number seemed to me a rather dull one, and that I hoped it was not an
;; unfavorable omen.  ‘No,’ he replied, ‘it is a very interesting number; it is
;; the smallest number expressible as the sum of two cubes in two different ways.’
;; ” The trick of using weighted pairs to generate the Ramanujan numbers was
;; shown to us by Charles Leiserson.

;; Test: raco test tests/chapter-3/exercise-3.71.test.rkt
;; Your exercises/chapter-3/exercise-3.71.rkt must (#%provide ramanujan-numbers)
;;   ramanujan-numbers -> stream of the numbers that can be written as the sum of two
;;   positive cubes in two different ways, in increasing order: 1729 4104 13832 ...
;; Define weighted-pairs etc. (Exercise 3.70) yourself in the file.

