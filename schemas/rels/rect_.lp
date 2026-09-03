%%% RECT

%# `leftmost(R1)`
%
% Rectangle `R1` has a least left-side coordinate among all other rectangles.
% Ties are allowed because every comparison uses `<=`.
%
% ![`&leftmost`](../../assets/relations/leftmost_r.svg)
%
not_left_rr(R2,R1,T) :- true(&leftmost(R1),T), true(rect(R2),T), R1!=R2, rel_leftmost_r(R1,T).
&sus{left_side(R1,T)} <= left_side(R2,T) :- not_left_rr(R2,R1,T).
not_left_rr(R2,R1,T) :- formula(spatial, &leftmost(R1)), true(rect(R2),T), R1!=R2,
                       &sus{left_side(R1,T)} <= left_side(R2,T), time(T), rel_leftmost_r(R1,T).
true(&leftmost(R1),T) :- formula(spatial, &leftmost(R1)), time(T),
                          rel_leftmost_r(R1,T),
                          not_left_rr(R2,R1,T) : true(rect(R2),T), R1!=R2.


%# `rightmost(R1)`
%
% Rectangle `R1` has a greatest right-side coordinate among all other rectangles.
% Ties are allowed because every comparison uses `>=`.
%
% ![`&rightmost`](../../assets/relations/rightmost_r.svg)
%
not_right_rr(R2,R1,T) :- true(&rightmost(R1),T), true(rect(R2),T), R1!=R2, rel_rightmost_r(R1,T).
&sus{right_side(R1,T)} >= right_side(R2,T) :- not_right_rr(R2,R1,T).
not_right_rr(R2,R1,T) :- formula(spatial, &rightmost(R1)), true(rect(R2),T), R1!=R2,
                        &sus{right_side(R1,T)} >= right_side(R2,T), time(T), rel_rightmost_r(R1,T).
true(&rightmost(R1),T) :- formula(spatial, &rightmost(R1)), time(T),
                           rel_rightmost_r(R1,T),
                           not_right_rr(R2,R1,T) : true(rect(R2),T), R1!=R2.


%# `horizontal(R)`
%
% Rectangle `R` is wider than it is tall: `width(R) > height(R)`.
%
% ![`&horizontal`](../../assets/relations/horizontal_r.svg)
%
&sus{width(R,T)} > height(R,T) :- true(&horizontal(R),T), true(rect(R),T), time(T), rel_horizontal_r(R,T).
true(&horizontal(R),T) :- formula(spatial, &horizontal(R)), 
                            true(rect(R),T), 
                            &sus{width(R,T)} > height(R,T), time(T), rel_horizontal_r(R,T).


%# `vertical(R)`
%
% Rectangle `R` is taller than it is wide: `height(R) > width(R)`.
%
% ![`&vertical`](../../assets/relations/vertical_r.svg)
%
&sus{height(R,T)} > width(R,T) :- true(&vertical(R),T), true(rect(R),T), time(T), rel_vertical_r(R,T).
true(&vertical(R),T) :- formula(spatial, &vertical(R)), 
                          true(rect(R),T), &sus{height(R,T)} > width(R,T), time(T), rel_vertical_r(R,T).


%# `empty(R1)`
%
% Rectangle `R1` has no point in its interior and no positive-area overlap with another rectangle.
% Points or rectangles may touch its boundary because the separating comparisons are non-strict.
%
% ![`&empty`](../../assets/relations/empty_r.svg)
%
c1_discrete_rr(R1,R2,T)| 
  c2_discrete_rr(R1,R2,T)| 
  c3_discrete_rr(R1,R2,T)|  
  c4_discrete_rr(R1,R2,T) :- true(&empty(R1),T), true(rect(R2),T), R1!=R2, rel_empty_r(R1,T).
&sus{left_side(R1,T)}>=right_side(R2,T) :- c1_discrete_rr(R1,R2,T).
&sus{bottom(R1,T)}>=top(R2,T)           :- c2_discrete_rr(R1,R2,T).
&sus{right_side(R1,T)}<=left_side(R2,T) :- c3_discrete_rr(R1,R2,T).
&sus{top(R1,T)}<=bottom(R2,T)           :- c4_discrete_rr(R1,R2,T).
c1_discrete_rr(R1,R2,T):- formula(spatial, &empty(R1)), true(rect(R2),T), &sus{left_side(R1,T)}>=right_side(R2,T), R1!=R2, time(T), rel_empty_r(R1,T). 
c2_discrete_rr(R1,R2,T):- formula(spatial, &empty(R1)), true(rect(R2),T), &sus{bottom(R1,T)} >= top(R2,T),         R1!=R2, time(T), rel_empty_r(R1,T).
c3_discrete_rr(R1,R2,T):- formula(spatial, &empty(R1)), true(rect(R2),T), &sus{right_side(R1,T)} <= left_side(R2,T), R1!=R2, time(T), rel_empty_r(R1,T).
c4_discrete_rr(R1,R2,T):- formula(spatial, &empty(R1)), true(rect(R2),T), &sus{top(R1,T)} <= bottom(R2,T),           R1!=R2, time(T), rel_empty_r(R1,T).
discrete_rr(R1,R2,T) :- c1_discrete_rr(R1,R2,T), formula(spatial, &empty(R1)), time(T), rel_empty_r(R1,T).
discrete_rr(R1,R2,T) :- c2_discrete_rr(R1,R2,T), formula(spatial, &empty(R1)), time(T), rel_empty_r(R1,T).
discrete_rr(R1,R2,T) :- c3_discrete_rr(R1,R2,T), formula(spatial, &empty(R1)), time(T), rel_empty_r(R1,T).
discrete_rr(R1,R2,T) :- c4_discrete_rr(R1,R2,T), formula(spatial, &empty(R1)), time(T), rel_empty_r(R1,T).
empty_of_rect(R1,T) :- formula(spatial, &empty(R1)), time(T), rel_empty_r(R1,T),
                       discrete_rr(R1,R2,T): true(rect(R2),T), R1!=R2.
c1_out_pr(P1,R2,K)|
    c2_out_pr(P1,R2,K)|
    c3_out_pr(P1,R2,K)|
    c4_out_pr(P1,R2,K) :- true(&empty(R2),K), true(point(P1),K), rel_empty_r(R2,K).
&sus{x(P1,K)}<=left_side(R2,K)  :- c1_out_pr(P1,R2,K).
&sus{y(P1,K)}<=bottom(R2,K)     :- c2_out_pr(P1,R2,K).
&sus{x(P1,K)}>=right_side(R2,K) :- c3_out_pr(P1,R2,K).
&sus{y(P1,K)}>=top(R2,K)        :- c4_out_pr(P1,R2,K).
c1_out_pr(P1,R2,K) :- formula(spatial, &empty(R2)), true(point(P1),K), &sus{x(P1,K)}<=left_side(R2,K), time(K), rel_empty_r(R2,K).
c2_out_pr(P1,R2,K) :- formula(spatial, &empty(R2)), true(point(P1),K), &sus{y(P1,K)}<=bottom(R2,K), time(K), rel_empty_r(R2,K).
c3_out_pr(P1,R2,K) :- formula(spatial, &empty(R2)), true(point(P1),K), &sus{x(P1,K)}>=right_side(R2,K), time(K), rel_empty_r(R2,K).
c4_out_pr(P1,R2,K) :- formula(spatial, &empty(R2)), true(point(P1),K), &sus{y(P1,K)}>=top(R2,K), time(K), rel_empty_r(R2,K).
out_pr(P1,R1,T):- c1_out_pr(P1,R1,T), formula(spatial, &empty(R1)), time(T), rel_empty_r(R1,T).
out_pr(P1,R1,T):- c2_out_pr(P1,R1,T), formula(spatial, &empty(R1)), time(T), rel_empty_r(R1,T).
out_pr(P1,R1,T):- c3_out_pr(P1,R1,T), formula(spatial, &empty(R1)), time(T), rel_empty_r(R1,T).
out_pr(P1,R1,T):- c4_out_pr(P1,R1,T), formula(spatial, &empty(R1)), time(T), rel_empty_r(R1,T).
empty_of_point(R1,T) :- formula(spatial, &empty(R1)), time(T), rel_empty_r(R1,T),
                        out_pr(P1,R1,T): true(point(P1),T).
true(&empty(R1),T) :- empty_of_rect(R1,T), empty_of_point(R1,T), rel_empty_r(R1,T).
