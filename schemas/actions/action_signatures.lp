% Central sort-signature dispatch for spatial actions.
% These predicates are internal; suffixes identify a supported signature.

action_move_p(O,K) :- true(point(O),K), time(K).
action_move_r(O,K) :- true(rect(O),K), time(K).

action_move_arg(O,K) :- action_move_p(O,K).
action_move_arg(O,K) :- action_move_r(O,K).

action_grows_r(O,K) :- true(rect(O),K), time(K).

valid_action_arg(&move(O),K) :- action_move_arg(O,K).
invalid_action_arg(&move(O)) :- formula(spatial, &move(O)), time(K),
                                not valid_action_arg(&move(O),K).

valid_action_arg(&move_right(O),K) :- action_move_arg(O,K).
invalid_action_arg(&move_right(O)) :- formula(spatial, &move_right(O)), time(K),
                                      not valid_action_arg(&move_right(O),K).

valid_action_arg(&move_left(O),K) :- action_move_arg(O,K).
invalid_action_arg(&move_left(O)) :- formula(spatial, &move_left(O)), time(K),
                                     not valid_action_arg(&move_left(O),K).

valid_action_arg(&move_up(O),K) :- action_move_arg(O,K).
invalid_action_arg(&move_up(O)) :- formula(spatial, &move_up(O)), time(K),
                                   not valid_action_arg(&move_up(O),K).

valid_action_arg(&move_down(O),K) :- action_move_arg(O,K).
invalid_action_arg(&move_down(O)) :- formula(spatial, &move_down(O)), time(K),
                                     not valid_action_arg(&move_down(O),K).

valid_action_arg(&move_up_right(O),K) :- action_move_arg(O,K).
invalid_action_arg(&move_up_right(O)) :- formula(spatial, &move_up_right(O)), time(K),
                                         not valid_action_arg(&move_up_right(O),K).

valid_action_arg(&move_up_left(O),K) :- action_move_arg(O,K).
invalid_action_arg(&move_up_left(O)) :- formula(spatial, &move_up_left(O)), time(K),
                                        not valid_action_arg(&move_up_left(O),K).

valid_action_arg(&move_down_right(O),K) :- action_move_arg(O,K).
invalid_action_arg(&move_down_right(O)) :- formula(spatial, &move_down_right(O)), time(K),
                                           not valid_action_arg(&move_down_right(O),K).

valid_action_arg(&move_down_left(O),K) :- action_move_arg(O,K).
invalid_action_arg(&move_down_left(O)) :- formula(spatial, &move_down_left(O)), time(K),
                                          not valid_action_arg(&move_down_left(O),K).

valid_action_arg(&grows(O),K) :- action_grows_r(O,K).
invalid_action_arg(&grows(O)) :- formula(spatial, &grows(O)), time(K),
                                 not valid_action_arg(&grows(O),K).
