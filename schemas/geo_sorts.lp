
%%%%%%%%%%%%% POINTS %%%%%%%%%%%%%
% 0) parameters :
%    x, y

% 1) derived-quantities intrinsic
% 2) validity constraints
% 3) inside space limits
:- true(point(P),K), &sus{x(P,K)}<xmin.
:- true(point(P),K), &sus{x(P,K)}>xmax.
:- true(point(P),K), &sus{y(P,K)}<ymin.
:- true(point(P),K), &sus{y(P,K)}>ymax.



%%%%%%%%%%%%% RECTANGLES %%%%%%%%%%%%%

% 0) parameters :
%    left_side, bottom, width, height

% 1) derived-quantities intrinsic
&sus{(left_side(R,K)+width(R,K))}=:right_side(R,K) :- true(rect(R),K).
&sus{(bottom(R,K)+height(R,K))}=:top(R,K)          :- true(rect(R),K).

% 2) validity constraints
:- true(rect(R),K), &sus{height(R,K)} <= 0.
:- true(rect(R),K), &sus{width(R,K)} <= 0.

% 3) inside space limits
:- true(rect(R),K), &sus{left_side(R,K)}<xmin.
:- true(rect(R),K), &sus{left_side(R,K)}>xmax.
:- true(rect(R),K), &sus{right_side(R,K)}<xmin.
:- true(rect(R),K), &sus{right_side(R,K)}>xmax.
:- true(rect(R),K), &sus{bottom(R,K)}<ymin.
:- true(rect(R),K), &sus{bottom(R,K)}>ymax.
:- true(rect(R),K), &sus{top(R,K)}<ymin.
:- true(rect(R),K), &sus{top(R,K)}>ymax.



%%%%%%%%%%%%% LINES %%%%%%%%%%%%%
% 0) parameters :
%    xstart, xend, ystart, yend

% 1) derived-quantities intrinsic
% 2) validity constraints
xstart_differs_from_xend :- true(line(L),K), &sus{xstart(L,K)}!=xend(L,K).
ystart_differs_from_yend :- true(line(L),K), &sus{ystart(L,K)}!=yend(L,K). 
:- {xstart_differs_from_xend ; ystart_differs_from_yend}<1, true(line(L),K), &df{xstart(L,K)}, &df{xend(L,K)}, &df{ystart(L,K)}, &df{yend(L,K)}.

% 3) inside space limits
:- true(line(L),K), &sus{xstart(L,K)}<xmin.
:- true(line(L),K), &sus{xstart(L,K)}>xmax.
:- true(line(L),K), &sus{xend(L,K)}<xmin.
:- true(line(L),K), &sus{xend(L,K)}>xmax.
:- true(line(L),K), &sus{ystart(L,K)}<ymin.
:- true(line(L),K), &sus{ystart(L,K)}>ymax.
:- true(line(L),K), &sus{yend(L,K)}<ymin.
:- true(line(L),K), &sus{yend(L,K)}>ymax.

