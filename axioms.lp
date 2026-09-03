%# Default parameter axioms
%
% Flingdia enables two parameter axioms by default:
%
% - **Definedness:** every parameter of an object declared in the initial state
%   is assigned a value.
% - **Inertia:** parameter values persist between consecutive states unless a
%   change is supported.
%
% Add `&partial.` to an input program to allow parameters to remain undefined.
% Add `&not_inertia.` to disable persistence. The two directives are
% independent and may be used together.
%
%df(K) :- not true(&partial, K), time(K).

true(df, 0)      :- not true(&partial, 0).
true(inertia, 0) :- not true(&not_inertia, 0).

%%%%%%%%%%%%% POINTS %%%%%%%%%%%%%
%## Points
%
%% 0) POINT: parameters
%%    x, y

%### Definedness
&in{xmin..xmax}=:x(P,K) :- true(point(P),K), true(df, K).
&in{ymin..ymax}=:y(P,K) :- true(point(P),K), true(df, K).

%### Inertia
&sus{x(P,K)}=:x(P,K1):- K1=K+1, true(point(P),K), not &sus{x(P,K)}!=x(P,K1), true(inertia, 0).
&sus{y(P,K)}=:y(P,K1):- K1=K+1, true(point(P),K), not &sus{y(P,K)}!=y(P,K1), true(inertia, 0).


%%%%%%%%%%%%% RECTANGLES %%%%%%%%%%%%%
%## Rectangles
%
%% 0) RECTANGLE: parameters
%%    left_side, bottom, width, height

%### Definedness
&in{xmin..xmax-1}=:left_side(R,K) :- true(rect(R),K), true(df, K).
&in{ymin..ymax-1}=:bottom(R,K)    :- true(rect(R),K), true(df, K).
&in{xmin..xmax}=:width(R,K)       :- true(rect(R),K), true(df, K).
&in{ymin..ymax}=:height(R,K)      :- true(rect(R),K), true(df, K).

%### Inertia
&sus{left_side(R,K)}=:left_side(R,K1):- K1=K+1, true(rect(R),K), not &sus{left_side(R,K)}!=left_side(R,K1), true(inertia, 0).
&sus{bottom(R,K)}=:bottom(R,K1)      :- K1=K+1, true(rect(R),K), not &sus{bottom(R,K)}!=bottom(R,K1),       true(inertia, 0).
&sus{width(R,K)}=:width(R,K1)        :- K1=K+1, true(rect(R),K), not &sus{width(R,K)}!=width(R,K1),         true(inertia, 0).
&sus{height(R,K)}=:height(R,K1)      :- K1=K+1, true(rect(R),K), not &sus{height(R,K)}!=height(R,K1),       true(inertia, 0).

%%%%%%%%%%%%% LINES %%%%%%%%%%%%%
%## Lines
%
%% 0) LINE: parameters
%%    xstart, xend, ystart, yend

%### Definedness
&in{xmin..xmax}=:xstart(L,K) :- true(line(L),K), true(df, K).
&in{xmin..xmax}=:xend(L,K)   :- true(line(L),K), true(df, K).   
&in{ymin..ymax}=:ystart(L,K) :- true(line(L),K), true(df, K).
&in{ymin..ymax}=:yend(L,K)   :- true(line(L),K), true(df, K).

%### Inertia
&sus{xstart(L,K)}=:xstart(L,K1):- K1=K+1, true(line(L),K), not &sus{xstart(L,K)}!=xstart(L,K1), true(inertia, 0).
&sus{xend(L,K)}=:xend(L,K1)    :- K1=K+1, true(line(L),K), not &sus{xend(L,K)}!=xend(L,K1), true(inertia, 0).
&sus{ystart(L,K)}=:ystart(L,K1):- K1=K+1, true(line(L),K), not &sus{ystart(L,K)}!=ystart(L,K1), true(inertia, 0).
&sus{yend(L,K)}=:yend(L,K1)    :- K1=K+1, true(line(L),K), not &sus{yend(L,K)}!=yend(L,K1), true(inertia, 0).

