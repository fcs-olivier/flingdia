

%%%%%%%%%  POINT-LINE  %%%%%%%%%%%%%

%%%%%%%%%%%%%% on_pl  %%%%%%%%%%%%%
% A point is on a finite horizontal, vertical, or +/-45-degree diagonal
% segment. The cases provide founded support when the relation is asserted.
on_h_pl(P,L,K) |
on_v_pl(P,L,K) |
on_diag_pos_pl(P,L,K) |
on_diag_neg_pl(P,L,K) :- true(&on_pl(P,L),K).

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
on_h_pl(P,L,K) :- formula(spatial, &on_pl(P,L)),
                  &sus{ystart(L,K)} = yend(L,K),
                  &sus{y(P,K)} = ystart(L,K),
                  time(K).

on_v_pl(P,L,K) :- formula(spatial, &on_pl(P,L)),
                  &sus{xstart(L,K)} = xend(L,K),
                  &sus{x(P,K)} = xstart(L,K),
                  time(K).

on_diag_pos_pl(P,L,K) :- formula(spatial, &on_pl(P,L)),
                         &sus{(xend(L,K)-xstart(L,K))} = (yend(L,K)-ystart(L,K)),
                         &sus{(x(P,K)-xstart(L,K))} = (y(P,K)-ystart(L,K)),
                         time(K).

on_diag_neg_pl(P,L,K) :- formula(spatial, &on_pl(P,L)),
                         &sus{(xend(L,K)-xstart(L,K))} = (ystart(L,K)-yend(L,K)),
                         &sus{(x(P,K)-xstart(L,K))} = (ystart(L,K)-y(P,K)),
                         time(K).

on_x_start_end_pl(P,L,K) :- formula(spatial, &on_pl(P,L)),
                            &sus{x(P,K)} >= xstart(L,K),
                            &sus{x(P,K)} <= xend(L,K),
                            time(K).

on_x_end_start_pl(P,L,K) :- formula(spatial, &on_pl(P,L)),
                            &sus{x(P,K)} >= xend(L,K),
                            &sus{x(P,K)} <= xstart(L,K),
                            time(K).

on_y_start_end_pl(P,L,K) :- formula(spatial, &on_pl(P,L)),
                            &sus{y(P,K)} >= ystart(L,K),
                            &sus{y(P,K)} <= yend(L,K),
                            time(K).

on_y_end_start_pl(P,L,K) :- formula(spatial, &on_pl(P,L)),
                            &sus{y(P,K)} >= yend(L,K),
                            &sus{y(P,K)} <= ystart(L,K),
                            time(K).

true(&on_pl(P,L),K) :- formula(spatial, &on_pl(P,L)),
                       on_h_pl(P,L,K), on_x_start_end_pl(P,L,K), time(K).
true(&on_pl(P,L),K) :- formula(spatial, &on_pl(P,L)),
                       on_h_pl(P,L,K), on_x_end_start_pl(P,L,K), time(K).
true(&on_pl(P,L),K) :- formula(spatial, &on_pl(P,L)),
                       on_v_pl(P,L,K), on_y_start_end_pl(P,L,K), time(K).
true(&on_pl(P,L),K) :- formula(spatial, &on_pl(P,L)),
                       on_v_pl(P,L,K), on_y_end_start_pl(P,L,K), time(K).
true(&on_pl(P,L),K) :- formula(spatial, &on_pl(P,L)),
                       on_diag_pos_pl(P,L,K), on_x_start_end_pl(P,L,K), time(K).
true(&on_pl(P,L),K) :- formula(spatial, &on_pl(P,L)),
                       on_diag_pos_pl(P,L,K), on_x_end_start_pl(P,L,K), time(K).
true(&on_pl(P,L),K) :- formula(spatial, &on_pl(P,L)),
                       on_diag_neg_pl(P,L,K), on_x_start_end_pl(P,L,K), time(K).
true(&on_pl(P,L),K) :- formula(spatial, &on_pl(P,L)),
                       on_diag_neg_pl(P,L,K), on_x_end_start_pl(P,L,K), time(K).

invalid_relation_arg(&on_pl(P,L)) :- formula(spatial, &on_pl(P,L)),
                                     #count {valid_arg_1 : true(point(P),K);
                                             valid_arg_2 : true(line(L),K)} != 2,
                                     time(K).
