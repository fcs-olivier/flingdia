% P should be safe because the positive theory atom binds it.

point(a;b).
&left(a,b).

first(P) :- &left(P,b).
%first(a) :- #count{P : &left(P,a)}=0.
