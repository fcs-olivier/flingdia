%%% POINT POINT

%# `left(P1,P2)`
%
% Point `P1` is strictly to the left of point `P2`.
%
% ![`&left`](../../assets/relations/left_pp.svg)
%
&sus{x(P1,K)} < x(P2,K) :- true(&left(P1,P2),K), rel_left_pp(P1,P2,K).
                 
true(&left(P1,P2),K) :- formula(spatial, &left(P1,P2)), 
                           P1!=P2, &sus{x(P1,K)} < x(P2,K), 
                           time(K), rel_left_pp(P1,P2,K).

%# `right(P1,P2)`
%
% Point `P1` is strictly to the right of point `P2`.
%
% ![`&right`](../../assets/relations/right_pp.svg)
%
&sus{x(P1,K)} > x(P2,K) :- true(&right(P1,P2),K), rel_right_pp(P1,P2,K).

true(&right(P1,P2),K) :- formula(spatial, &right(P1,P2)), 
                            P1!=P2, &sus{x(P1,K)} > x(P2,K), 
                            time(K), rel_right_pp(P1,P2,K).

%# `alignedY(P1,P2)`
%
% Points `P1` and `P2` have the same `y` coordinate.
%
% ![`&alignedY`](../../assets/relations/alignedY_pp.svg)
%
&sus{y(P1,K)} = y(P2,K) :- true(&alignedY(P1,P2),K), rel_alignedY_pp(P1,P2,K).

true(&alignedY(P1,P2),K) :- formula(spatial, &alignedY(P1,P2)), &sus{y(P1,K)} = y(P2,K), time(K), rel_alignedY_pp(P1,P2,K).

%# `samePlace(P1,P2)`
%
% Distinct points `P1` and `P2` occupy the same position.
%
% ![`&samePlace`](../../assets/relations/samePlace_pp.svg)
%
&sus{x(P1,K)}=x(P2,K) :- true(&samePlace(P1,P2),K), P1!=P2, rel_samePlace_pp(P1,P2,K).
&sus{y(P1,K)}=y(P2,K) :- true(&samePlace(P1,P2),K), P1!=P2, rel_samePlace_pp(P1,P2,K).

true(&samePlace(P1,P2),K) :- formula(spatial, &samePlace(P1,P2)), P1!=P2,
                              &sus{x(P1,K)}=x(P2,K), &sus{y(P1,K)}=y(P2,K), time(K), rel_samePlace_pp(P1,P2,K).
