

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

:- true(&rightmost_p(P1),K), 
   #count{P2 : true(&right_pp(P2,P1),K), 
   true(point(P2),K)}!=0.

true(&rightmost_p(P1),K) :- formula(spatial, &rightmost_p(P1)), 
                            #count{P2 : true(&right_pp(P2,P1),K), 
                            true(point(P2),K)}=0, time(K).

formula(spatial, &right_pp(P2,P1)) :- formula(spatial, &rightmost_p(P1)), true(point(P2),K), time(K). 


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

:- true(&leftmost_p(P1),K), #count{P2 : true(&left_pp(P2,P1),K), true(point(P2),K)}!=0.

true(&leftmost_p(P1),K) :- formula(spatial, &leftmost_p(P1)),
                        #count{P2 : true(&left_pp(P2,P1),K), true(point(P2),K)}=0, time(K).

formula(spatial, &left_pp(P2,P1)) :- formula(spatial, &leftmost_p(P1)), true(point(P2),K), time(K). 


invalid_relation_arg(&leftmost_p(P1)) :- formula(spatial, &leftmost_p(P1)),
                                         #count {valid_arg_1 : true(point(P1),K)} != 1,
                                         time(K).

