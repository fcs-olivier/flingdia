%%% POINT RECT

%# `in(P1,R2)`
%
% Point `P1` is strictly between the left and right sides and strictly between
% the bottom and top sides of rectangle `R2`.
%
% ![`&in`](../../assets/relations/in_pr.svg)
%

&sus{x(P1,K)}>left_side(R2,K) :- true(&in(P1,R2),K), rel_in_pr(P1,R2,K). 
&sus{y(P1,K)}>bottom(R2,K)    :- true(&in(P1,R2),K), rel_in_pr(P1,R2,K). 
&sus{x(P1,K)}<right_side(R2,K):- true(&in(P1,R2),K), rel_in_pr(P1,R2,K). 
&sus{y(P1,K)}<top(R2,K)       :- true(&in(P1,R2),K), rel_in_pr(P1,R2,K). 

true(&in(P1,R2),K):- formula(spatial, &in(P1,R2)),
                      &sus{x(P1,K)}>left_side(R2,K), 
                      &sus{y(P1,K)}>bottom(R2,K), 
                      &sus{x(P1,K)}<right_side(R2,K), 
                      &sus{y(P1,K)}<top(R2,K),
                      time(K), rel_in_pr(P1,R2,K).

%# `inEq(P1,R2)`
%
% Point `P1` lies within or on rectangle `R2`: its `x` coordinate is between
% the left and right sides inclusively, and its `y` coordinate is between the
% bottom and top sides inclusively.
%
% ![`&inEq`](../../assets/relations/inEq_pr.svg)
%

&sus{x(P1,K)}>=left_side(R2,K) :- true(&inEq(P1,R2),K), rel_inEq_pr(P1,R2,K). 
&sus{y(P1,K)}>=bottom(R2,K)    :- true(&inEq(P1,R2),K), rel_inEq_pr(P1,R2,K). 
&sus{x(P1,K)}<=right_side(R2,K):- true(&inEq(P1,R2),K), rel_inEq_pr(P1,R2,K). 
&sus{y(P1,K)}<= top(R2,K)      :- true(&inEq(P1,R2),K), rel_inEq_pr(P1,R2,K). 

true(&inEq(P1,R2),K):- formula(spatial, &inEq(P1,R2)),
                      &sus{x(P1,K)}>=left_side(R2,K), 
                      &sus{y(P1,K)}>=bottom(R2,K), 
                      &sus{x(P1,K)}<=right_side(R2,K), 
                      &sus{y(P1,K)}<=top(R2,K),
                      time(K), rel_inEq_pr(P1,R2,K).

%# `out(P1,R2)`
%
% Point `P1` is at or beyond at least one side of rectangle `R2`: its `x`
% coordinate is at most the left side or at least the right side, or its `y`
% coordinate is at most the bottom side or at least the top side.
%
% ![`&out`](../../assets/relations/out_pr.svg)
%

c1_out_pr(P1,R2,K)|
    c2_out_pr(P1,R2,K)|
    c3_out_pr(P1,R2,K)|
    c4_out_pr(P1,R2,K) :- true(&out(P1,R2),K), rel_out_pr(P1,R2,K).

&sus{x(P1,K)}<=left_side(R2,K)  :- c1_out_pr(P1,R2,K).
&sus{y(P1,K)}<=bottom(R2,K)     :- c2_out_pr(P1,R2,K).
&sus{x(P1,K)}>=right_side(R2,K) :- c3_out_pr(P1,R2,K).
&sus{y(P1,K)}>=top(R2,K)        :- c4_out_pr(P1,R2,K).

% Tie each disjunctive case to its geometric witness.
c1_out_pr(P1,R2,K) :- formula(spatial, &out(P1,R2)), &sus{x(P1,K)}<=left_side(R2,K), time(K), rel_out_pr(P1,R2,K).
c2_out_pr(P1,R2,K) :- formula(spatial, &out(P1,R2)), &sus{y(P1,K)}<=bottom(R2,K), time(K), rel_out_pr(P1,R2,K).
c3_out_pr(P1,R2,K) :- formula(spatial, &out(P1,R2)), &sus{x(P1,K)}>=right_side(R2,K), time(K), rel_out_pr(P1,R2,K).
c4_out_pr(P1,R2,K) :- formula(spatial, &out(P1,R2)), &sus{y(P1,K)}>=top(R2,K), time(K), rel_out_pr(P1,R2,K).

true(&out(P1,R2),K) :- c1_out_pr(P1,R2,K), formula(spatial, &out(P1,R2)), rel_out_pr(P1,R2,K).
true(&out(P1,R2),K) :- c2_out_pr(P1,R2,K), formula(spatial, &out(P1,R2)), rel_out_pr(P1,R2,K).
true(&out(P1,R2),K) :- c3_out_pr(P1,R2,K), formula(spatial, &out(P1,R2)), rel_out_pr(P1,R2,K).
true(&out(P1,R2),K) :- c4_out_pr(P1,R2,K), formula(spatial, &out(P1,R2)), rel_out_pr(P1,R2,K).
%# `left(P1,R2)`
%
% Point `P1` has an `x` coordinate strictly less than the left side of
% rectangle `R2`.
%
% ![`&left`](../../assets/relations/left_pr.svg)
%

&sus{x(P1,K)}<left_side(R2,K) :- true(&left(P1,R2),K), rel_left_pr(P1,R2,K). 

true(&left(P1,R2),K):- formula(spatial, &left(P1,R2)),
                      &sus{x(P1,K)}<left_side(R2,K), 
                      time(K), rel_left_pr(P1,R2,K).
%# `right(P1,R2)`
%
% Point `P1` has an `x` coordinate strictly greater than the right side of
% rectangle `R2`.
%
% ![`&right`](../../assets/relations/right_pr.svg)
%

&sus{right_side(R2,K)}<x(P1,K) :- true(&right(P1,R2),K), rel_right_pr(P1,R2,K). 

true(&right(P1,R2),K):- formula(spatial, &right(P1,R2)),
                      &sus{right_side(R2,K)}<x(P1,K), 
                      time(K), rel_right_pr(P1,R2,K).
%# `alignedYEq(P1,R2)`
%
% Point `P1` has a `y` coordinate between the bottom and top sides of
% rectangle `R2`, inclusively.
%
% ![`&alignedYEq`](../../assets/relations/alignedYEq_pr.svg)
%

&sus{y(P1,K)}>=bottom(R2,K) :- true(&alignedYEq(P1,R2),K), rel_alignedYEq_pr(P1,R2,K).
&sus{y(P1,K)}<=top(R2,K)    :- true(&alignedYEq(P1,R2),K), rel_alignedYEq_pr(P1,R2,K).

true(&alignedYEq(P1,R2),K) :- formula(spatial, &alignedYEq(P1,R2)),
                               &sus{y(P1,K)}>=bottom(R2,K),
                               &sus{y(P1,K)}<=top(R2,K),
                               time(K), rel_alignedYEq_pr(P1,R2,K).
%# `alignedY(P1,R2)`
%
% Point `P1` has a `y` coordinate strictly between the bottom and top sides
% of rectangle `R2`.
%
% ![`&alignedY`](../../assets/relations/alignedY_pr.svg)
%

&sus{y(P1,K)}>bottom(R2,K) :- true(&alignedY(P1,R2),K), rel_alignedY_pr(P1,R2,K).
&sus{y(P1,K)}<top(R2,K)    :- true(&alignedY(P1,R2),K), rel_alignedY_pr(P1,R2,K).

true(&alignedY(P1,R2),K) :- formula(spatial, &alignedY(P1,R2)),
                               &sus{y(P1,K)}>bottom(R2,K),
                               &sus{y(P1,K)}<top(R2,K),
                               time(K), rel_alignedY_pr(P1,R2,K).



