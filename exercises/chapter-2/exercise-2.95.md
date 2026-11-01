# Exercise 2.95

Define $P_1$, $P_2$, and
$P_3$ to be the polynomials

$$
\begin{array}{rl}
  P_1:  &   x^2 - 2x + 1, \\
  P_2:  &   11x^2 + 7,    \\
  P_3:  &   13x + 5.
\end{array}
$$

Now define $Q_1$ to be the product of $P_1$ and $P_2$, and $Q_2$ to be
the product of $P_1$ and $P_3$, and use `greatest-common-divisor`
([Exercise 2.94](../chapter-2/exercise-2.94.md)) to compute the GCD of $Q_1$ and $Q_2$.
Note that the answer is not the same as $P_1$.  This example introduces
noninteger operations into the computation, causing difficulties with the
GCD algorithm.[^1]  To understand what is happening, try tracing
`gcd-terms` while computing the GCD or try performing the
division by hand.

[^1]: In an implementation like MIT
Scheme, this produces a polynomial that is indeed a divisor of $Q_1$ and
$Q_2$, but with rational coefficients.  In many other Scheme systems, in
which division of integers can produce limited-precision decimal numbers, we
may fail to get a valid divisor.
