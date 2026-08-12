
%%%%%%%%%%  RECTANGLE-POINT  %%%%%%%%%%%%%

%%%%%%%%%%%% touches_rp  %%%%%%%%%%%%%
% TRUE: point on the boundary of the rectangle
%    +---------+                   +----*----+
%    |         | R                 |         | R
%    *P        |                   |         |
%    +---------+                   +---------+
%
% FALSE: strictly inside             FALSE: outside
%    +---------+                   +---------+
%    |    *P   | R                 |         | R
%    |         |                   |         |    *P
%    +---------+                   +---------+

% Closed containment.
&sus{x(P2,K)}>=left_side(R1,K)  :- true(&touches_rp(R1,P2),K).
&sus{y(P2,K)}>=bottom(R1,K)     :- true(&touches_rp(R1,P2),K).
&sus{x(P2,K)}<=right_side(R1,K) :- true(&touches_rp(R1,P2),K).
&sus{y(P2,K)}<=top(R1,K)        :- true(&touches_rp(R1,P2),K).

% At least one edge contact.
c1_touches_rp(R1,P2,K)|
  c2_touches_rp(R1,P2,K)|
  c3_touches_rp(R1,P2,K)|
  c4_touches_rp(R1,P2,K) :- true(&touches_rp(R1,P2),K).

&sus{x(P2,K)}=left_side(R1,K)  :- c1_touches_rp(R1,P2,K).
&sus{y(P2,K)}=bottom(R1,K)     :- c2_touches_rp(R1,P2,K).
&sus{x(P2,K)}=right_side(R1,K) :- c3_touches_rp(R1,P2,K).
&sus{y(P2,K)}=top(R1,K)        :- c4_touches_rp(R1,P2,K).

c1_touches_rp(R1,P2,K) :- formula(spatial, &touches_rp(R1,P2)),
                            &sus{x(P2,K)}>=left_side(R1,K),
                            &sus{y(P2,K)}>=bottom(R1,K),
                            &sus{x(P2,K)}<=right_side(R1,K),
                            &sus{y(P2,K)}<=top(R1,K),
                            &sus{x(P2,K)}=left_side(R1,K), time(K).

c2_touches_rp(R1,P2,K) :- formula(spatial, &touches_rp(R1,P2)),
                            &sus{x(P2,K)}>=left_side(R1,K),
                            &sus{y(P2,K)}>=bottom(R1,K),
                            &sus{x(P2,K)}<=right_side(R1,K),
                            &sus{y(P2,K)}<=top(R1,K),
                            &sus{y(P2,K)}=bottom(R1,K), time(K).

c3_touches_rp(R1,P2,K) :- formula(spatial, &touches_rp(R1,P2)),
                            &sus{x(P2,K)}>=left_side(R1,K),
                            &sus{y(P2,K)}>=bottom(R1,K),
                            &sus{x(P2,K)}<=right_side(R1,K),
                            &sus{y(P2,K)}<=top(R1,K),
                            &sus{x(P2,K)}=right_side(R1,K), time(K).

c4_touches_rp(R1,P2,K) :- formula(spatial, &touches_rp(R1,P2)),
                            &sus{x(P2,K)}>=left_side(R1,K),
                            &sus{y(P2,K)}>=bottom(R1,K),
                            &sus{x(P2,K)}<=right_side(R1,K),
                            &sus{y(P2,K)}<=top(R1,K),
                            &sus{y(P2,K)}=top(R1,K), time(K).

true(&touches_rp(R1,P2),K) :- c1_touches_rp(R1,P2,K).
true(&touches_rp(R1,P2),K) :- c2_touches_rp(R1,P2,K).
true(&touches_rp(R1,P2),K) :- c3_touches_rp(R1,P2,K).
true(&touches_rp(R1,P2),K) :- c4_touches_rp(R1,P2,K).

invalid_relation_arg(&touches_rp(R1,P2)) :- formula(spatial, &touches_rp(R1,P2)),
                                         #count {valid_arg_1 : true(rect(R1),K);
                                                 valid_arg_2 : true(point(P2),K)} != 2,
                                                 time(K).

