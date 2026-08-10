%*
Run from the flingdia_supportive folder:

metasp solve flingo --meta-config config.yaml \
                    --warn=no-atom-undefined \
                    bugs/disjunctive_head_give_support/disjunctive_head_give_support.lp  1 \
                    -c display_time=5 \
                    -c n=1

Expected: UNSATISFIABLE (nothing can move: no &move, inertia on).
Actual:   SATISFIABLE — b teleports from left_side=0 to left_side=7 in one step.
See README.md for the explanation.
*%

&inertia.

rect(a;b).

% everything pinned at the initial state. Rect 'b' starts to the left of rect 'a'. 
&eq(left_side(a),4) :- &initial.
&eq(bottom(a),0)    :- &initial.
&eq(width(a),2)     :- &initial.
&eq(height(a),2)    :- &initial.

&eq(left_side(b),0) :- &initial.
&eq(bottom(b),5)    :- &initial.   % vertically disconnected from a (this is essential, see README)
&eq(width(b),2)     :- &initial.
&eq(height(b),2)    :- &initial.

% invariant at every state, relation only in a constraint body
:- not &disconnected_rr(a,b).  % BUG: found params. If I remove this, it correctly becomes UNSAT.  

% pressure: at the final state b must be to the RIGHT of a (needs left_side(b) >= 6)
:- &final, not &right_rr(b,a).
