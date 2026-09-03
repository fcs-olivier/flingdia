%%% LINE POINT POINT

%# `fromTo(L,P1,P2)`
%
% Line `L` runs from point `P1` to point `P2` exactly when its start
% coordinates equal `P1` and its end coordinates equal `P2`.
%
% ![`&fromTo`](../../assets/relations/fromTo_lpp.svg)
%
&sus{xstart(L,K)} = x(P1,K) :- true(&fromTo(L,P1,P2),K), rel_fromTo_lpp(L,P1,P2,K).
&sus{ystart(L,K)} = y(P1,K) :- true(&fromTo(L,P1,P2),K), rel_fromTo_lpp(L,P1,P2,K).
&sus{xend(L,K)} = x(P2,K)   :- true(&fromTo(L,P1,P2),K), rel_fromTo_lpp(L,P1,P2,K).
&sus{yend(L,K)} = y(P2,K)   :- true(&fromTo(L,P1,P2),K), rel_fromTo_lpp(L,P1,P2,K).

true(&fromTo(L,P1,P2),K) :- formula(spatial, &fromTo(L,P1,P2)),
                                 &sus{xstart(L,K)} = x(P1,K),
                                 &sus{ystart(L,K)} = y(P1,K),
                                 &sus{xend(L,K)} = x(P2,K),
                                 &sus{yend(L,K)} = y(P2,K),
                                 time(K), rel_fromTo_lpp(L,P1,P2,K).


