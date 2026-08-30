
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  RECT-RECT  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%% POSITION %%%%%%%%%%%%%

%%%%%%%%%%%%%% right  %%%%%%%%%%%%%
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

&sus{left_side(R1,K)}>=right_side(R2,K) :- true(&right(R1,R2),K), rel_right_rr(R1,R2,K).

true(&right(R1,R2),K) :- formula(spatial, &right(R1,R2)),
                          &sus{left_side(R1,K)}>=right_side(R2,K), time(K), rel_right_rr(R1,R2,K).


%%%%%%%%%%%%%%% left  %%%%%%%%%%%%%

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
&sus{right_side(R1,K)}<=left_side(R2,K) :- true(&left(R1,R2),K), rel_left_rr(R1,R2,K).

true(&left(R1,R2),K) :- formula(spatial, &left(R1,R2)),
                         &sus{right_side(R1,K)}<=left_side(R2,K), time(K), rel_left_rr(R1,R2,K).



%%%%%%%%%%%%%%% below  %%%%%%%%%%%%%

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

&sus{top(R1,K)}<=bottom(R2,K) :- true(&below(R1,R2),K), rel_below_rr(R1,R2,K).

true(&below(R1,R2),K) :- formula(spatial, &below(R1,R2)),
                          &sus{top(R1,K)}<=bottom(R2,K), time(K), rel_below_rr(R1,R2,K).



%%%%%%%%%%%%%%% above  %%%%%%%%%%%%%

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

&sus{bottom(R1,K)}>=top(R2,K) :- true(&above(R1,R2),K), rel_above_rr(R1,R2,K).

true(&above(R1,R2),K) :- formula(spatial, &above(R1,R2)),
                          &sus{bottom(R1,K)}>=top(R2,K), time(K), rel_above_rr(R1,R2,K).




%%%%%%%%%%%%%%% on  %%%%%%%%%%%%%

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

&sus{bottom(R1,K)} = top(R2,K)           :- true(&on(R1,R2),K), R1 != R2, rel_on_rr(R1,R2,K).
&sus{right_side(R1,K)} > left_side(R2,K) :- true(&on(R1,R2),K), R1 != R2, rel_on_rr(R1,R2,K).
&sus{left_side(R1,K)} < right_side(R2,K) :- true(&on(R1,R2),K), R1 != R2, rel_on_rr(R1,R2,K).

true(&on(R1,R2),K) :- formula(spatial, &on(R1,R2)), R1 != R2,
                       &sus{bottom(R1,K)} = top(R2,K),
                       &sus{right_side(R1,K)} > left_side(R2,K),
                       &sus{left_side(R1,K)} < right_side(R2,K), time(K), rel_on_rr(R1,R2,K).



