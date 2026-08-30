

%%%%%%%%%  LINE  %%%%%%%%%%%%%

%%%%%%%%%%%%%% horizontal  %%%%%%%%%%%%%
% TRUE: horizontal(l1)             TRUE: horizontal(l2)             FALSE: not horizontal(l3)
% y                                  y                                  y
% 3 | .   .   .   .                  3 | .   .   .   .                  3 | .   .   E   .   yend(l3)=3
% 2 | S-------E   .   ystart(l1)=2   2 | E-------S   .   ystart(l2)=2   2 | .   /   .   .
% 1 | .   .   .   .   yend(l1)=2     1 | .   .   .   .   yend(l2)=2     1 | S   .   .   .   ystart(l3)=1
% 0 | .   .   .   .                  0 | .   .   .   .                  0 | .   .   .   .
%   +----------------                  +----------------                  +----------------
%     0   1   2   3  x                  0   1   2   3  x                  0   1   2   3  x

&sus{ystart(L,K)}=yend(L,K) :- true(&horizontal(L),K), rel_horizontal_l(L,K).

true(&horizontal(L),K) :- formula(spatial, &horizontal(L)), &sus{ystart(L,K)}=yend(L,K), time(K), rel_horizontal_l(L,K).



%%%%%%%%%%%%%% vertical  %%%%%%%%%%%%%
% TRUE: vertical(l1)               TRUE: vertical(l2)               FALSE: not vertical(l3)
% y                                  y                                  y
% 3 | .   E   .   .   xend(l1)=1     3 | .   S   .   .   xstart(l2)=1   3 | .   .   E   .   xend(l3)=2
% 2 | .   |   .   .                  2 | .   |   .   .                  2 | .   /   .   .
% 1 | .   S   .   .   xstart(l1)=1   1 | .   E   .   .   xend(l2)=1     1 | S   .   .   .   xstart(l3)=0
% 0 | .   .   .   .                  0 | .   .   .   .                  0 | .   .   .   .
%   +----------------                  +----------------                  +----------------
%     0   1   2   3  x                  0   1   2   3  x                  0   1   2   3  x

&sus{xstart(L,K)}=xend(L,K) :- true(&vertical(L),K), rel_vertical_l(L,K).

true(&vertical(L),K) :- formula(spatial, &vertical(L)), &sus{xstart(L,K)}=xend(L,K), time(K), rel_vertical_l(L,K).



%%%%%%%%%%%%%% diagonal  %%%%%%%%%%%%%
% A diagonal line has slope 1 or -1. The two cases are kept explicit so that
% asserting the relation provides founded support for the selected equality.


% diagonal_pos_l(L,K) |
% diagonal_neg_l(L,K) :- true(&diagonal(L),K).

% &sus{(xend(L,K)-xstart(L,K))} = (yend(L,K)-ystart(L,K)) :- diagonal_pos_l(L,K).
% &sus{(xend(L,K)-xstart(L,K))} = (ystart(L,K)-yend(L,K)) :- diagonal_neg_l(L,K).

% diagonal_pos_l(L,K) :- formula(spatial, &diagonal(L)),
%                        &sus{(xend(L,K)-xstart(L,K))} = (yend(L,K)-ystart(L,K)),
%                        time(K).

% diagonal_neg_l(L,K) :- formula(spatial, &diagonal(L)),
%                        &sus{(xend(L,K)-xstart(L,K))} = (ystart(L,K)-yend(L,K)),
%                        time(K).

% true(&diagonal(L),K) :- formula(spatial, &diagonal(L)),
%                           diagonal_pos_l(L,K),
%                           time(K).

% true(&diagonal(L),K) :- formula(spatial, &diagonal(L)),
%                           diagonal_neg_l(L,K),
%                           time(K).



