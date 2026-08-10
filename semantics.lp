#include "metasp.meta-time.lp".
#include "metasp.show-time.lp".
#include "metasp.reify-defined.lp".
#include "metasp.reify-defined-metasp.lp".


%%%%%%%%%%%%%% SHOW %%%%%%%%%%%%%
%#show true/1.
%#show val/2.
% Project onto Boolean configurations (relations + ordinary atoms), not
% coordinate witnesses. Do not #show val/2 — that re-expands every &in assignment.
% show-time.lp only auto-shows formula(atom,…); spatial atoms need an explicit show.
#show true(S,T) : true(S,T), formula(spatial,S).
#show true(S,T) : true(S,T), formula(atom,S).
#show invalid_relation_arg/1.
%&show{}.


%%%%%%%%%  default SPACE and TIME LIMITS  %%%%%%%%%%%%%
% if any of these constants are provided as an argument, they will override these default values
% space limits are available as constants in the input file in either case
#const xmin = 0. #const xmax = 10.
#const ymin = 0. #const ymax = 10.
#const zmin = 0. #const zmax = 10.

#const n = 0.


%%%%%%%%%%%%%%%%%%%%%%%%%%% TEMPORAL LOGIC %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
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


%### `&always(F)`  NOTE FRAN: this is mt definition, not double checked by anyone else. 
true(F,J) :- true(&always(F),I), time(J), I <= J.
true(&always(F),I) :- formula(st,&always(F)), time(I), true(F,J) : time(J), I <= J.

%### `&until(F,G)' NOTE FRAN: this is mt definition, not double checked by anyone else. 
true(&until(F,G),I) :- formula(st,&until(F,G)), time(I), time(K), I <= K, true(G,K), true(F,J) : time(J), I <= J < K.

until_witness(F,G,I,K) : time(K), I <= K :- formula(st,&until(F,G)), true(&until(F,G),I), time(I).
true(G,K) :- until_witness(F,G,I,K).
true(F,J) :- until_witness(F,G,I,K), time(J), I <= J < K.


% without the rule below: G can be true before the G that is considered to satisfy the until condition. 
% Indeed, we select an arbitrary future witness J, and not require G to be false before J. 
% if we want that the G must be false everytime before J, add this constraint. 
:- until_witness(F,G,I,K), true(G,J), time(J), I <= J < K.
% It forbids choosing witness J whenever G was already true at some earlier I with K≤I<J.
% But standard until semantics does not require the earliest witness, so this constraint ``
% is optional and stronger than necessary.
% Standard encodings only require some witness J where G holds. Forcing the earliest such J 
% is an additional canonicalisation or optimisation choice, not part of ordinary until semantics.






%*
metasp solve flingo --meta-config config.yaml \
                    --warn=no-atom-undefined \
                    input.lp  0 \
                    -c display_time=7  \
                    --project=show \
                    -c n=2 \
                    -c xmin=0 \
                    -c xmax=15 \
                    -c ymin=0 \
                    -c ymax=10 
*%
