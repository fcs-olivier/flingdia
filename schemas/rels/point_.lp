%%% POINT

%# `rightmost(P1)`
%
% Point `P1` has a greatest `x` coordinate among all points.
% Multiple points may be rightmost when they share that coordinate.
%
% ![`&rightmost`](../../assets/relations/rightmost_p.svg)
%
not_right_pp(P2,P1,K) :- true(&rightmost(P1),K), true(point(P2),K), P1!=P2, rel_rightmost_p(P1,K).

&sus{x(P1,K)} >= x(P2,K) :- not_right_pp(P2,P1,K).

not_right_pp(P2,P1,K) :- formula(spatial, &rightmost(P1)), true(point(P2),K), P1!=P2,
                        &sus{x(P1,K)} >= x(P2,K), time(K), rel_rightmost_p(P1,K).

true(&rightmost(P1),K) :- formula(spatial, &rightmost(P1)), time(K),
                           rel_rightmost_p(P1,K),
                           not_right_pp(P2,P1,K) : true(point(P2),K), P1!=P2.

%# `leftmost(P1)`
%
% Point `P1` has a least `x` coordinate among all points.
% Multiple points may be leftmost when they share that coordinate.
%
% ![`&leftmost`](../../assets/relations/leftmost_p.svg)
%
not_left_pp(P2,P1,K) :- true(&leftmost(P1),K), true(point(P2),K), P1!=P2, rel_leftmost_p(P1,K).

&sus{x(P1,K)} <= x(P2,K) :- not_left_pp(P2,P1,K).

not_left_pp(P2,P1,K) :- formula(spatial, &leftmost(P1)), true(point(P2),K), P1!=P2,
                       &sus{x(P1,K)} <= x(P2,K), time(K), rel_leftmost_p(P1,K).

true(&leftmost(P1),K) :- formula(spatial, &leftmost(P1)), time(K),
                          rel_leftmost_p(P1,K),
                          not_left_pp(P2,P1,K) : true(point(P2),K), P1!=P2.

