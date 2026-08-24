


{true(&move_right(O),I);
 true(&move_down_right(O),I);
 true(&move_down(O),I);
 true(&move_down_left(O),I);
 true(&move_left(O),I); 
 true(&move_up_left(O),I);
 true(&move_up(O),I);
 true(&move_up_right(O),I)}=1 :- true(&move(O),I), time(I), I < n.

% Actions label transitions, so they cannot occur in the final state.
:- true(&move(O), n).

% Deduction of move based on simpler relation so that we can constraint how many obj move. 
true(&move(O),I) :- true(&move_right(O),I).
true(&move(O),I) :- true(&move_down_right(O),I).
true(&move(O),I) :- true(&move_down(O),I).
true(&move(O),I) :- true(&move_down_left(O),I).
true(&move(O),I) :- true(&move_left(O),I).
true(&move(O),I) :- true(&move_up_left(O),I).
true(&move(O),I) :- true(&move_up(O),I).
true(&move(O),I) :- true(&move_up_right(O),I).


% move for POINT
&sus{(x(P,I)+1)}=:x(P,I1) :- I1=I+1, true(&move_right(P),I), true(point(P),I). 

&sus{(x(P,I)+1)}=:x(P,I1) :- I1=I+1, true(&move_down_right(P),I), true(point(P),I). 
&sus{(y(P,I)-1)}=:y(P,I1) :- I1=I+1, true(&move_down_right(P),I), true(point(P),I). 

&sus{(y(P,I)-1)}=:y(P,I1) :- I1=I+1, true(&move_down(P),I), true(point(P),I). 

&sus{(x(P,I)-1)}=:x(P,I1) :- I1=I+1, true(&move_down_left(P),I), true(point(P),I). 
&sus{(y(P,I)-1)}=:y(P,I1) :- I1=I+1, true(&move_down_left(P),I), true(point(P),I). 

&sus{(x(P,I)-1)}=:x(P,I1) :- I1=I+1, true(&move_left(P),I), true(point(P),I). 

&sus{(x(P,I)-1)}=:x(P,I1) :- I1=I+1, true(&move_up_left(P),I), true(point(P),I). 
&sus{(y(P,I)+1)}=:y(P,I1) :- I1=I+1, true(&move_up_left(P),I), true(point(P),I). 

&sus{(y(P,I)+1)}=:y(P,I1) :- I1=I+1, true(&move_up(P),I), true(point(P),I). 

&sus{(x(P,I)+1)}=:x(P,I1) :- I1=I+1, true(&move_up_right(P),I), true(point(P),I). 
&sus{(y(P,I)+1)}=:y(P,I1) :- I1=I+1, true(&move_up_right(P),I), true(point(P),I). 


% move for RECTANGLE
&sus{(left_side(R,I)+1)}=:left_side(R,I1) :- I1=I+1, true(&move_right(R),I), true(rect(R),I). 

&sus{(left_side(R,I)+1)}=:left_side(R,I1) :- I1=I+1, true(&move_down_right(R),I), true(rect(R),I). 
&sus{(bottom(R,I)-1)}=:bottom(R,I1)       :- I1=I+1, true(&move_down_right(R),I), true(rect(R),I). 

&sus{(bottom(R,I)-1)}=:bottom(R,I1) :- I1=I+1, true(&move_down(R),I), true(rect(R),I). 

&sus{(left_side(R,I)-1)}=:left_side(R,I1) :- I1=I+1, true(&move_down_left(R),I), true(rect(R),I). 
&sus{(bottom(R,I)-1)}=:bottom(R,I1)       :- I1=I+1, true(&move_down_left(R),I), true(rect(R),I). 

&sus{(left_side(R,I)-1)}=:left_side(R,I1) :- I1=I+1, true(&move_left(R),I), true(rect(R),I). 

&sus{(left_side(R,I)-1)}=:left_side(R,I1) :- I1=I+1, true(&move_up_left(R),I), true(rect(R),I). 
&sus{(bottom(R,I)+1)}=:bottom(R,I1)       :- I1=I+1, true(&move_up_left(R),I), true(rect(R),I). 

&sus{(bottom(R,I)+1)}=:bottom(R,I1) :- I1=I+1, true(&move_up(R),I), true(rect(R),I). 

&sus{(left_side(R,I)+1)}=:left_side(R,I1) :- I1=I+1, true(&move_up_right(R),I), true(rect(R),I). 
&sus{(bottom(R,I)+1)}=:bottom(R,I1)       :- I1=I+1, true(&move_up_right(R),I), true(rect(R),I). 
