%*
Frozen copy of instances/TEMP/rush_hour.lp, kept in step with the "at most one
vehicle moves per step" constraint enabled. Used by repro.sh; see README.md.

The shortest plan under that constraint is 12 moves (min_moves_bfs.py), so
n <= 11 is UNSAT and n >= 12 is SAT.
*%

point(exit).
rect(red; beige; pink; yellow; orange; plum; purple; blue).

&eq(x(exit),6) :- &initial.
&eq(y(exit),4) :- &initial.

&eq(left_side(red),0) :- &initial.  &eq(width(red),2)  :- &initial.
&eq(bottom(red),3)    :- &initial.  &eq(height(red),1) :- &initial.

&eq(left_side(beige),0) :- &initial. &eq(width(beige),1)  :- &initial.
&eq(bottom(beige),0)    :- &initial. &eq(height(beige),2) :- &initial.

&eq(left_side(pink),1) :- &initial.  &eq(width(pink),2) :- &initial.
&eq(bottom(pink),0)    :- &initial. &eq(height(pink),1) :- &initial.

&eq(left_side(yellow),2) :- &initial.  &eq(width(yellow),1)  :- &initial.
&eq(bottom(yellow),1)    :- &initial.  &eq(height(yellow),3) :- &initial.

&eq(left_side(orange),3) :- &initial. &eq(width(orange),2)  :- &initial.
&eq(bottom(orange),1)    :- &initial. &eq(height(orange),1) :- &initial.

&eq(left_side(plum),3) :- &initial. &eq(width(plum),1)  :- &initial.
&eq(bottom(plum),2)    :- &initial. &eq(height(plum),2) :- &initial.

&eq(left_side(purple),5) :- &initial. &eq(width(purple),1)  :- &initial.
&eq(bottom(purple),1)    :- &initial. &eq(height(purple),3) :- &initial.

&eq(left_side(blue),2) :- &initial. &eq(width(blue),3)  :- &initial.
&eq(bottom(blue),4)    :- &initial. &eq(height(blue),1) :- &initial.

%%% car displacements
{&move_left(R);&move_right(R)}1 :- &horizontal(R), rect(R).
{&move_up(R);&move_down(R)}1 :- &vertical(R), rect(R).
:- &move(R1), &move(R2), rect(R1), rect(R2), R1 != R2.

% no cars can overlap
:- &overlap(R1,R2), rect(R1), rect(R2).

% the red car must reach the exit
:- &final, not &touches(red,exit).

