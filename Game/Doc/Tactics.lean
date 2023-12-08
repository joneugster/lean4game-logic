import GameServer.Commands

TacticDoc exact "
# Summary
The `exact` tactic is a means through which you give the game your answer. Many levels can be done in multiple steps. You'll use the `have` tactic when you're ready to create the final expression. It will be evaluated to see weather it matches the goal.

`exact` will work with any expression and attempt to unify it with the current goal. The simplest such expression is just a name that — `:` — \"is evidence for\" the goal. More complicated expressions often make use of unlocked definitions and theorems as well as function abstraction and application.

# Errors
Because most of the starting levels use only the `exact` tactic and an expression, it's common to forget to specify the tactic. Sometimes this raises the error:
```
unknown tactic
```
and other times the much more ambiguous message:
```
no goals left
This probably means you solved the level with warnings or Lean encountered a parsing error.
```
Hopefully we'll have better error messages in the future ☺

### Example
```
Objects:
P : Prop
Assumptions:
h : P
Goal:
P
```
----
```
exact h
```

### Example
```
Objects:
P Q: Prop
Assumptions:
h : (P → Q) ∧ ¬Q
Goal:
¬P
```
----
```
exact λp ↦ and_right h (and_left h p)
```
"

TacticDoc «have» "
## Summary
`have` is used to add new assumptions to your proof state.

`have h : P := e` adds the assumption `h : P` to the current proof state if `e` is an expression that evaluates to evidence for `P`.

If `P` is omitted, the game will attempt to infer the proposition. Most tutorial worlds will introduce alternative expressions as a shorthand where you can omit parts of the expression if the proposition being introduced can be inferred.

`and_intro e₁ e₂`, and `iff_intro e₁ e₂` can both be written as `⟨e₁, e₂⟩` as long as the context makes the proposition being constructed clear. This will often mean using the long hand or including the `P` when using the `have` tactic.
```
-- Should h be inferred as P ∧ Q or P ↔ Q?
-- To be unambiguous
exact h := ⟨e₁, e₂⟩
-- must become
exact h : P ∧ Q := ⟨e₁, e₂⟩
-- or perhaps
exact h := (⟨e₁, e₂⟩ : P ∧ Q)
```

### Example
```
Objects:
P Q: Prop
Assumptions:
h : (P → Q) ∧ ¬Q
Goal:
¬P
```
---
```
have hpq := h.left
```
creates the new proof state where hpq is an assumption
```
Objects:
P Q: Prop
Assumptions:
h : (P → Q) ∧ ¬Q
hpq : P → Q
Goal:
¬P
```
"