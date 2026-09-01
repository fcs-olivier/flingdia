

%%%%%%%%%  POINT-LINE  %%%%%%%%%%%%%


%%%%%%%%%%%%%% left of a vertical line %%%%%%%%%%%%%
% The endpoint equality enforces verticality directly, without using
% vertical(L) as a sub-relation.
&sus{xstart(L,K)} = xend(L,K) :- true(&left(P,L),K), rel_left_pl(P,L,K).
&sus{x(P,K)} < xstart(L,K)    :- true(&left(P,L),K), rel_left_pl(P,L,K).

true(&left(P,L),K) :- formula(spatial, &left(P,L)),
                      &sus{xstart(L,K)} = xend(L,K),
                      &sus{x(P,K)} < xstart(L,K),
                      time(K), rel_left_pl(P,L,K).


%%%%%%%%%%%%%% right of a vertical line %%%%%%%%%%%%%
&sus{xstart(L,K)} = xend(L,K) :- true(&right(P,L),K), rel_right_pl(P,L,K).
&sus{x(P,K)} > xstart(L,K)    :- true(&right(P,L),K), rel_right_pl(P,L,K).

true(&right(P,L),K) :- formula(spatial, &right(P,L)),
                       &sus{xstart(L,K)} = xend(L,K),
                       &sus{x(P,K)} > xstart(L,K),
                       time(K), rel_right_pl(P,L,K).




%%%%%%%%%%%%%% on  %%%%%%%%%%%%%
% A point is on a finite horizontal, vertical, or +/-45-degree diagonal
% segment. The cases provide founded support when the relation is asserted.
on_h_pl(P,L,K) |
on_v_pl(P,L,K) |
on_diag_pos_pl(P,L,K) |
on_diag_neg_pl(P,L,K) :- true(&on(P,L),K), rel_on_pl(P,L,K).

on_x_start_end_pl(P,L,K) |
on_x_end_start_pl(P,L,K) :- on_h_pl(P,L,K).

on_x_start_end_pl(P,L,K) |
on_x_end_start_pl(P,L,K) :- on_diag_pos_pl(P,L,K).

on_x_start_end_pl(P,L,K) |
on_x_end_start_pl(P,L,K) :- on_diag_neg_pl(P,L,K).

on_y_start_end_pl(P,L,K) |
on_y_end_start_pl(P,L,K) :- on_v_pl(P,L,K).

% Orientation and collinearity
&sus{ystart(L,K)} = yend(L,K) :- on_h_pl(P,L,K).
&sus{y(P,K)} = ystart(L,K)    :- on_h_pl(P,L,K).

&sus{xstart(L,K)} = xend(L,K) :- on_v_pl(P,L,K).
&sus{x(P,K)} = xstart(L,K)    :- on_v_pl(P,L,K).

&sus{(xend(L,K)-xstart(L,K))} = (yend(L,K)-ystart(L,K)) :- on_diag_pos_pl(P,L,K).
&sus{(x(P,K)-xstart(L,K))} = (y(P,K)-ystart(L,K))       :- on_diag_pos_pl(P,L,K).

&sus{(xend(L,K)-xstart(L,K))} = (ystart(L,K)-yend(L,K)) :- on_diag_neg_pl(P,L,K).
&sus{(x(P,K)-xstart(L,K))} = (ystart(L,K)-y(P,K))       :- on_diag_neg_pl(P,L,K).

% Finite-segment bounds in either endpoint order
&sus{x(P,K)} >= xstart(L,K) :- on_x_start_end_pl(P,L,K).
&sus{x(P,K)} <= xend(L,K)   :- on_x_start_end_pl(P,L,K).

&sus{x(P,K)} >= xend(L,K)   :- on_x_end_start_pl(P,L,K).
&sus{x(P,K)} <= xstart(L,K) :- on_x_end_start_pl(P,L,K).

&sus{y(P,K)} >= ystart(L,K) :- on_y_start_end_pl(P,L,K).
&sus{y(P,K)} <= yend(L,K)   :- on_y_start_end_pl(P,L,K).

&sus{y(P,K)} >= yend(L,K)   :- on_y_end_start_pl(P,L,K).
&sus{y(P,K)} <= ystart(L,K) :- on_y_end_start_pl(P,L,K).

% Recover the qualitative cases from a numerical assignment
on_h_pl(P,L,K) :- formula(spatial, &on(P,L)),
                  &sus{ystart(L,K)} = yend(L,K),
                  &sus{y(P,K)} = ystart(L,K),
                  time(K), rel_on_pl(P,L,K).

on_v_pl(P,L,K) :- formula(spatial, &on(P,L)),
                  &sus{xstart(L,K)} = xend(L,K),
                  &sus{x(P,K)} = xstart(L,K),
                  time(K), rel_on_pl(P,L,K).

on_diag_pos_pl(P,L,K) :- formula(spatial, &on(P,L)),
                         &sus{(xend(L,K)-xstart(L,K))} = (yend(L,K)-ystart(L,K)),
                         &sus{(x(P,K)-xstart(L,K))} = (y(P,K)-ystart(L,K)),
                         time(K), rel_on_pl(P,L,K).

on_diag_neg_pl(P,L,K) :- formula(spatial, &on(P,L)),
                         &sus{(xend(L,K)-xstart(L,K))} = (ystart(L,K)-yend(L,K)),
                         &sus{(x(P,K)-xstart(L,K))} = (ystart(L,K)-y(P,K)),
                         time(K), rel_on_pl(P,L,K).

on_x_start_end_pl(P,L,K) :- formula(spatial, &on(P,L)),
                            &sus{x(P,K)} >= xstart(L,K),
                            &sus{x(P,K)} <= xend(L,K),
                            time(K), rel_on_pl(P,L,K).

on_x_end_start_pl(P,L,K) :- formula(spatial, &on(P,L)),
                            &sus{x(P,K)} >= xend(L,K),
                            &sus{x(P,K)} <= xstart(L,K),
                            time(K), rel_on_pl(P,L,K).

on_y_start_end_pl(P,L,K) :- formula(spatial, &on(P,L)),
                            &sus{y(P,K)} >= ystart(L,K),
                            &sus{y(P,K)} <= yend(L,K),
                            time(K), rel_on_pl(P,L,K).

on_y_end_start_pl(P,L,K) :- formula(spatial, &on(P,L)),
                            &sus{y(P,K)} >= yend(L,K),
                            &sus{y(P,K)} <= ystart(L,K),
                            time(K), rel_on_pl(P,L,K).

true(&on(P,L),K) :- formula(spatial, &on(P,L)),
                       on_h_pl(P,L,K), on_x_start_end_pl(P,L,K), time(K), rel_on_pl(P,L,K).
true(&on(P,L),K) :- formula(spatial, &on(P,L)),
                       on_h_pl(P,L,K), on_x_end_start_pl(P,L,K), time(K), rel_on_pl(P,L,K).
true(&on(P,L),K) :- formula(spatial, &on(P,L)),
                       on_v_pl(P,L,K), on_y_start_end_pl(P,L,K), time(K), rel_on_pl(P,L,K).
true(&on(P,L),K) :- formula(spatial, &on(P,L)),
                       on_v_pl(P,L,K), on_y_end_start_pl(P,L,K), time(K), rel_on_pl(P,L,K).
true(&on(P,L),K) :- formula(spatial, &on(P,L)),
                       on_diag_pos_pl(P,L,K), on_x_start_end_pl(P,L,K), time(K), rel_on_pl(P,L,K).
true(&on(P,L),K) :- formula(spatial, &on(P,L)),
                       on_diag_pos_pl(P,L,K), on_x_end_start_pl(P,L,K), time(K), rel_on_pl(P,L,K).
true(&on(P,L),K) :- formula(spatial, &on(P,L)),
                       on_diag_neg_pl(P,L,K), on_x_start_end_pl(P,L,K), time(K), rel_on_pl(P,L,K).
true(&on(P,L),K) :- formula(spatial, &on(P,L)),
                       on_diag_neg_pl(P,L,K), on_x_end_start_pl(P,L,K), time(K), rel_on_pl(P,L,K).

