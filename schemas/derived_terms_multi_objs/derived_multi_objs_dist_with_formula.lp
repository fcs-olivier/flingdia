

%%%%%%%%%  POINT POINT  %%%%%%%%%%%%%

&max{
    x(P1,K)-x(P2,K); 
    x(P2,K)-x(P1,K)
} =: dist_x(P1,P2,K) :- 
    true(point(P1),K), true(point(P2),K), P1!=P2, time(K).

&max{
    y(P1,K)-y(P2,K); 
    y(P2,K)-y(P1,K)
} =: dist_y(P1,P2,K) :- 
    true(point(P1),K), true(point(P2),K), P1!=P2, time(K).

&max{
    dist_x(P1,P2,K); 
    dist_y(P1,P2,K)
    } =: dist(P1,P2,K) :- 
    true(point(P1),K), true(point(P2),K), P1!=P2, time(K).

&sus{5}=:dist(P1,P2,K) :- true(&far_pp(P1,P2),K).

true(&far_pp(P1,P2),K) :- formula(spatial, &far_pp(P1,P2)), P1!=P2, dist(P1,P2,K)>=5, time(K).


%%%%%%%%%  RECT RECT  %%%%%%%%%%%%%

&max{
    left_side(R1,K)-right_side(R2,K);
    left_side(R2,K)-right_side(R1,K);
    0
} =: dist_x(R1,R2,K) :-
    true(rect(R1),K), true(rect(R2),K), R1!=R2, time(K).

&max{
    bottom(R1,K)-top(R2,K);
    bottom(R2,K)-top(R1,K);
    0
} =: dist_y(R1,R2,K) :-
    true(rect(R1),K), true(rect(R2),K), R1!=R2, time(K).

&max{
    dist_x(R1,R2,K);
    dist_y(R1,R2,K)
} =: dist(R1,R2,K) :-
    true(rect(R1),K), true(rect(R2),K), R1!=R2, time(K).

true(&far_rr(R1,R2),K) :-
    formula(spatial, &far_rr(R1,R2)),
    R1!=R2,
    dist(R1,R2,K) >= 5,
    time(K).

&sus{5}=:dist(R1,R2,K) :- true(&far_rr(R1,R2),K).