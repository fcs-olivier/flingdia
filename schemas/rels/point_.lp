

%%%%%%%%%  POINT  %%%%%%%%%%%%%



%%%%%%% rightmost %%%%%%%%%%%%%
% TRUE cases for P1: 
% y                      y                                       y
% 3 | .   .   P3  .      3 | .   .   .   .                       3 | .   .   .   .
% 2 | .   .   .   .      2 | .   .   .   .                       2 | .   .   .   .
% 1 | .   P2  .   P1     1 | .   P2  .   P1/P3 (same place)      1 | .   .   .   .
% 0 | .   .   .   .      0 | .   .   .   .                       0 | .   .   .   .
%   +----------------      +----------------                       +----------------
%     0   1   2   3  x       0   1   2   3  x                        0   1   2   3  x

not_right_pp(P2,P1,K) :- true(&rightmost(P1),K), true(point(P2),K), P1!=P2, rel_rightmost_p(P1,K).

&sus{x(P1,K)} >= x(P2,K) :- not_right_pp(P2,P1,K).

not_right_pp(P2,P1,K) :- formula(spatial, &rightmost(P1)), true(point(P2),K), P1!=P2,
                        &sus{x(P1,K)} >= x(P2,K), time(K), rel_rightmost_p(P1,K).

true(&rightmost(P1),K) :- formula(spatial, &rightmost(P1)), time(K),
                           rel_rightmost_p(P1,K),
                           not_right_pp(P2,P1,K) : true(point(P2),K), P1!=P2.



%%%%%%% leftmost  %%%%%%%%%%%%%
% TRUE cases for P1: 
% y                      y                                       y
% 3 | .   .   P3  .      3 | .   .   .   .                       3 | .   .   .   .
% 2 | .   .   .   .      2 | .   .   .   .                       2 | .   .   .   .
% 1 | .   P1  .   P2     1 | .   P1/P3   P2 (P1, P3 same place)  1 | .   .   .   .
% 0 | .   .   .   .      0 | .   .   .   .                       0 | .   .   .   .
%   +----------------      +----------------                       +----------------
%     0   1   2   3  x       0   1   2   3  x                        0   1   2   3  x

not_left_pp(P2,P1,K) :- true(&leftmost(P1),K), true(point(P2),K), P1!=P2, rel_leftmost_p(P1,K).

&sus{x(P1,K)} <= x(P2,K) :- not_left_pp(P2,P1,K).

not_left_pp(P2,P1,K) :- formula(spatial, &leftmost(P1)), true(point(P2),K), P1!=P2,
                       &sus{x(P1,K)} <= x(P2,K), time(K), rel_leftmost_p(P1,K).

true(&leftmost(P1),K) :- formula(spatial, &leftmost(P1)), time(K),
                          rel_leftmost_p(P1,K),
                          not_left_pp(P2,P1,K) : true(point(P2),K), P1!=P2.


