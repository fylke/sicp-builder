#lang sicp
;; Exercise 3.80
;;
;; A *series RLC circuit*
;; consists of a resistor, a capacitor, and an inductor connected in series, as
;; shown in Figure 3.36.  If $R$, $L$, and $C$ are the resistance,
;; inductance, and capacitance, then the relations between voltage ${(v)}$ and
;; current ${(i)}$ for the three components are described by the equations
;;
;; $$
;; \begin{aligned}
;;   v_R 	&=   i_R R, \\
;;   v_L 	&=   L\,{di_L \over dt}, \\
;;   i_C 	&=   C\,{dv_C \over dt},
;; \end{aligned}
;; $$
;;
;; and the circuit connections dictate the relations
;;
;; $$
;; \begin{aligned}
;;   i_R 	&=   i_L = -i_C, \\
;;   v_C 	&=   v_L + v_R.
;; \end{aligned}
;; $$
;;
;; Combining these equations shows that the state of the circuit (summarized by
;; $v_C$, the voltage across the capacitor, and $i_L$, the current in
;; the inductor) is described by the pair of differential equations
;;
;; $$
;; \begin{aligned}
;;   {dv_C \over dt}   &=   -{i_L \over C}\,, \\
;;   {di_L \over dt}   &=    {1 \over L}\, v_C - {R \over L}\, i_L.
;; \end{aligned}
;; $$
;;
;; The signal-flow diagram representing this system of differential equations is
;; shown in Figure 3.37.

;; Test: raco test tests/chapter-3/exercise-3.80.test.rkt
;; Your exercises/chapter-3/exercise-3.80.rkt must (#%provide RLC)
;;   (RLC R L C dt) -> a procedure (lambda (vc0 il0) ...) which returns (cons vc il), the pair
;;   of streams of capacitor voltage and inductor current for the series RLC circuit
;;     dvc/dt = -il/C,   dil/dt = vc/L - (R/L) il
;;   with initial values vc0 and il0. Element k is the explicit-Euler value
;;   (v_(k+1) = v_k + dt * dv_k, i_(k+1) = i_k + dt * di_k).
;; Define integral and the stream helpers yourself in the file.

