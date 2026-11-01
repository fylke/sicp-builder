#lang sicp
;; Exercise 3.59
;;
;; In 2.5.3 we saw how
;; to implement a polynomial arithmetic system representing polynomials as lists
;; of terms.  In a similar way, we can work with *power series*, such as
;;
;; $$
;; \begin{aligned}
;;   e^x 	  &= 1 + x + \frac{1}{2} x^2  + \frac{1}{3 \cdot 2} x^3  + \frac{1}{4 \cdot 3 \cdot 2} x^4  + \dots, \\
;;   \cos x  &= 1 - \frac{1}{2} x^2  + \frac{1}{4 \cdot 3 \cdot 2} x^4  - \dots, \\
;;   \sin x  &= x - \frac{1}{3 \cdot 2} x^3  + \frac{1}{5 \cdot 4 \cdot 3 \cdot 2} x^5  - \dots
;; \end{aligned}
;; $$
;;
;; represented as infinite streams.  We will represent the series ${a_0 + a_1 x} + {a_2 x^2} + {a_3 x^3 + \dots}$ as the stream whose
;; elements are the coefficients $a_0$, $a_1$, $a_2$, $a_3$, ….
;;
;; - (a) The integral of the series ${a_0 + a_1 x} + {a_2 x^2} + {a_3 x^3 + \dots}$ is the series
;;
;;       $$
;;         c + {a_0 x} + {\frac{1}{2} a_1 x^2} + {\frac{1}{3} a_2 x^3} + {\frac{1}{4} a_3 x^4 + \dots,}
;;       $$
;;
;;       where $c$ is any constant.  Define a procedure `integrate-series` that
;; takes as input a stream $a_0$, $a_1$, $a_2$, … representing a power
;; series and returns the stream $a_0$, ${{1\over2}a_1}$, ${{1\over3}a_2}$, … of
;; coefficients of the non-constant terms of the integral of the series.  (Since
;; the result has no constant term, it doesn’t represent a power series; when we
;; use `integrate-series`, we will `cons` on the appropriate constant.)
;;
;; - (b) The function ${x \mapsto e^x}$ is its own derivative.  This implies that
;; $e^x$ and the integral of $e^x$ are the same series, except for the
;; constant term, which is ${e^0 = 1}$.  Accordingly, we can generate the series
;; for $e^x$ as
;;
;;       ```scheme
;;       (define exp-series
;;         (cons-stream
;;          1 (integrate-series exp-series)))
;;       ```
;;
;;       Show how to generate the series for sine and cosine, starting from the facts
;; that the derivative of sine is cosine and the derivative of cosine is the
;; negative of sine:
;;
;;       ```scheme
;;       (define cosine-series
;;         (cons-stream 1 ⟨??⟩))
;;
;;       (define sine-series
;;         (cons-stream 0 ⟨??⟩))
;;       ```

;; Test: raco test tests/chapter-3/exercise-3.59.test.rkt
;; Your exercises/chapter-3/exercise-3.59.rkt must
;;   (#%provide integrate-series exp-series cosine-series sine-series)
;;   (integrate-series s) -> the stream a0, a1/2, a2/3, ... (coefficients of the integral
;;                           without its constant term)
;;   exp-series, cosine-series, sine-series -> coefficient streams of e^x, cos x, sin x
;; Define stream-map, integers, scale-stream etc. yourself in the file.

