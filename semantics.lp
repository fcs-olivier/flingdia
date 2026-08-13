%# Semantics
%
% Interpretation of the `st` theory atoms declared in `syntax.lp` over a linear
% sequence of time steps, together with the default space and time limits.

#include "metasp.meta-time.lp".
#include "metasp.show-time.lp".
#include "metasp.reify-defined.lp".
#include "metasp.reify-defined-metasp.lp".

%*! true(S,K)

Holds when the formula or atom `S` is satisfied at time step `K`.

This is the central predicate of the semantics: every temporal connective and every
spatial relation is evaluated into `true/2`.

Args:
    - S: a formula, a spatial atom or an ordinary atom
    - K: the time step
*%

%*! formula(T,S)

Declares that `S` is a formula of type `T`, as reified from the input program.

Only formulas that actually occur in the input are reified, so `formula/2` guards the
rules below and keeps the grounding restricted to the vocabulary in use.

Args:
    - T: the theory type, `st`, `spatial` or `atom`
    - S: the formula
*%

%*! time(K)

Holds for each time step `K` of the trace, from `0` to the horizon.

Args:
    - K: the time step
*%

%*! until_witness(F,G,I,K)

Chooses the future step `K` at which `G` is required to hold for `&until(F,G)` to be
satisfied at `I`.

Args:
    - F: the formula that must hold in between
    - G: the formula that must eventually hold
    - I: the step at which the until formula is evaluated
    - K: the witnessing step
*%

%## Show
%
% Project onto Boolean configurations (relations and ordinary atoms) rather than
% coordinate witnesses. Showing `val/2` is deliberately avoided, as it re-expands every
% `&in` assignment. `show-time.lp` only auto-shows `formula(atom,...)`, so spatial atoms
% need an explicit show.
%%#show true/1.
%%#show val/2.
#show true(S,T) : true(S,T), formula(spatial,S).
#show true(S,T) : true(S,T), formula(atom,S).
#show invalid_relation_arg/1.
%%&show{}.

%## Default space and time limits
%
% Providing any of these constants as an argument overrides the default value below. In
% either case the space limits are available as constants in the input file.
#const xmin = 0. #const xmax = 10.
#const ymin = 0. #const ymax = 10.
#const zmin = 0. #const zmax = 10.

#const n = 0.

%## Temporal logic

%### `&true`
true(&true,I) :- formula(st,&true), time(I).

%### `&initial`
true(&initial,0) :- formula(st,&initial).
:- formula(st,&initial), true(&initial,I), I!=0.

%### `&next`
true(F,I+1) : time(I+1) :- formula(st,&next(F)), true(&next(F),I).
true(&next(F),I) :- formula(st,&next(F)), true(F,I+1), time(I).

%### `&prev`
true(F,I-1) : time(I-1) :- formula(st,&prev(F)), true(&prev(F),I).
true(&prev(F),I) :- formula(st,&prev(F)), true(F,I-1), time(I).

%### `&eventually`
true(F,J) : time(J), I<=J :- true(&eventually(F),I).
true(&eventually(F),I) :- formula(st,&eventually(F)), true(F,J), I<=J, time(I), time(J).

%### `&not`
true(&not(F),I) :- formula(st,&not(F)), not true(F,I), time(I).
:- true(&not(F),I), true(F,I), time(I).

%### `&always`
%
%!!! warning "Unverified definition"
%
%    This is my definition, not double checked by anyone else.
true(F,J) :- true(&always(F),I), time(J), I <= J.
true(&always(F),I) :- formula(st,&always(F)), time(I), true(F,J) : time(J), I <= J.

%### `&until`
%
%!!! warning "Unverified definition"
%
%    This is my definition, not double checked by anyone else.
%
% Without the final constraint below, `G` can be true before the `G` that is considered
% to satisfy the until condition: an arbitrary future witness `J` is selected, without
% requiring `G` to be false before `J`. The constraint forbids choosing a witness `J`
% whenever `G` was already true at some earlier `I` with `K<=I<J`.
%
% Standard until semantics does not require the earliest witness, so this constraint is
% optional and stronger than necessary. Standard encodings only require some witness `J`
% where `G` holds; forcing the earliest such `J` is an additional canonicalisation or
% optimisation choice, not part of ordinary until semantics.
true(&until(F,G),I) :- formula(st,&until(F,G)), time(I), time(K), I <= K, true(G,K), true(F,J) : time(J), I <= J < K.

until_witness(F,G,I,K) : time(K), I <= K :- formula(st,&until(F,G)), true(&until(F,G),I), time(I).
true(G,K) :- until_witness(F,G,I,K).
true(F,J) :- until_witness(F,G,I,K), time(J), I <= J < K.

:- until_witness(F,G,I,K), true(G,J), time(J), I <= J < K.

%## Example invocation
%
%```bash
%metasp solve flingo --meta-config config.yaml \
%                    --warn=no-atom-undefined \
%                    input.lp  0 \
%                    -c display_time=7  \
%                    --project=show \
%                    -c n=2 \
%                    -c xmin=0 \
%                    -c xmax=15 \
%                    -c ymin=0 \
%                    -c ymax=10
%```
