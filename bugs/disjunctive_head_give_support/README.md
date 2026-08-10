# Objects teleport without a `&move` action

## Symptom

In `instances/ST/fox_goose_beans.lp` the banks (which have no `&move` action)
jump to new positions at the last state(s), where warping a bank is cheaper
than a proper last boat trip. Minimal reproduction: `teleport_without_move.lp`
(2 rects, no `&move` at all, `&inertia` on, everything pinned at `&initial`) —
`b` teleports in one step.

CLI in the .lp file

Expected UNSATISFIABLE, actual SATISFIABLE with `b`: `left_side` 0 -> 7.

## Cause

It is not a flingo foundedness violation; the schema itself provides founded
support for changed values:

1. Relations use a case-selection choice, e.g. in `rect_rect_TOPO.lp`:

   `1{c1_disconnected_rr(..); c2_..; c3_..; c4_..} :- true(&disconnected_rr(R1,R2),K).`

   and each case fires *head* occurrences of `&sus`, e.g.
   `&sus{right_side(R1,K)}<left_side(R2,K) :- c3_disconnected_rr(R1,R2,K).`

2. Per the flingo translation, a head constraint atom founds `&df(x)` for
   **all** its variables, while only imposing the inequality — the value stays
   free within it.

3. The choice is not tied to the case that *witnesses* the relation. Here
   `true(&disconnected_rr(a,b),K)` is derived through the vertical case
   (founded by inertia, since bottoms/tops persist), but the choice may
   additionally select the horizontal case `c3`, whose head atom founds
   `left_side(b,1)` non-cyclically at any value with `right_side(a,1) < left_side(b,1)`.

4. Inertia in `axioms.lp` is only a default
   (`... not &sus{v(K)}!=v(K1) ...`): once a different value is founded
   elsewhere, the rule is silently switched off.

Control experiment: if `b` is only *horizontally* separated from `a` (so DC is
witnessable only through the variable that would have to change), the support
is cyclic and the instance is correctly UNSATISFIABLE.

## Possible fix

Hard frame constraint for rects without a move action, e.g.:

```
:- true(rect(R),K), K1=K+1, time(K1), not true(&move(R),K),
   &sus{left_side(R,K)}!=left_side(R,K1).
```

(likewise for `bottom`, `width`, `height`, and for point/line parameters).
