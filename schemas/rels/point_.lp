

%%%%%%%%%  POINT  %%%%%%%%%%%%%



%%%%%%% rightmost_p %%%%%%%%%%%%%
% TRUE cases for P1: 
% y                      y                                       y
% 3 | .   .   P3  .      3 | .   .   .   .                       3 | .   .   .   .
% 2 | .   .   .   .      2 | .   .   .   .                       2 | .   .   .   .
% 1 | .   P2  .   P1     1 | .   P2  .   P1/P3 (same place)      1 | .   .   .   .
% 0 | .   .   .   .      0 | .   .   .   .                       0 | .   .   .   .
%   +----------------      +----------------                       +----------------
%     0   1   2   3  x       0   1   2   3  x                        0   1   2   3  x

not_right_pp(P2,P1,K) :- true(&rightmost_p(P1),K), true(point(P2),K), P1!=P2.

&sus{x(P1,K)} >= x(P2,K) :- not_right_pp(P2,P1,K).

not_right_pp(P2,P1,K) :- formula(spatial, &rightmost_p(P1)), true(point(P2),K), P1!=P2,
                        &sus{x(P1,K)} >= x(P2,K), time(K).

true(&rightmost_p(P1),K) :- formula(spatial, &rightmost_p(P1)), time(K),
                           not_right_pp(P2,P1,K) : true(point(P2),K), P1!=P2.

invalid_relation_arg(&rightmost_p(P1)) :- formula(spatial, &rightmost_p(P1)),
                                         #count {valid_arg_1 : true(point(P1),K)} != 1,
                                         time(K).


%%%%%%% leftmost_p  %%%%%%%%%%%%%
% TRUE cases for P1: 
% y                      y                                       y
% 3 | .   .   P3  .      3 | .   .   .   .                       3 | .   .   .   .
% 2 | .   .   .   .      2 | .   .   .   .                       2 | .   .   .   .
% 1 | .   P1  .   P2     1 | .   P1/P3   P2 (P1, P3 same place)  1 | .   .   .   .
% 0 | .   .   .   .      0 | .   .   .   .                       0 | .   .   .   .
%   +----------------      +----------------                       +----------------
%     0   1   2   3  x       0   1   2   3  x                        0   1   2   3  x

not_left_pp(P2,P1,K) :- true(&leftmost_p(P1),K), true(point(P2),K), P1!=P2.

&sus{x(P1,K)} <= x(P2,K) :- not_left_pp(P2,P1,K).

not_left_pp(P2,P1,K) :- formula(spatial, &leftmost_p(P1)), true(point(P2),K), P1!=P2,
                       &sus{x(P1,K)} <= x(P2,K), time(K).

true(&leftmost_p(P1),K) :- formula(spatial, &leftmost_p(P1)), time(K),
                          not_left_pp(P2,P1,K) : true(point(P2),K), P1!=P2.

invalid_relation_arg(&leftmost_p(P1)) :- formula(spatial, &leftmost_p(P1)),
                                         #count {valid_arg_1 : true(point(P1),K)} != 1,
                                         time(K).

