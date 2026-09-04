%*
Checks that the 8-way choice of schemas/actions/move.lp cannot smuggle in a
direction the instance never allowed, even though

    {8 directions}=1 :- true(&move(O),I), action_move_arg(O,I), I < n.
    true(&move(O),I) :- true(&move_up_right(O),I), action_move_arg(O,I).

form a positive loop through a choice-rule head. Expected: UNSATISFIABLE.

Run against the generated solver input (any previous solve leaves it in out/):

  cd ../..
  python3 -m flingo out/metasp_combined.lp out/syntax_facts.lp \
      bugs/hash_seed_nondeterminism/no_diagonal_check.lp 1 \
      -c n=3 -c xmax=6 -c ymax=6

Note the __ prefixes: this file talks to the rewritten semantics, not to the
instance language.
*%

diag(O,I) :- true(__move_up_right(O),I).
diag(O,I) :- true(__move_up_left(O),I).
diag(O,I) :- true(__move_down_right(O),I).
diag(O,I) :- true(__move_down_left(O),I).

wrong_dir(O,I) :- true(__move_up(O),I),    true(__horizontal(O),I).
wrong_dir(O,I) :- true(__move_down(O),I),  true(__horizontal(O),I).
wrong_dir(O,I) :- true(__move_right(O),I), true(__vertical(O),I).
wrong_dir(O,I) :- true(__move_left(O),I),  true(__vertical(O),I).

some_diag :- diag(_,_).
:- not some_diag.

#show diag/2.
#show wrong_dir/2.
