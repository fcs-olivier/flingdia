%%% RECT POINT

%# `touches(R1,P2)`
%
% Point `P2` lies within or on rectangle `R1` and has an `x` coordinate equal
% to its left or right side, or a `y` coordinate equal to its bottom or top
% side.
%
% ![`&touches`](../../assets/relations/touches_rp.svg)
%

% Closed containment.
&sus{x(P2,K)}>=left_side(R1,K)  :- true(&touches(R1,P2),K), rel_touches_rp(R1,P2,K).
&sus{y(P2,K)}>=bottom(R1,K)     :- true(&touches(R1,P2),K), rel_touches_rp(R1,P2,K).
&sus{x(P2,K)}<=right_side(R1,K) :- true(&touches(R1,P2),K), rel_touches_rp(R1,P2,K).
&sus{y(P2,K)}<=top(R1,K)        :- true(&touches(R1,P2),K), rel_touches_rp(R1,P2,K).

% At least one edge contact.
c1_touches_rp(R1,P2,K)|
  c2_touches_rp(R1,P2,K)|
  c3_touches_rp(R1,P2,K)|
  c4_touches_rp(R1,P2,K) :- true(&touches(R1,P2),K), rel_touches_rp(R1,P2,K).

&sus{x(P2,K)}=left_side(R1,K)  :- c1_touches_rp(R1,P2,K).
&sus{y(P2,K)}=bottom(R1,K)     :- c2_touches_rp(R1,P2,K).
&sus{x(P2,K)}=right_side(R1,K) :- c3_touches_rp(R1,P2,K).
&sus{y(P2,K)}=top(R1,K)        :- c4_touches_rp(R1,P2,K).

c1_touches_rp(R1,P2,K) :- formula(spatial, &touches(R1,P2)),
                            &sus{x(P2,K)}>=left_side(R1,K),
                            &sus{y(P2,K)}>=bottom(R1,K),
                            &sus{x(P2,K)}<=right_side(R1,K),
                            &sus{y(P2,K)}<=top(R1,K),
                            &sus{x(P2,K)}=left_side(R1,K), time(K), rel_touches_rp(R1,P2,K).

c2_touches_rp(R1,P2,K) :- formula(spatial, &touches(R1,P2)),
                            &sus{x(P2,K)}>=left_side(R1,K),
                            &sus{y(P2,K)}>=bottom(R1,K),
                            &sus{x(P2,K)}<=right_side(R1,K),
                            &sus{y(P2,K)}<=top(R1,K),
                            &sus{y(P2,K)}=bottom(R1,K), time(K), rel_touches_rp(R1,P2,K).

c3_touches_rp(R1,P2,K) :- formula(spatial, &touches(R1,P2)),
                            &sus{x(P2,K)}>=left_side(R1,K),
                            &sus{y(P2,K)}>=bottom(R1,K),
                            &sus{x(P2,K)}<=right_side(R1,K),
                            &sus{y(P2,K)}<=top(R1,K),
                            &sus{x(P2,K)}=right_side(R1,K), time(K), rel_touches_rp(R1,P2,K).

c4_touches_rp(R1,P2,K) :- formula(spatial, &touches(R1,P2)),
                            &sus{x(P2,K)}>=left_side(R1,K),
                            &sus{y(P2,K)}>=bottom(R1,K),
                            &sus{x(P2,K)}<=right_side(R1,K),
                            &sus{y(P2,K)}<=top(R1,K),
                            &sus{y(P2,K)}=top(R1,K), time(K), rel_touches_rp(R1,P2,K).

true(&touches(R1,P2),K) :- c1_touches_rp(R1,P2,K), rel_touches_rp(R1,P2,K).
true(&touches(R1,P2),K) :- c2_touches_rp(R1,P2,K), rel_touches_rp(R1,P2,K).
true(&touches(R1,P2),K) :- c3_touches_rp(R1,P2,K), rel_touches_rp(R1,P2,K).
true(&touches(R1,P2),K) :- c4_touches_rp(R1,P2,K), rel_touches_rp(R1,P2,K).


