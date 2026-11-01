#lang sicp
;; Exercise 2.37
;;
;; Suppose we represent vectors **v** = ${(v_i)}$ as sequences of numbers, and
;; matrices **m** = ${(m_{ij})}$ as sequences of vectors (the rows of the
;; matrix).  For example, the matrix
;;
;; $$
;; \left(\matrix{	1 & 2 & 3 & 4 \cr
;; 		4 & 5 & 6 & 6 \cr
;; 		6 & 7 & 8 & 9 \cr }\right)
;; $$
;;
;; is represented as the sequence `((1 2 3 4) (4 5 6 6) (6 7 8 9))`.  With
;; this representation, we can use sequence operations to concisely express the
;; basic matrix and vector operations.  These operations (which are described in
;; any book on matrix algebra) are the following:
;;
;; $$
;; \eqalign{
;; 	\text{(dot-product v w)} 	& \text{returns the sum}\;\Sigma_i v_i w_i; \cr
;; 	\text{(matrix-*-vector m v)} 	& \text{returns the vector}\;{\bf t}, \cr
;; 		& \text{where}\; t_i = \Sigma_j m_{ij} v_j; \cr
;; 	\text{(matrix-*-matrix m n)} 	& \text{returns the matrix}\;{\bf p}, \cr
;; 		& \text{where}\; p_{ij} = \Sigma_k m_{ik} n_{kj}; \cr
;; 	\text{(transpose m)} 		& \text{returns the matrix}\;{\bf n}, \cr
;; 		& \text{where}\; n_{ij} = m_{ji}. \cr
;; }
;; $$
;;
;; We can define the dot product as[^1]
;;
;; ```scheme
;; (define (dot-product v w)
;;   (accumulate + 0 (map * v w)))
;; ```
;;
;; Fill in the missing expressions in the following procedures for computing the
;; other matrix operations.  (The procedure `accumulate-n` is defined in
;; [Exercise 2.36](../chapter-2/exercise-2.36.rkt).)
;;
;; ```scheme
;; (define (matrix-*-vector m v)
;;   (map ⟨??⟩ m))
;;
;; (define (transpose mat)
;;   (accumulate-n ⟨??⟩ ⟨??⟩ mat))
;;
;; (define (matrix-*-matrix m n)
;;   (let ((cols (transpose n)))
;;     (map ⟨??⟩ m)))
;; ```
;;
;; [^1]: This definition uses the extended
;; version of `map` described in Footnote 78.

;; Test: raco test tests/chapter-2/exercise-2.37.test.rkt
;; Your exercises/chapter-2/exercise-2.37.rkt must (#%provide dot-product matrix-*-vector
;;                                                  transpose matrix-*-matrix)
;;   (dot-product v w)       -- sum of v_i * w_i
;;   (matrix-*-vector m v)   -- the vector t with t_i = sum_j m_ij v_j
;;   (transpose m)           -- the matrix n with n_ij = m_ji
;;   (matrix-*-matrix m n)   -- the matrix product
;; Matrices are lists of rows (lists). You must define accumulate and accumulate-n yourself;
;; they are not tested here.

