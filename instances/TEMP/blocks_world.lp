%*
metasp solve flingo --meta-config config.yaml \
                    --warn=no-atom-undefined \
                    --project=show \
                    instances/TEMP/blocks_world.lp  0 \
                    -c display_time=7  \
                    -c n=5 
*%


block(a;b;c).
rect(table;B):- block(B).

&eq(height(B),1) :- block(B).
&eq(width(B),1) :- block(B).
predefined(table).

&on(a,table):- &initial.
&on(b,a):- &initial.
&on(c,b):- &initial.

:- &final, not &on(a,b).
:- &final, not &on(b,c).
:- &final, not &on(c,table).

% no two rectangles can overlap
:- &overlap(R1,R2), rect(R1), rect(R2).

% blocks cannot levitate if they are not in motion or on a rectangle (block or table)
:- block(B), not &move(B), not &on(B,R): rect(R).

% a block cannot move if it is under another block
cannot_move(B1) :- block(B1), block(B2), &on(B2,B1).

% among all blocks that can move, we enable one of them to do so
0{&move(B):block(B), not cannot_move(B)}1.






