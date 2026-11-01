# Exercise 4.6

`Let` expressions are derived
expressions, because

```scheme
(let ((⟨var₁⟩ ⟨exp₁⟩) … (⟨varₙ⟩ ⟨expₙ⟩))
  ⟨body⟩)
```

is equivalent to

```scheme
((lambda (⟨var₁⟩ … ⟨varₙ⟩)
   ⟨body⟩)
 ⟨exp₁⟩
 …
 ⟨expₙ⟩)
```

Implement a syntactic transformation `let->combination` that reduces
evaluating `let` expressions to evaluating combinations of the type shown
above, and add the appropriate clause to `eval` to handle `let`
expressions.
