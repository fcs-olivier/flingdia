%*
metasp solve flingo --meta-config config.yaml \
                    --warn=no-atom-undefined \
                    instances/ST/rush_hour.lp  1 \
                    -c display_time=7  \
                    --project=show \
                    -c n=3 \
                    -c xmax=6 \
                    -c ymax=6 
*%

&inertia.
&df :- &initial.

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

% vertical cars move up/down, horizontal cars move right/left. 
0{&move_right(R);&move_left(R)}1 :- &horizontal_r(R), rect(R).
0{&move_up(R);&move_down(R)}1 :- &vertical_r(R), rect(R).

% no cars can overlap
:- &overlap_rr(R1,R2), rect(R1), rect(R2).

% at most one car can move in each time step
%:- &move(R1), &move(R2), rect(R1), rect(R2), R1 != R2.
:- {&move(R): rect(R)}>1.


% the red car must reach the exit
:- &final, not &touches_rp(blue,exit).   % WORKS FINE WITH MORE SIMPLE GOAL BLUE
%:- &final, not &inEq_pr(exit, red).

%:- &final, not &touches_rp(red,exit).
%:- &final, not &inEq_pr(exit, red).

