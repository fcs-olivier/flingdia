%%% RECT RECT

%# `right(R1,R2)`
%
% Rectangle `R1` is right of `R2` when `left_side(R1) >= right_side(R2)`.
% Boundary contact is allowed; vertical alignment is irrelevant.
%
% ![`&right`](../../assets/relations/right_rr.svg)
%
&sus{left_side(R1,K)}>=right_side(R2,K) :- true(&right(R1,R2),K), rel_right_rr(R1,R2,K).
true(&right(R1,R2),K) :- formula(spatial, &right(R1,R2)),
                          &sus{left_side(R1,K)}>=right_side(R2,K), time(K), rel_right_rr(R1,R2,K).


%# `left(R1,R2)`
%
% Rectangle `R1` is left of `R2` when `right_side(R1) <= left_side(R2)`.
% Boundary contact is allowed; vertical alignment is irrelevant.
%
% ![`&left`](../../assets/relations/left_rr.svg)
%
&sus{right_side(R1,K)}<=left_side(R2,K) :- true(&left(R1,R2),K), rel_left_rr(R1,R2,K).
true(&left(R1,R2),K) :- formula(spatial, &left(R1,R2)),
                         &sus{right_side(R1,K)}<=left_side(R2,K), time(K), rel_left_rr(R1,R2,K).


%# `below(R1,R2)`
%
% Rectangle `R1` is below `R2` when `top(R1) <= bottom(R2)`.
% Boundary contact is allowed; horizontal alignment is irrelevant.
%
% ![`&below`](../../assets/relations/below_rr.svg)
%
&sus{top(R1,K)}<=bottom(R2,K) :- true(&below(R1,R2),K), rel_below_rr(R1,R2,K).
true(&below(R1,R2),K) :- formula(spatial, &below(R1,R2)),
                          &sus{top(R1,K)}<=bottom(R2,K), time(K), rel_below_rr(R1,R2,K).


%# `above(R1,R2)`
%
% Rectangle `R1` is above `R2` when `bottom(R1) >= top(R2)`.
% Boundary contact is allowed; horizontal alignment is irrelevant.
%
% ![`&above`](../../assets/relations/above_rr.svg)
%
&sus{bottom(R1,K)}>=top(R2,K) :- true(&above(R1,R2),K), rel_above_rr(R1,R2,K).
true(&above(R1,R2),K) :- formula(spatial, &above(R1,R2)),
                          &sus{bottom(R1,K)}>=top(R2,K), time(K), rel_above_rr(R1,R2,K).


%# `on(R1,R2)`
%
% Rectangle `R1` is on `R2` when its bottom equals `R2`'s top and their horizontal interiors overlap.
% The strict horizontal inequalities exclude corner-only contact.
%
% ![`&on`](../../assets/relations/on_rr.svg)
%
&sus{bottom(R1,K)} = top(R2,K)           :- true(&on(R1,R2),K), R1 != R2, rel_on_rr(R1,R2,K).
&sus{right_side(R1,K)} > left_side(R2,K) :- true(&on(R1,R2),K), R1 != R2, rel_on_rr(R1,R2,K).
&sus{left_side(R1,K)} < right_side(R2,K) :- true(&on(R1,R2),K), R1 != R2, rel_on_rr(R1,R2,K).
true(&on(R1,R2),K) :- formula(spatial, &on(R1,R2)), R1 != R2,
                       &sus{bottom(R1,K)} = top(R2,K),
                       &sus{right_side(R1,K)} > left_side(R2,K),
                       &sus{left_side(R1,K)} < right_side(R2,K), time(K), rel_on_rr(R1,R2,K).
