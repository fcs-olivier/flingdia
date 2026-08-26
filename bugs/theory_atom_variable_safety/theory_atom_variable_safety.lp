% P should be safe because the positive theory atom binds it.

point(a;b).
&left_pp(a,b).

first(P) :- &left_pp(P,b).
%first(a) :- #count{P : &left_pp(P,a)}=0.
