# Exercise 5.42

Using `find-variable` from
[Exercise 5.41](../chapter-5/exercise-5.41.md), rewrite `compile-variable` and
`compile-assignment` to output lexical-address instructions.  In cases
where `find-variable` returns `not-found` (that is, where the
variable is not in the compile-time environment), you should have the code
generators use the evaluator operations, as before, to search for the binding.
(The only place a variable that is not found at compile time can be is in the
global environment, which is part of the run-time environment but is not part
of the compile-time environment.[^1]  Thus, if you wish, you may have the evaluator operations look
directly in the global environment, which can be obtained with the operation
`(op get-global-environment)`, instead of having them search the whole
run-time environment found in `env`.)  Test the modified compiler on a few
simple cases, such as the nested `lambda` combination at the beginning of
this section.

[^1]: Lexical addresses cannot be used to
access variables in the global environment, because these names can be defined
and redefined interactively at any time.  With internal definitions scanned
out, as in [Exercise 5.43](../chapter-5/exercise-5.43.md), the only definitions the compiler sees are
those at top level, which act on the global environment.  Compilation of a
definition does not cause the defined name to be entered in the compile-time
environment.
