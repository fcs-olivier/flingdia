%# Axioms
%
% Default axioms of the spatial domain: how the parameters of the geometric sorts get a
% value at each time step, and how they are carried over from one step to the next.
%
% Each axiom is activated per instance by declaring the corresponding theory atom in the
% instance file.

%*! point(P)

Declares `P` to be a point, whose parameters are `x` and `y`.

Args:
    - P: the point
*%

%*! rect(R)

Declares `R` to be a rectangle, whose parameters are `left_side`, `bottom`, `width` and
`height`.

Args:
    - R: the rectangle
*%

%*! line(L)

Declares `L` to be a line, whose parameters are `xstart`, `xend`, `ystart` and `yend`.

Args:
    - L: the line
*%

%*! partial

Theory atom `&partial`: enables HTc semantics, where parameters may remain undefined.

Simply declare `&partial` in the instance file. Without it, `&df` holds at every step
and all parameters of all objects are assigned a value.
*%

%*! df

Theory atom `&df`: marks the time steps at which every parameter must be defined.

It is derived from the absence of `&partial`, and guards the assignment rules below.
*%

%*! inertia

Theory atom `&inertia`: applies inertia to all the parameters of all objects.

Simply declare `&inertia` in the instance file. Each parameter then keeps its previous
value unless some other rule forces it to change.
*%

%%df(K) :- not true(&partial, K), time(K).

%## Points
%
% A point has parameters `x` and `y`.


true(&df, 0)      :- not true(&partial, 0).
true(&inertia, 0) :- not true(&not_inertia, 0).

%### All parameters defined
&in{xmin..xmax}=:x(P,K) :- true(point(P),K), true(&df, K).
&in{ymin..ymax}=:y(P,K) :- true(point(P),K), true(&df, K).

%### Inertia
&sus{x(P,K)}=:x(P,K1):- K1=K+1, true(point(P),K), not &sus{x(P,K)}!=x(P,K1), true(&inertia, 0).
&sus{y(P,K)}=:y(P,K1):- K1=K+1, true(point(P),K), not &sus{y(P,K)}!=y(P,K1), true(&inertia, 0).

%## Rectangles
%
% A rectangle has parameters `left_side`, `bottom`, `width` and `height`.

%### All parameters defined
&in{xmin..xmax-1}=:left_side(R,K) :- true(rect(R),K), true(&df, K).
&in{ymin..ymax-1}=:bottom(R,K)    :- true(rect(R),K), true(&df, K).
&in{xmin..xmax}=:width(R,K)       :- true(rect(R),K), true(&df, K).
&in{ymin..ymax}=:height(R,K)      :- true(rect(R),K), true(&df, K).

%### Inertia
&sus{left_side(R,K)}=:left_side(R,K1):- K1=K+1, true(rect(R),K), not &sus{left_side(R,K)}!=left_side(R,K1), true(&inertia, 0).
&sus{bottom(R,K)}=:bottom(R,K1)      :- K1=K+1, true(rect(R),K), not &sus{bottom(R,K)}!=bottom(R,K1),       true(&inertia, 0).
&sus{width(R,K)}=:width(R,K1)        :- K1=K+1, true(rect(R),K), not &sus{width(R,K)}!=width(R,K1),         true(&inertia, 0).
&sus{height(R,K)}=:height(R,K1)      :- K1=K+1, true(rect(R),K), not &sus{height(R,K)}!=height(R,K1),       true(&inertia, 0).

%## Lines
%
% A line has parameters `xstart`, `xend`, `ystart` and `yend`.

%### All parameters defined
&in{xmin..xmax}=:xstart(L,K) :- true(line(L),K), true(&df, K).
&in{xmin..xmax}=:xend(L,K)   :- true(line(L),K), true(&df, K).
&in{ymin..ymax}=:ystart(L,K) :- true(line(L),K), true(&df, K).
&in{ymin..ymax}=:yend(L,K)   :- true(line(L),K), true(&df, K).

%### Inertia
&sus{xstart(L,K)}=:xstart(L,K1):- K1=K+1, true(line(L),K), not &sus{xstart(L,K)}!=xstart(L,K1), true(&inertia, 0).
&sus{xend(L,K)}=:xend(L,K1)    :- K1=K+1, true(line(L),K), not &sus{xend(L,K)}!=xend(L,K1), true(&inertia, 0).
&sus{ystart(L,K)}=:ystart(L,K1):- K1=K+1, true(line(L),K), not &sus{ystart(L,K)}!=ystart(L,K1), true(&inertia, 0).
&sus{yend(L,K)}=:yend(L,K1)    :- K1=K+1, true(line(L),K), not &sus{yend(L,K)}!=yend(L,K1), true(&inertia, 0).
