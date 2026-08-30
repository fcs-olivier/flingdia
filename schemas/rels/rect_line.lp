

%%%%%%%%%  RECT-LINE  %%%%%%%%%%%%%
%%%%%%%%%%%%%%% on  %%%%%%%%%%%%% 
% TRUE: line longer than base        TRUE: line same length as base
% 3 | .   .   .   .                  3 | .   .   .   .
% 2 | .   +-------+                  2 | .   +-------+
% 1 | .   |       |                  1 | .   |       |
% 0 | S---+-------+---E              0 | .   S-------E
%   +----------------                  +----------------
%     0   1   2   3  x                  0   1   2   3  x

% FALSE: line too short              FALSE: line is not horizontal     FALSE: line not horizontal
% 3 | .   .   .   .                  3 | .   .   .   .                  3 | .   .   E   .
% 2 | .   +-------+                  2 | .   E-------+                  2 | .   +-------+
% 1 | .   |       |                  1 | .   |       |                  1 | .   | /     |
% 0 | S---+---E   +                  0 | .   S-------+                  0 | .   S-------+
%   +----------------                  +----------------                  +----------------
%     0   1   2   3  x                  0   1   2   3  x                  0   1   2   3  x

&sus{xstart(L2,K)}<= left_side(R1,K) :- true(&on(R1,L2),K), rel_on_rl(R1,L2,K).
&sus{xend(L2,K)}>= right_side(R1,K) :- true(&on(R1,L2),K), rel_on_rl(R1,L2,K).
&sus{ystart(L2,K)}= bottom(R1,K) :- true(&on(R1,L2),K), rel_on_rl(R1,L2,K).
:- true(&on(R1,L2),K), not &sus{ystart(L2,K)}=yend(L2,K), rel_on_rl(R1,L2,K).  % the line must be horizontal


true(&on(R1,L2),K) :- formula(spatial, &on(R1,L2)),
                        &sus{ystart(L2,K)}=yend(L2,K),    % the line must be horizontal
                        &sus{xstart(L2,K)}<= left_side(R1,K),
                        &sus{xend(L2,K)}>= right_side(R1,K),
                        &sus{ystart(L2,K)}= bottom(R1,K),
                        time(K), rel_on_rl(R1,L2,K).



