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
:- &left(a,b).



%%%%%% OTHER EXAMPLE BUT THE PROBLEM DOES NOT OCCUR HERE
% &left(a,b). / &left(b,c). are heads: that path emits unguarded #external a. / b. / c..

% The constraint still becomes #external &right(c,a): c, a. — but those 
% guards now succeed, so the formula is registered and the constraint fires. 
% The bug only bites when the body atom's arguments are never made head-true.
% point(a;b;c).

% &left(a,b).
% &left(b,c).
% :- &right(c,a).

% Workaround (uncomment to recover UNSAT):
% :- not &not(&left(a,b)).
