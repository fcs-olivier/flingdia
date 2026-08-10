%*
Run from the flingdia_supportive folder:

metasp solve flingo --meta-config config.yaml \
                    --warn=no-atom-undefined \
                    --project=show \
                    bugs/integrity_const_ignored/integrity_const_ignored.lp  0 \
                    -c n=0

Expected: UNSATISFIABLE (a is left of b).
Actual:   SATISFIABLE — the constraint is dropped by the metasp transform.
See README.md for the explanation.

To inspect the bad externals:
  metasp transform --meta-config config.yaml \
    bugs/integrity_const_ignored/integrity_const_ignored.lp
*%


point(a;b).

&eq(x(a),0). &eq(y(a),0).
&eq(x(b),1). &eq(y(b),0).

% should fire — silently dropped (see README)
:- &left_pp(a,b).



%%%%%% OTHER EXAMPLE BUT THE PROBLEM DOES NOT OCCUR HERE
% &left_pp(a,b). / &left_pp(b,c). are heads: that path emits unguarded #external a. / b. / c..

% The constraint still becomes #external &right_pp(c,a): c, a. — but those 
% guards now succeed, so the formula is registered and the constraint fires. 
% The bug only bites when the body atom's arguments are never made head-true.
% point(a;b;c).

% &left_pp(a,b).
% &left_pp(b,c).
% :- &right_pp(c,a).

% Workaround (uncomment to recover UNSAT):
% :- not &not(&left_pp(a,b)).
