# Solving time depends on `PYTHONHASHSEED`

Rebuilt 2026-09-04 against the current tree (relations renamed to `&overlap` /
`&touches` / `&horizontal`, instance moved to `instances/TEMP/rush_hour.lp`).
Both code defects below are still present; the timings were remeasured, see
*Status* at the end for what changed.

## Symptom

`instances/TEMP/rush_hour.lp` with the "at most one vehicle moves per step"
constraint

```lp
:- &move(R1), &move(R2), rect(R1), rect(R2), R1 != R2.
```

runs for minutes without finishing under the default configuration, while the
same command with `-t 4 --configuration=trendy` answers in ~30s. On the tree of
2026-08-12 the plain command was a coin flip: six byte-identical runs gave one
SAT at 4.7s and five timeouts past 30s, and pinning `PYTHONHASHSEED` made each
outcome perfectly reproducible (seed 0 always fast, seed 1 always slow).

The runtime is not random. It is a deterministic function of the process' string
hash seed, because that seed decides the order in which two Python `set`s are
iterated while the program handed to clasp is built.

## What is *not* the bug

**Not an unsatisfiable horizon.** `min_moves_bfs.py` solves the puzzle outside
ASP: the shortest one-vehicle-per-step plan is **12 moves**, so `n <= 11` is
UNSAT and `n >= 12` is SAT. `n=12` is satisfiable and cheap once the solver takes
a good path (~30s, of which ~25s is grounding).

**Not the constraint being wrong.** The constraint does what it says. Its only
role is to raise the required horizon: without it vehicles move in parallel and a
plan exists at `n=6`. With it you need `n>=12`, which is where the instance
becomes hard enough for the search path to matter.

**Not the 8-way choice in `schemas/actions/move.lp` leaking diagonal moves.**
The instance only restricts `&move_right`/`&move_left` for horizontal vehicles,
so one may suspect that `{8 directions}=1 :- true(&move(O),I)` together with
`true(&move(O),I) :- true(&move_up_right(O),I)` lets a vehicle support a diagonal
move through the choice rule. It does not: `no_diagonal_check.lp` asks for a
diagonal or off-axis move and comes back UNSAT (re-verified today), so
foundedness holds and the direction restriction is effective.

## What *is* the bug

Two places in the pipeline iterate over Python `set`s whose elements hash by
string, and the iteration order decides the order in which rules and solver
variables are created. Since Python randomises string hashing per process
([PEP 456](https://peps.python.org/pep-0456/): SipHash keyed from
`PYTHONHASHSEED`, random unless the variable is set), each process emits a
different but logically equivalent program. Different numbering means different
initial heuristic scores in clasp, and this instance is close enough to the
solver's limit that the choice decides between seconds and forever.

### 1. `metasp`: order of the `formula/2` facts

`Formula.used_types` in `src/metasp/formula_processing.py`:

```python
@property
def used_types(self) -> List[str]:
    types = set([self.type.name] + (self.super_types or []))
    return list(types)
```

`MetaspExtension.additional_symbols` (`src/metasp/__init__.py`) iterates that
list to emit one `formula(<type>,<formula>)` fact per type, so for every formula
the `formula(st,F)` / `formula(spatial,F)` pair comes out in a hash-dependent
order. Two runs of the same instance produce `out/metasp_combined.lp` files that
differ only by such swapped pairs:

```
< formula(st,__eq(height(blue),1)).
< formula(symbol,1).
---
> formula(symbol,1).
> formula(st,__eq(height(blue),1)).
```

Reordering facts reorders rule instantiation downstream, hence the atom numbering
of everything derived from them.

### 2. `flingo`: order of `__def` literals and rules

`Translator.vars` in `flingo/translator.py` returns a `set` of `ConstraintTerm`,
and `ConstraintTerm.__hash__` is `hash(str(self))` — a plain string hash:

```python
def vars(self, term):
    ...
    return {term}          # unioned over subterms

def __hash__(self):
    return hash(str(self))
```

The translator walks those sets (`for var in self.vars(element.terms[0])`) while
creating definedness atoms, so the generated clingcon program changes shape per
process. `--print-translation` under two seeds differs in exactly this way:

```
< ... =: top(yellow, 1), __def(height(yellow,1)), __def(bottom(yellow,1)) .
---
> ... =: top(yellow, 1), __def(bottom(yellow,1)), __def(height(yellow,1)) .
```

This locus is independent of the first one: feeding flingo a *fixed*
`metasp_combined.lp` and varying only `PYTHONHASHSEED` already flips the runtime,
which is how the two were separated.

## Workaround

```bash
metasp solve flingo --meta-config config.yaml --warn=no-atom-undefined \
    instances/TEMP/rush_hour.lp 1 --project=show \
    -c n=12 -c xmax=6 -c ymax=6 -t 4 --configuration=trendy
```

The portfolio over 4 threads is the preferred form: it does not rely on one lucky
configuration. Verified today at seeds 0 and 1, 30.1s and 29.4s, against
timeouts past 150s without it.

Use the smallest satisfiable horizon (`n=12` here); idle steps only enlarge the
search space. Exporting `PYTHONHASHSEED=0` makes runs reproducible, which helps
when timing or bisecting, but it is not a fix — nothing says a given seed stays
good for another instance or another version of the semantics.

Do **not** try to fix this in the encoding. Packing all moves to the front

```lp
some_move :- &move(R), rect(R).
:- not some_move, &next(some_move).
```

is a correct symmetry break but only changes which seeds are lucky (measured on
the 2026-08-12 tree: seed 2 fast, seeds 0 and 1 still timing out at `n=15`).

## Suggested repair (upstream)

Make the two orders canonical instead of hash-dependent: return `sorted(types)`
from `used_types`, and iterate `Translator.vars` results in a deterministic order
(sort by `str`, or keep insertion order with a `dict`). That removes the
run-to-run variance. It does not make the instance easy — the sensitivity of the
default configuration remains, and that part is solver tuning, not a defect.

## Files

| File | Purpose |
|---|---|
| `rush_hour_one_mover.lp` | frozen copy of `instances/TEMP/rush_hour.lp` with the one-mover constraint enabled |
| `repro.sh` | repeats the solve, optionally with a fixed seed: `./repro.sh [seed]`, env `N` `TO` `REPS` `OPTS` |
| `min_moves_bfs.py` | solver-independent shortest plan (12 moves), fixes which horizons can be SAT |
| `no_diagonal_check.lp` | rules out the "diagonal moves leak through the choice rule" explanation (expects UNSAT) |

`repro.sh` uses the real `config.yaml` with `--printer none`, so no separate
config copy is needed any more, and it runs from `examples/flingdia` so generated
files still land in the usual `out/`.

## Measurements

Full `metasp solve` pipeline, 6x6 board, `n=12`, one machine. About 25s of every
number below is transform + reify + grounding, before any search.

| Configuration | seed 0 | seed 1 |
|---|---|---|
| default | TIMEOUT 150s | TIMEOUT 150s |
| `-t 4 --configuration=trendy` | SAT 30.1s | SAT 29.4s |

From the 2026-08-12 tree, when the semantics was smaller and the whole solve took
~7s (kept because this is where the seed dependence was actually demonstrated):

| Horizon | one-mover constraint | no constraint |
|---|---|---|
| `n=6` | UNSAT 4.2s | SAT 4.2s |
| `n=8` | TIMEOUT 60s (is UNSAT) | SAT 4.7s |
| `n=10` | not measured (is UNSAT) | SAT 5.3s |
| `n=11` | UNSAT 6.4s with the workaround | not measured |
| `n=12` | TIMEOUT 60s, SAT 3.8s with `trendy` | TIMEOUT 120s, SAT 3.6s with `trendy` |
| `n=15` | SAT 7.2s at seed 0, TIMEOUT 40s at seed 1 | TIMEOUT 200s |

At `n=12` the same fragility also shows through a second knob: `trendy`, `handy`,
`jumpy` and `crafty` all answered in 3.6–4.5s where the default `tweety` and
`frumpy` did not finish.

`n=8` with the constraint is genuinely UNSAT (12 moves are needed) but the default
configuration does not finish the proof, so a wrong horizon looks the same as
this bug from the outside. Check `min_moves_bfs.py` first.

## Status (2026-09-04)

Both defects are unchanged in the source: `used_types` is still
`list(set(...))`, and `ConstraintTerm.__hash__` is still `hash(str(self))`.

What changed is the difficulty. The semantics grew several schema files, so
grounding alone now costs ~25s and the search is harder: at `n=12` the default
configuration times out past 150s at *both* seed 0 and seed 1, where seed 0 used
to be the lucky one. The seed flip is therefore no longer directly visible in
these two samples — the instance is now on the wrong side of the cliff for both.
I did not sweep further seeds to re-exhibit it, to keep the run budget small. To
try:

```bash
for s in {0..9}; do N=12 TO=200 REPS=1 ./repro.sh $s; done
```

A cheaper sweep is possible on the flingo-only loop
(`python3 -m flingo out/metasp_combined.lp out/syntax_facts.lp 1 -c n=12 ...`),
which skips the ~25s of transform and grounding per run.
