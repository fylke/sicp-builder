# Exercise 2.34

Evaluating a polynomial in $x$
at a given value of $x$ can be formulated as an accumulation.  We evaluate
the polynomial

$$
  {a_n x^n} + {a_{n-1} x^{n-1}} + \dots + {a_1 x} + a_0
$$

using a well-known algorithm called *Horner’s rule*, which structures
the computation as

$$
  {(\dots (a_n x} + {a_{n-1}) x} + \dots + {a_1) x} + {a_0.}
$$

In other words, we start with $a_n$, multiply by $x$, add
$a_{n-1}$, multiply by $x$, and so on, until we reach
$a_0$.[^1]

Fill in the following template to produce a procedure that evaluates a
polynomial using Horner’s rule.  Assume that the coefficients of the polynomial
are arranged in a sequence, from $a_0$ through $a_n$.

```scheme
(define 
  (horner-eval x coefficient-sequence)
  (accumulate 
   (lambda (this-coeff higher-terms)
     ⟨??⟩)
   0
   coefficient-sequence))
```

For example, to compute ${1 + 3x} + {5x^3 + x^5}$ at ${x = 2}$ you
would evaluate

```scheme
(horner-eval 2 (list 1 3 0 5 0 1))
```

[^1]: According to Knuth 1981, this rule was formulated by
W. G. Horner early in the nineteenth century, but the method was actually used
by Newton over a hundred years earlier.  Horner’s rule evaluates the polynomial
using fewer additions and multiplications than does the straightforward method
of first computing ${a_n x^n}$, then adding
${a_{n-1}x^{n-1}}$, and so on.  In fact, it is possible to prove
that any algorithm for evaluating arbitrary polynomials must use at least as
many additions and multiplications as does Horner’s rule, and thus Horner’s
rule is an optimal algorithm for polynomial evaluation.  This was proved (for
the number of additions) by A. M. Ostrowski in a 1954 paper that essentially
founded the modern study of optimal algorithms.  The analogous statement for
multiplications was proved by V. Y. Pan in 1966.  The book by Borodin and Munro (1975) 
provides an overview of these and other results about optimal
algorithms.
