

%%%%%%%%%  POINT POINT  %%%%%%%%%%%%%


%%%%%%%%%%  left  %%%%%%%%%%%%%
% TRUE cases for P1: 
% y                      y                                       y
% 3 | .   .   P2  .      3 | .   .   .   .                       3 | .   .   .   .
% 2 | .   .   .   .      2 | .   .   .   .                       2 | .   .   .   .
% 1 | .   P1  .   .      1 | .   P1  .   P2                      1 | .   .   .   .
% 0 | .   .   .   .      0 | .   .   .   .                       0 | .   .   .   .
%   +----------------      +----------------                       +----------------
%     0   1   2   3  x       0   1   2   3  x                        0   1   2   3  x
&sus{x(P1,K)} < x(P2,K) :- true(&left(P1,P2),K), rel_left_pp(P1,P2,K).
                 
true(&left(P1,P2),K) :- formula(spatial, &left(P1,P2)), 
                           P1!=P2, &sus{x(P1,K)} < x(P2,K), 
                           time(K), rel_left_pp(P1,P2,K).
                         
                         




%%%%%%%%%%  right %%%%%%%%%%%%%
% TRUE cases for P1: 
% y                      y                                       y
% 3 | .   .   P1  .      3 | .   .   .   .                       3 | .   .   .   .
% 2 | .   .   .   .      2 | .   .   .   .                       2 | .   .   .   .
% 1 | .   P2  .   .      1 | .   P2  .   P1                      1 | .   .   .   .
% 0 | .   .   .   .      0 | .   .   .   .                       0 | .   .   .   .
%   +----------------      +----------------                       +----------------
%     0   1   2   3  x       0   1   2   3  x                        0   1   2   3  x
&sus{x(P1,K)} > x(P2,K) :- true(&right(P1,P2),K), rel_right_pp(P1,P2,K).

true(&right(P1,P2),K) :- formula(spatial, &right(P1,P2)), 
                            P1!=P2, &sus{x(P1,K)} > x(P2,K), 
                            time(K), rel_right_pp(P1,P2,K).



%%%%%%%%%%  alignedY %%%%%%%%%%%%%
% TRUE cases for P1: 
% y                      y                                       y
% 3 | .   .   .   .      3 | .   .   .   .                       3 | .   .   .   .
% 2 | .   .   .   .      2 | .   .   .   .                       2 | .   .   .   .
% 1 | .   P1/2.   .      1 | .   P1  .   P2                      1 | .   .   .   .
% 0 | .   .   .   .      0 | .   .   .   .                       0 | .   .   .   .
%   +----------------      +----------------                       +----------------
%     0   1   2   3  x       0   1   2   3  x                        0   1   2   3  x
&sus{y(P1,K)} = y(P2,K) :- true(&alignedY(P1,P2),K), rel_alignedY_pp(P1,P2,K).

true(&alignedY(P1,P2),K) :- formula(spatial, &alignedY(P1,P2)), &sus{y(P1,K)} = y(P2,K), time(K), rel_alignedY_pp(P1,P2,K).



%%%%%%%%%%%%%%% samePlace  %%%%%%%%%%%%% 
% TRUE cases for P1: 
% y                      y                                       y
% 3 | .   .   .   .      3 | .   .   .   .                       3 | .   .   .   .
% 2 | .   .   .   .      2 | .   .   .   .                       2 | .   .   .   .
% 1 | .   P1/2.   .      1 | .   .   .   .                       1 | .   .   .   .
% 0 | .   .   .   .      0 | .   .   .   .                       0 | .   .   .   .
%   +----------------      +----------------                       +----------------
%     0   1   2   3  x       0   1   2   3  x                        0   1   2   3  x
&sus{x(P1,K)}=x(P2,K) :- true(&samePlace(P1,P2),K), P1!=P2, rel_samePlace_pp(P1,P2,K).
&sus{y(P1,K)}=y(P2,K) :- true(&samePlace(P1,P2),K), P1!=P2, rel_samePlace_pp(P1,P2,K).

true(&samePlace(P1,P2),K) :- formula(spatial, &samePlace(P1,P2)), P1!=P2,
                              &sus{x(P1,K)}=x(P2,K), &sus{y(P1,K)}=y(P2,K), time(K), rel_samePlace_pp(P1,P2,K).






