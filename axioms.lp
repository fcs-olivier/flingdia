%# 1) Object validity

%## Points: 
% They are always valid

%## Rectangles: 
%
% Width and height must be strictly positive.
%
:- true(rect(R),K), &sus{height(R,K)} <= 0.
:- true(rect(R),K), &sus{width(R,K)} <= 0.
% 

%## Lines: 
%
% A line segment must have distinct start or end points.
%
xstart_differs_from_xend :- true(line(L),K), &sus{xstart(L,K)}!=xend(L,K).
ystart_differs_from_yend :- true(line(L),K), &sus{ystart(L,K)}!=yend(L,K). 
:- {xstart_differs_from_xend ; ystart_differs_from_yend}<1, true(line(L),K), 
    &df{xstart(L,K)}, &df{xend(L,K)}, &df{ystart(L,K)}, &df{yend(L,K)}.


%------------------------------------------------------------------------------
%# 2) Space bounds

% Default values for space bounds. If any of these constants are provided as an argument, 
% they will override these default values
% space limits are available as constants in the input file in either case
#const xmin = 0. #const xmax = 10.
#const ymin = 0. #const ymax = 10.
#const zmin = 0. #const zmax = 10.


%## Points:
%
% Both coordinates must lie within the configured spatial bounds.
%
:- true(point(P),K), &sus{x(P,K)}<xmin.
:- true(point(P),K), &sus{x(P,K)}>xmax.
:- true(point(P),K), &sus{y(P,K)}<ymin.
:- true(point(P),K), &sus{y(P,K)}>ymax.


%## Rectangles:
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

%## Lines:
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

%------------------------------------------------------------------------------
%# 3) Definedess (defeasible)
%
% Every parameter of an object declared in the initial state
%   is assigned a value.

%
% Add `&partial.` to an input program to allow parameters to remain undefined.
% independent and may be used together.

true(df, 0)      :- not true(&partial, 0).


%## Points:
&in{xmin..xmax}=:x(P,K) :- true(point(P),K), true(df, K).
&in{ymin..ymax}=:y(P,K) :- true(point(P),K), true(df, K).

%## Rectangles:
&in{xmin..xmax-1}=:left_side(R,K) :- true(rect(R),K), true(df, K).
&in{ymin..ymax-1}=:bottom(R,K)    :- true(rect(R),K), true(df, K).
&in{xmin..xmax}=:width(R,K)       :- true(rect(R),K), true(df, K).
&in{ymin..ymax}=:height(R,K)      :- true(rect(R),K), true(df, K).

%## Lines:
&in{xmin..xmax}=:xstart(L,K) :- true(line(L),K), true(df, K).
&in{xmin..xmax}=:xend(L,K)   :- true(line(L),K), true(df, K).   
&in{ymin..ymax}=:ystart(L,K) :- true(line(L),K), true(df, K).
&in{ymin..ymax}=:yend(L,K)   :- true(line(L),K), true(df, K).


%------------------------------------------------------------------------------
%# 4) Inertia (defeasible)
%
% Parameter values persist between consecutive states unless a change is supported.
%
% Add `&not_inertia.` to disable persistence.

true(inertia, 0) :- not true(&not_inertia, 0).

%## Points:

&sus{x(P,K)}=:x(P,K1):- K1=K+1, true(point(P),K), not &sus{x(P,K)}!=x(P,K1), true(inertia, 0).
&sus{y(P,K)}=:y(P,K1):- K1=K+1, true(point(P),K), not &sus{y(P,K)}!=y(P,K1), true(inertia, 0).

%## Rectangles:

&sus{left_side(R,K)}=:left_side(R,K1):- K1=K+1, true(rect(R),K), not &sus{left_side(R,K)}!=left_side(R,K1), true(inertia, 0).
&sus{bottom(R,K)}=:bottom(R,K1)      :- K1=K+1, true(rect(R),K), not &sus{bottom(R,K)}!=bottom(R,K1),       true(inertia, 0).
&sus{width(R,K)}=:width(R,K1)        :- K1=K+1, true(rect(R),K), not &sus{width(R,K)}!=width(R,K1),         true(inertia, 0).
&sus{height(R,K)}=:height(R,K1)      :- K1=K+1, true(rect(R),K), not &sus{height(R,K)}!=height(R,K1),       true(inertia, 0).

%## Lines:

&sus{xstart(L,K)}=:xstart(L,K1):- K1=K+1, true(line(L),K), not &sus{xstart(L,K)}!=xstart(L,K1), true(inertia, 0).
&sus{xend(L,K)}=:xend(L,K1)    :- K1=K+1, true(line(L),K), not &sus{xend(L,K)}!=xend(L,K1), true(inertia, 0).
&sus{ystart(L,K)}=:ystart(L,K1):- K1=K+1, true(line(L),K), not &sus{ystart(L,K)}!=ystart(L,K1), true(inertia, 0).
&sus{yend(L,K)}=:yend(L,K1)    :- K1=K+1, true(line(L),K), not &sus{yend(L,K)}!=yend(L,K1), true(inertia, 0).

