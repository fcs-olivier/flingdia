# Guard-free constraint bodies silently dropped

## Symptom

Minimal instance `silently_dropped_constraint.lp`: two points placed with
`x(a) < x(b)`, plus the constraint

```lp
:- &left_pp(a,b).
```

CLI in the .lp file.

Expected UNSATISFIABLE (the geometry makes `&left_pp(a,b)` true).
Actual SATISFIABLE — the constraint never reaches the solver.
Grounding also warns `atom does not occur in any rule head: a` / `b`.

## What is *not* the bug

The schema rule in `out/metasp_combined.lp` is :

```lp
true(__left_pp(P1,P2),K) :- formula(spatial, __left_pp(P1,P2)), P1!=P2,
                            &sus{x(P1,K)} < x(P2,K), time(K).
```

Relations are only evaluated for formulas that were **registered** from the
instance. That gating is by design, not a flaw in the semantics.

So if `formula(spatial, __left_pp(a,b))` is absent from the reified input, this
rule correctly does not fire — even when `&eq` has already founded
`x(a) < x(b)`.

## What *is* the bug

You *did* write `&left_pp(a,b)` in the source. That occurrence should register
`formula(spatial, __left_pp(a,b))`. Instead the metasp transform emits an
`#external` guarded by the relation’s own arguments `a` and `b` as propositional atoms:

```
#external &left_pp(a,b): b, a.
```

(`metasp transform …` on the instance shows this.)

`a` and `b` never appear in a rule head — only as arguments of `point(a)`,
`point(b)`. So the external is never enabled, the formula never appears under
`%%%%%%%%%% REIFIED INPUT %%%%%%%%%%%%` in `out/metasp_combined.lp`, and the
constraint is vacuous.

In short: the schema waits for a registered formula; the transform fails to
register a formula that is literally present in a guard-free constraint body.

## `&eq` does not register `&left_pp`

Pinning coordinates is a live assertion of **`&eq`**, not of `&left_pp`:

```lp
&eq(x(a),0). &eq(y(a),0).
&eq(x(b),1). &eq(y(b),0).
:- &left_pp(a,b).
```

In the reified input you will see `formula(spatial, __eq(...))`, but not
`formula(spatial, __left_pp(a,b))`. The eqs found values that *would* make
left-of true; without a registered `&left_pp` formula, the schema never checks
them → SAT.

## Head occurrence is different

```lp
&left_pp(a,b) :- &initial.
```

is handled on another path: the transform registers
`formula(spatial, &left_pp(a,b))` and emits unguarded `#external a.` /
`#external b.` (leaf operands of the head). The rule also **derives**
`true(&left_pp(a,b))` at the initial state.

So if the program contains both

```lp
&left_pp(a,b) :- &initial.
:- &left_pp(a,b).
```

you assert the relation and forbid it → UNSAT. That is an ordinary
contradiction once the formula is live, not the body-only constraint “starting
to work” by magic.

| Program | Result |
|---|---|
| `:- &left_pp(a,b).` only (plus eqs) | SAT (bug: formula never registered) |
| `&left_pp(a,b) :- &initial.` only | SAT (asserts; coords can satisfy it) |
| both | UNSAT (assert ∧ forbid) |

## What does *not* trigger the bug

The trigger is a **positive, guard-free** body made only of theory atoms.
Forms with `not` plus a separate guard are fine, e.g.:

```lp
:- not &left_pp(a,b), &initial.
```

Here the relation sits under `not` (so it is not used as a safe positive guard
source), and `&initial` has no term arguments that could become failing guards.
Transform emits an unguarded `#external &left_pp(a,b).`, the formula is
registered, and the constraint fires.

## Workaround

Force registration via nested `&not`:

```lp
:- not &not(&left_pp(a,b)).
```

Alternatively, make the arguments head-true propositional atoms (e.g. facts
`a.` `b.`) so the external guards succeed — but that couples object identity to
ASP atoms in a way the schema does not otherwise require.
