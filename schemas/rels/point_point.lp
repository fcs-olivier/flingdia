

%%%%%%%%%  POINT POINT  %%%%%%%%%%%%%


%%%%%%%%%%  left_pp  %%%%%%%%%%%%%
% TRUE cases for P1: 
% y                      y                                       y
% 3 | .   .   P2  .      3 | .   .   .   .                       3 | .   .   .   .
% 2 | .   .   .   .      2 | .   .   .   .                       2 | .   .   .   .
% 1 | .   P1  .   .      1 | .   P1  .   P2                      1 | .   .   .   .
% 0 | .   .   .   .      0 | .   .   .   .                       0 | .   .   .   .
%   +----------------      +----------------                       +----------------
%     0   1   2   3  x       0   1   2   3  x                        0   1   2   3  x
&sus{x(P1,K)} < x(P2,K) :- true(&left_pp(P1,P2),K).
                 
true(&left_pp(P1,P2),K) :- formula(spatial, &left_pp(P1,P2)), P1!=P2, &sus{x(P1,K)} < x(P2,K), time(K).
                         
                         
invalid_relation_arg(&left_pp(P1,P2)) :- formula(spatial, &left_pp(P1,P2)),
                                         #count {valid_arg_1 : true(point(P1),K);
                                                 valid_arg_2 : true(point(P2),K)} != 2, 
                                                 time(K).




%%%%%%%%%%  right_pp %%%%%%%%%%%%%
% TRUE cases for P1: 
% y                      y                                       y
% 3 | .   .   P1  .      3 | .   .   .   .                       3 | .   .   .   .
% 2 | .   .   .   .      2 | .   .   .   .                       2 | .   .   .   .
% 1 | .   P2  .   .      1 | .   P2  .   P1                      1 | .   .   .   .
% 0 | .   .   .   .      0 | .   .   .   .                       0 | .   .   .   .
%   +----------------      +----------------                       +----------------
%     0   1   2   3  x       0   1   2   3  x                        0   1   2   3  x
&sus{x(P1,K)} > x(P2,K) :- true(&right_pp(P1,P2),K).

true(&right_pp(P1,P2),K) :- formula(spatial, &right_pp(P1,P2)), P1!=P2, &sus{x(P1,K)} > x(P2,K), time(K).

invalid_relation_arg(&right_pp(P1,P2)) :- formula(spatial, &right_pp(P1,P2)),
                                         #count {valid_arg_1 : true(point(P1),K);
                                                 valid_arg_2 : true(point(P2),K)} != 2,
                                                 time(K).


%%%%%%%%%%  alignedY_pp %%%%%%%%%%%%%
% TRUE cases for P1: 
% y                      y                                       y
% 3 | .   .   .   .      3 | .   .   .   .                       3 | .   .   .   .
% 2 | .   .   .   .      2 | .   .   .   .                       2 | .   .   .   .
% 1 | .   P1/2.   .      1 | .   P1  .   P2                      1 | .   .   .   .
% 0 | .   .   .   .      0 | .   .   .   .                       0 | .   .   .   .
%   +----------------      +----------------                       +----------------
%     0   1   2   3  x       0   1   2   3  x                        0   1   2   3  x
&sus{y(P1,K)} = y(P2,K) :- true(&alignedY_pp(P1,P2),K).

true(&alignedY_pp(P1,P2),K) :- formula(spatial, &alignedY_pp(P1,P2)), &sus{y(P1,K)} = y(P2,K), time(K).

invalid_relation_arg(&alignedY_pp(P1,P2)) :- formula(spatial, &alignedY_pp(P1,P2)),
                                         #count {valid_arg_1 : true(point(P1),K);
                                                 valid_arg_2 : true(point(P2),K)} != 2,
                                                 time(K).


%%%%%%%%%%%%%%% samePlace_pp  %%%%%%%%%%%%% 
% TRUE cases for P1: 
% y                      y                                       y
% 3 | .   .   .   .      3 | .   .   .   .                       3 | .   .   .   .
% 2 | .   .   .   .      2 | .   .   .   .                       2 | .   .   .   .
% 1 | .   P1/2.   .      1 | .   .   .   .                       1 | .   .   .   .
% 0 | .   .   .   .      0 | .   .   .   .                       0 | .   .   .   .
%   +----------------      +----------------                       +----------------
%     0   1   2   3  x       0   1   2   3  x                        0   1   2   3  x
&sus{x(P1,K)}=x(P2,K) :- true(&samePlace_pp(P1,P2),K), P1!=P2.
&sus{y(P1,K)}=y(P2,K) :- true(&samePlace_pp(P1,P2),K), P1!=P2.

true(&samePlace_pp(P1,P2),K) :- formula(spatial, &samePlace_pp(P1,P2)), P1!=P2,
                              &sus{x(P1,K)}=x(P2,K), &sus{y(P1,K)}=y(P2,K), time(K).

invalid_relation_arg(&samePlace_pp(P1,P2)) :- formula(spatial, &samePlace_pp(P1,P2)),
                                         #count {valid_arg_1 : true(point(P1),K);
                                                 valid_arg_2 : true(point(P2),K)} != 2,
                                                 time(K).





