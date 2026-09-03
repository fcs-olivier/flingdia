

%# Geometric sorts
%
% Flingdia provides three geometric sorts: points, rectangles, and lines.
% Their declarations are ordinary ASP predicates, not clingo type declarations.
% A sort identifies an object's available geometric parameters and determines
% which overloaded spatial relations and actions accept that object.
%
% Declaring a sort does not itself assign coordinates or assert any spatial
% relation. Parameter definedness and persistence are handled separately by
% the default axioms.
%

%%%%%%%%%%%%% POINTS %%%%%%%%%%%%%
%## Points
%
% Declare a point named `P` with `point(P)`. Its position is represented by
% the parameters `x` and `y`.
%
%% 0) POINT: parameters
%%    x, y

%% 1) POINT: intrinsic derived quantities
%% 2) POINT: validity constraints
%% 3) POINT: inside space limits
%### Space bounds
%
% Both coordinates must lie within the configured spatial bounds.
%
:- true(point(P),K), &sus{x(P,K)}<xmin.
:- true(point(P),K), &sus{x(P,K)}>xmax.
:- true(point(P),K), &sus{y(P,K)}<ymin.
:- true(point(P),K), &sus{y(P,K)}>ymax.



%%%%%%%%%%%%% RECTANGLES %%%%%%%%%%%%%
%## Rectangles
%
% Declare a rectangle named `R` with `rect(R)`. Its bottom-left corner and
% dimensions are represented by `left_side`, `bottom`, `width`, and `height`.
%
%% 0) RECTANGLE: parameters
%%    left_side, bottom, width, height

%% 1) RECTANGLE: intrinsic derived quantities
%### Derived parameters
%
% The opposite sides are derived from the bottom-left corner and dimensions.
%
&sus{(left_side(R,K)+width(R,K))}=:right_side(R,K) :- true(rect(R),K).
&sus{(bottom(R,K)+height(R,K))}=:top(R,K)          :- true(rect(R),K).

%% 2) RECTANGLE: validity constraints
%### Validity
%
% Width and height must be strictly positive.
%
:- true(rect(R),K), &sus{height(R,K)} <= 0.
:- true(rect(R),K), &sus{width(R,K)} <= 0.

%% 3) RECTANGLE: inside space limits
%### Space bounds
%
% All four sides must lie within the configured spatial bounds.
%
:- true(rect(R),K), &sus{left_side(R,K)}<xmin.
:- true(rect(R),K), &sus{left_side(R,K)}>xmax.
:- true(rect(R),K), &sus{right_side(R,K)}<xmin.
:- true(rect(R),K), &sus{right_side(R,K)}>xmax.
:- true(rect(R),K), &sus{bottom(R,K)}<ymin.
:- true(rect(R),K), &sus{bottom(R,K)}>ymax.
:- true(rect(R),K), &sus{top(R,K)}<ymin.
:- true(rect(R),K), &sus{top(R,K)}>ymax.



%%%%%%%%%%%%% LINES %%%%%%%%%%%%%
%## Lines
%
% Declare a line segment named `L` with `line(L)`. Its endpoints are represented
% by `xstart`, `ystart`, `xend`, and `yend`.
%
%% 0) LINE: parameters
%%    xstart, xend, ystart, yend

%% 1) LINE: intrinsic derived quantities
%% 2) LINE: validity constraints
%### Validity
%
% A line segment must have distinct start and end points.
%
xstart_differs_from_xend :- true(line(L),K), &sus{xstart(L,K)}!=xend(L,K).
ystart_differs_from_yend :- true(line(L),K), &sus{ystart(L,K)}!=yend(L,K). 
:- {xstart_differs_from_xend ; ystart_differs_from_yend}<1, true(line(L),K), &df{xstart(L,K)}, &df{xend(L,K)}, &df{ystart(L,K)}, &df{yend(L,K)}.

%% 3) LINE: inside space limits
%### Space bounds
%
% Both endpoints must lie within the configured spatial bounds.
%
:- true(line(L),K), &sus{xstart(L,K)}<xmin.
:- true(line(L),K), &sus{xstart(L,K)}>xmax.
:- true(line(L),K), &sus{xend(L,K)}<xmin.
:- true(line(L),K), &sus{xend(L,K)}>xmax.
:- true(line(L),K), &sus{ystart(L,K)}<ymin.
:- true(line(L),K), &sus{ystart(L,K)}>ymax.
:- true(line(L),K), &sus{yend(L,K)}<ymin.
:- true(line(L),K), &sus{yend(L,K)}>ymax.

