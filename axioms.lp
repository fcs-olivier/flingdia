
% Axiom &partial : enables HTc semantics where parameters can remain undefined.
%          Use   : simply declare &partial in the instance file.
%df(K) :- not true(&partial, K), time(K).

% Axiom &inertia : applies inertia to all the parameters of all objects.
%          Use   : simply declare &inertia in the instance file.

true(&df, 0)      :- not true(&partial, 0).
true(&inertia, 0) :- not true(&not_inertia, 0).

%%%%%%%%%%%%% POINTS %%%%%%%%%%%%%
% 0) POINT : Parameters :
%    x, y

% 1) POINT : All parameters defined
&in{xmin..xmax}=:x(P,K) :- true(point(P),K), true(&df, K).
&in{ymin..ymax}=:y(P,K) :- true(point(P),K), true(&df, K).

% 2) POINT : &inertia
&sus{x(P,K)}=:x(P,K1):- K1=K+1, true(point(P),K), not &sus{x(P,K)}!=x(P,K1), true(&inertia, 0).
&sus{y(P,K)}=:y(P,K1):- K1=K+1, true(point(P),K), not &sus{y(P,K)}!=y(P,K1), true(&inertia, 0).


%%%%%%%%%%%%% RECTANGLES %%%%%%%%%%%%%
% 0) RECTANGLE : Parameters :
%    left_side, bottom, width, height

% 1) RECTANGLE : All parameters defined
&in{xmin..xmax-1}=:left_side(R,K) :- true(rect(R),K), true(&df, K).
&in{ymin..ymax-1}=:bottom(R,K)    :- true(rect(R),K), true(&df, K).
&in{xmin..xmax}=:width(R,K)       :- true(rect(R),K), true(&df, K).
&in{ymin..ymax}=:height(R,K)      :- true(rect(R),K), true(&df, K).

% 2) RECTANGLE : &inertia
&sus{left_side(R,K)}=:left_side(R,K1):- K1=K+1, true(rect(R),K), not &sus{left_side(R,K)}!=left_side(R,K1), true(&inertia, 0).
&sus{bottom(R,K)}=:bottom(R,K1)      :- K1=K+1, true(rect(R),K), not &sus{bottom(R,K)}!=bottom(R,K1),       true(&inertia, 0).
&sus{width(R,K)}=:width(R,K1)        :- K1=K+1, true(rect(R),K), not &sus{width(R,K)}!=width(R,K1),         true(&inertia, 0).
&sus{height(R,K)}=:height(R,K1)      :- K1=K+1, true(rect(R),K), not &sus{height(R,K)}!=height(R,K1),       true(&inertia, 0).

%%%%%%%%%%%%% LINES %%%%%%%%%%%%%
% 0) LINE : Parameters :
%    xstart, xend, ystart, yend

% 1) LINE : All parameters defined
&in{xmin..xmax}=:xstart(L,K) :- true(line(L),K), true(&df, K).
&in{xmin..xmax}=:xend(L,K)   :- true(line(L),K), true(&df, K).
&in{ymin..ymax}=:ystart(L,K) :- true(line(L),K), true(&df, K).
&in{ymin..ymax}=:yend(L,K)   :- true(line(L),K), true(&df, K).


% 2) LINE : &inertia
&sus{xstart(L,K)}=:xstart(L,K1):- K1=K+1, true(line(L),K), not &sus{xstart(L,K)}!=xstart(L,K1), true(&inertia, 0).
&sus{xend(L,K)}=:xend(L,K1)    :- K1=K+1, true(line(L),K), not &sus{xend(L,K)}!=xend(L,K1), true(&inertia, 0).
&sus{ystart(L,K)}=:ystart(L,K1):- K1=K+1, true(line(L),K), not &sus{ystart(L,K)}!=ystart(L,K1), true(&inertia, 0).
&sus{yend(L,K)}=:yend(L,K1)    :- K1=K+1, true(line(L),K), not &sus{yend(L,K)}!=yend(L,K1), true(&inertia, 0).

