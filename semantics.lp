#include "metasp.meta-time.lp".
#include "metasp.show-time.lp".
#include "metasp.reify-defined.lp".
#include "metasp.reify-defined-metasp.lp".

%%#show true/1.
%%#show val/2.
#show true(S,T) : true(S,T), formula(spatial,S).
#show true(S,T) : true(S,T), formula(atom,S).
#show invalid_relation_arg/1.
%%&show{}.

#const xmin = 0. #const xmax = 10.
#const ymin = 0. #const ymax = 10.
#const zmin = 0. #const zmax = 10.

#const n = 0.

true(&true,I) :- formula(st,&true), time(I).

true(&initial,0) :- formula(st,&initial).
:- formula(st,&initial), true(&initial,I), I!=0.

true(F,I+1) : time(I+1) :- formula(st,&next(F)), true(&next(F),I).
true(&next(F),I) :- formula(st,&next(F)), true(F,I+1), time(I).

true(F,I-1) : time(I-1) :- formula(st,&prev(F)), true(&prev(F),I).
true(&prev(F),I) :- formula(st,&prev(F)), true(F,I-1), time(I).

true(F,J) : time(J), I<=J :- true(&eventually(F),I).
true(&eventually(F),I) :- formula(st,&eventually(F)), true(F,J), I<=J, time(I), time(J).

true(&not(F),I) :- formula(st,&not(F)), not true(F,I), time(I).
:- true(&not(F),I), true(F,I), time(I).

true(F,J) :- true(&always(F),I), time(J), I <= J.
true(&always(F),I) :- formula(st,&always(F)), time(I), true(F,J) : time(J), I <= J.

true(&until(F,G),I) :- formula(st,&until(F,G)), time(I), time(K), I <= K, true(G,K), true(F,J) : time(J), I <= J < K.

until_witness(F,G,I,K) : time(K), I <= K :- formula(st,&until(F,G)), true(&until(F,G),I), time(I).
true(G,K) :- until_witness(F,G,I,K).
true(F,J) :- until_witness(F,G,I,K), time(J), I <= J < K.

:- until_witness(F,G,I,K), true(G,J), time(J), I <= J < K.

