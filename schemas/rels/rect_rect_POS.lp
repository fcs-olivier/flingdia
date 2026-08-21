
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  RECT-RECT  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%% POSITION %%%%%%%%%%%%%

%%%%%%%%%%%%%% right_rr  %%%%%%%%%%%%%
% TRUE: separated                    TRUE: touches                      TRUE: not vertically aligned
% 4 | .   .   +---+                  4 | .   .   .   .                  4 | +---+   .   .
% 3 | .   .   |R1 |                  3 | .   .   .   .                  3 | |R2 |   .   .
% 2 | +---+   |   |                  2 | +---+---+                      2 | +---+   .   .
% 1 | |R2 |   +---+                  1 | |R2 |R1 |                      1 | .   .   +---+
% 0 | +---+   .   .                  0 | +---+---+                      0 | .   .   |R1 |
%   +----------------                  +----------------                  +---------+---+--
%     0   1   2   3  x                  0   1   2   3  x                  0   1   2   3  x
% FALSE: overlap, though R1 extends right
% 3 | .   .   .   .
% 2 | +---+   .   .
% 1 | |R2+---+
% 0 | +--+R1 |
%   |    +---+
%   +----------------
%     0   1   2   3  x

&sus{left_side(R1,K)}>=right_side(R2,K) :- true(&right_rr(R1,R2),K).

true(&right_rr(R1,R2),K) :- formula(spatial, &right_rr(R1,R2)),
                          &sus{left_side(R1,K)}>=right_side(R2,K), time(K).

invalid_relation_arg(&right_rr(R1,R2)) :- formula(spatial, &right_rr(R1,R2)), R1!=R2,
                                         #count {valid_arg_1 : true(rect(R1),K);
                                                 valid_arg_2 : true(rect(R2),K)} != 2,
                                                 time(K).

%%%%%%%%%%%%%%% left_rr  %%%%%%%%%%%%%

% TRUE: separated                    TRUE: touches                      TRUE: not vertically aligned
% 4 | +---+   .   .                  4 | .   .   .   .                  4 | .   .   +---+
% 3 | |R1 |   .   .                  3 | .   .   .   .                  3 | .   .   |R2 |
% 2 | |   |   +---+                  2 | +---+---+                      2 | .   .   +---+
% 1 | +---+   |R2 |                  1 | |R1 |R2 |                      1 | +---+   .   .
% 0 | .   .   +---+                  0 | +---+---+                      0 | |R1 |   .   .
%   +----------------                  +----------------                  +-+---+----------
%     0   1   2   3  x                  0   1   2   3  x                  0   1   2   3  x

% FALSE: overlap, though R1 extends left
% 3 | .   .   .   .
% 2 | .  +----+
% 1 | +---+R2 |
% 0 | |R1+----+
%   | +---+
%   +----------------
%     0   1   2   3  x
&sus{right_side(R1,K)}<=left_side(R2,K) :- true(&left_rr(R1,R2),K).

true(&left_rr(R1,R2),K) :- formula(spatial, &left_rr(R1,R2)),
                         &sus{right_side(R1,K)}<=left_side(R2,K), time(K).

invalid_relation_arg(&left_rr(R1,R2)) :- formula(spatial, &left_rr(R1,R2)), R1!=R2,
                                         #count {valid_arg_1 : true(rect(R1),K);
                                                 valid_arg_2 : true(rect(R2),K)} != 2,
                                                 time(K).


%%%%%%%%%%%%%%% below_rr  %%%%%%%%%%%%%

% TRUE: directly below               TRUE: touches, horizontally shifted TRUE: below, not horizontally aligned
% 4 | .   +---+   .                  4 | .   .   .   .                  4 | .   .   +---+
% 3 | .   |R2 |   .                  3 | .   +---+   .                  3 | .   .   |R2 |
% 2 | .   +---+   .                  2 | .   |R2 |   .                  2 | .   .   +---+
% 1 | .   +---+   .                  1 | +---+---+   .                  1 | +---+   .   .
% 0 | .   |R1 |   .                  0 | |R1 |   .   .                  0 | |R1 |   .   .
%   +-----+---+------                  +-+---+----------                  +-+---+----------
%     0   1   2   3  x                  0   1   2   3  x                  0   1   2   3  x

% FALSE: overlap, though R1 extends below
% 3 | .   .   .   .
% 2 | .  +----+
% 1 | +---+R2 |
% 0 | |R1+----+
%   | +---+
%   +----------------
%     0   1   2   3  x

&sus{top(R1,K)}<=bottom(R2,K) :- true(&below_rr(R1,R2),K).

true(&below_rr(R1,R2),K) :- formula(spatial, &below_rr(R1,R2)),
                          &sus{top(R1,K)}<=bottom(R2,K), time(K).

invalid_relation_arg(&below_rr(R1,R2)) :- formula(spatial, &below_rr(R1,R2)), R1!=R2,
                                          #count {valid_arg_1 : true(rect(R1),K);
                                                  valid_arg_2 : true(rect(R2),K)} != 2,
                                                  time(K).


%%%%%%%%%%%%%%% above_rr  %%%%%%%%%%%%%

% TRUE: directly above               TRUE: touches, horizontally shifted TRUE: above, not horizontally aligned
% 4 | .   +---+   .                  4 | .   +---+   .                  4 | +---+   .   .
% 3 | .   |R1 |   .                  3 | .   |R1 |   .                  3 | |R1 |   .   .
% 2 | .   +---+   .                  2 | +---+---+   .                  2 | +---+   .   .
% 1 | .   +---+   .                  1 | |R2 |   .   .                  1 | .   .   +---+
% 0 | .   |R2 |   .                  0 | +---+   .   .                  0 | .   .   |R2 |
%   +-----+---+------                  +-+---+----------                  +---------+---+--
%     0   1   2   3  x                   0   1   2   3  x                   0   1   2   3  x
% FALSE: overlap, though R1 extends above
% 3 | .  +----+
% 2 | +---+R1 |
% 1 | |R2+----+
% 0 | +---+   .   .
%   +----------------
%     0   1   2   3  x

&sus{bottom(R1,K)}>=top(R2,K) :- true(&above_rr(R1,R2),K).

true(&above_rr(R1,R2),K) :- formula(spatial, &above_rr(R1,R2)),
                          &sus{bottom(R1,K)}>=top(R2,K), time(K).

invalid_relation_arg(&above_rr(R1,R2)) :- formula(spatial, &above_rr(R1,R2)), R1!=R2,
                                          #count {valid_arg_1 : true(rect(R1),K);
                                                  valid_arg_2 : true(rect(R2),K)} != 2,
                                                  time(K).



%%%%%%%%%%%%%%% on_rr  %%%%%%%%%%%%%

% TRUE: directly on                  TRUE: on, shifted with one unit common
% 4 | .   +---+   .                  4 | .   +-----+ .
% 3 | .   |R1 |   .                  3 | .   | R1  | .
% 2 | .   +---+   .                  2 | +---+-+---+   
% 1 | .   |R2 |   .                  1 | |R2   | .
% 0 | .   +---+   .                  0 | +-----+ .
%   +-----+---+------                  +-------------
%     0   1   2   3  x                   0   1   2   3  x

% FALSE: corner contact
% 4 | .     +---+ .
% 3 | .     |R1 | .
% 2 | +-----+---+ .
% 1 | | R2  | .   .
% 0 | +-----+ .   .
%   +------------- 
%     0   1   2   3  x                 

&sus{bottom(R1,K)} = top(R2,K)           :- true(&on_rr(R1,R2),K), R1 != R2.
&sus{right_side(R1,K)} > left_side(R2,K) :- true(&on_rr(R1,R2),K), R1 != R2.
&sus{left_side(R1,K)} < right_side(R2,K) :- true(&on_rr(R1,R2),K), R1 != R2.

true(&on_rr(R1,R2),K) :- formula(spatial, &on_rr(R1,R2)), R1 != R2,
                       &sus{bottom(R1,K)} = top(R2,K),
                       &sus{right_side(R1,K)} > left_side(R2,K),
                       &sus{left_side(R1,K)} < right_side(R2,K), time(K).

invalid_relation_arg(&on_rr(R1,R2)) :- formula(spatial, &on_rr(R1,R2)), R1!=R2,
                                       #count { valid_arg_1 : true(rect(R1),K);
                                                valid_arg_2 : true(rect(R2),K) } != 2,
                                                time(K).


