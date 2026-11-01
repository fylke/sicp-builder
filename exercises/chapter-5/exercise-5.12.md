# Exercise 5.12

The simulator can be used to help
determine the data paths required for implementing a machine with a given
controller.  Extend the assembler to store the following information in the
machine model:

- a list of all instructions, with duplicates removed, sorted by instruction type
(`assign`, `goto`, and so on);

- a list (without duplicates) of the registers used to hold entry points (these
are the registers referenced by `goto` instructions);

- a list (without duplicates) of the registers that are `save`d
or `restore`d;

- for each register, a list (without duplicates) of the sources from which it is
assigned (for example, the sources for register `val` in the factorial
machine of Figure 5.11 are `(const 1)` and `((op *) (reg n)
(reg val))`).

Extend the message-passing interface to the machine to provide access to this
new information.  To test your analyzer, define the Fibonacci machine from
Figure 5.12 and examine the lists you constructed.

**Figure 5.12:** $\downarrow$ Controller for a machine to compute
Fibonacci numbers.

```scheme
(controller
   (assign continue (label fib-done))
 fib-loop
   (test (op <) (reg n) (const 2))
   (branch (label immediate-answer))
   ;; set up to compute Fib(n − 1)
   (save continue)
   (assign continue (label afterfib-n-1))
   (save n)           ; save old value of n
   (assign n 
           (op -)
           (reg n)
           (const 1)) ; clobber n to n-1
   (goto 
    (label fib-loop)) ; perform recursive call
 afterfib-n-1 ; upon return
   (restore n)
   (restore continue)
   ;; set up to compute Fib(n − 2)
   (assign n (op -) (reg n) (const 2))
   (save continue)
   (assign continue (label afterfib-n-2))
   (save val)         ; save Fib(n − 1)
   (goto (label fib-loop))
 afterfib-n-2 ; upon return
   (assign n 
           (reg val)) ; n now contains Fib(n − 2)
   (restore val)      ; val now contains Fib(n − 1)
   (restore continue)
   (assign val        ; Fib(n − 1) + Fib(n − 2)
           (op +) 
           (reg val)
           (reg n))
   (goto              ; return to caller
    (reg continue))   ; answer is in val
 immediate-answer
   (assign val 
           (reg n))   ; base case: Fib(n) = n
   (goto (reg continue))
 fib-done)
```
