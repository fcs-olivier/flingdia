


{true(&move_right(O),T);
 true(&move_down_right(O),T);
 true(&move_down(O),T);
 true(&move_down_left(O),T);
 true(&move_left(O),T); 
 true(&move_up_left(O),T);
 true(&move_up(O),T);
 true(&move_up_right(O),T)}=1 :- true(&move(O),T), time(T), T < n.

% Actions label transitions, so they cannot occur in the final state.
:- true(&move(O), n).

% Deduction of move based on simpler relation so that we can constraint how many obj move. 
true(&move(O),T) :- true(&move_right(O),T).
true(&move(O),T) :- true(&move_down_right(O),T).
true(&move(O),T) :- true(&move_down(O),T).
true(&move(O),T) :- true(&move_down_left(O),T).
true(&move(O),T) :- true(&move_left(O),T).
true(&move(O),T) :- true(&move_up_left(O),T).
true(&move(O),T) :- true(&move_up(O),T).
true(&move(O),T) :- true(&move_up_right(O),T).


% move for POINT
&sus{(x(P,T)+1)}=:x(P,T1) :- T1=T+1, true(&move_right(P),T), true(point(P),T). 

&sus{(x(P,T)+1)}=:x(P,T1) :- T1=T+1, true(&move_down_right(P),T), true(point(P),T). 
&sus{(y(P,T)-1)}=:y(P,T1) :- T1=T+1, true(&move_down_right(P),T), true(point(P),T). 

&sus{(y(P,T)-1)}=:y(P,T1) :- T1=T+1, true(&move_down(P),T), true(point(P),T). 

&sus{(x(P,T)-1)}=:x(P,T1) :- T1=T+1, true(&move_down_left(P),T), true(point(P),T). 
&sus{(y(P,T)-1)}=:y(P,T1) :- T1=T+1, true(&move_down_left(P),T), true(point(P),T). 

&sus{(x(P,T)-1)}=:x(P,T1) :- T1=T+1, true(&move_left(P),T), true(point(P),T). 

&sus{(x(P,T)-1)}=:x(P,T1) :- T1=T+1, true(&move_up_left(P),T), true(point(P),T). 
&sus{(y(P,T)+1)}=:y(P,T1) :- T1=T+1, true(&move_up_left(P),T), true(point(P),T). 

&sus{(y(P,T)+1)}=:y(P,T1) :- T1=T+1, true(&move_up(P),T), true(point(P),T). 

&sus{(x(P,T)+1)}=:x(P,T1) :- T1=T+1, true(&move_up_right(P),T), true(point(P),T). 
&sus{(y(P,T)+1)}=:y(P,T1) :- T1=T+1, true(&move_up_right(P),T), true(point(P),T). 


% move for RECTANGLE
&sus{(left_side(R,T)+1)}=:left_side(R,T1) :- T1=T+1, true(&move_right(R),T), true(rect(R),T). 

&sus{(left_side(R,T)+1)}=:left_side(R,T1) :- T1=T+1, true(&move_down_right(R),T), true(rect(R),T). 
&sus{(bottom(R,T)-1)}=:bottom(R,T1)       :- T1=T+1, true(&move_down_right(R),T), true(rect(R),T). 

&sus{(bottom(R,T)-1)}=:bottom(R,T1) :- T1=T+1, true(&move_down(R),T), true(rect(R),T). 

&sus{(left_side(R,T)-1)}=:left_side(R,T1) :- T1=T+1, true(&move_down_left(R),T), true(rect(R),T). 
&sus{(bottom(R,T)-1)}=:bottom(R,T1)       :- T1=T+1, true(&move_down_left(R),T), true(rect(R),T). 

&sus{(left_side(R,T)-1)}=:left_side(R,T1) :- T1=T+1, true(&move_left(R),T), true(rect(R),T). 

&sus{(left_side(R,T)-1)}=:left_side(R,T1) :- T1=T+1, true(&move_up_left(R),T), true(rect(R),T). 
&sus{(bottom(R,T)+1)}=:bottom(R,T1)       :- T1=T+1, true(&move_up_left(R),T), true(rect(R),T). 

&sus{(bottom(R,T)+1)}=:bottom(R,T1) :- T1=T+1, true(&move_up(R),T), true(rect(R),T). 

&sus{(left_side(R,T)+1)}=:left_side(R,T1) :- T1=T+1, true(&move_up_right(R),T), true(rect(R),T). 
&sus{(bottom(R,T)+1)}=:bottom(R,T1)       :- T1=T+1, true(&move_up_right(R),T), true(rect(R),T). 
