&sus{left_side(R1,K)}>=right_side(R2,K) :- true(&right_rr(R1,R2),K).

true(&right_rr(R1,R2),K) :- formula(spatial, &right_rr(R1,R2)),
                          &sus{left_side(R1,K)}>=right_side(R2,K), time(K).

invalid_relation_arg(&right_rr(R1,R2)) :- formula(spatial, &right_rr(R1,R2)), R1!=R2,
                                         #count {valid_arg_1 : true(rect(R1),K);
                                                 valid_arg_2 : true(rect(R2),K)} != 2,
                                                 time(K).

&sus{right_side(R1,K)}<=left_side(R2,K) :- true(&left_rr(R1,R2),K).

true(&left_rr(R1,R2),K) :- formula(spatial, &left_rr(R1,R2)),
                         &sus{right_side(R1,K)}<=left_side(R2,K), time(K).

invalid_relation_arg(&left_rr(R1,R2)) :- formula(spatial, &left_rr(R1,R2)), R1!=R2,
                                         #count {valid_arg_1 : true(rect(R1),K);
                                                 valid_arg_2 : true(rect(R2),K)} != 2,
                                                 time(K).
&sus{top(R1,K)}<=bottom(R2,K) :- true(&below_rr(R1,R2),K).

true(&below_rr(R1,R2),K) :- formula(spatial, &below_rr(R1,R2)),
                          &sus{top(R1,K)}<=bottom(R2,K), time(K).

invalid_relation_arg(&below_rr(R1,R2)) :- formula(spatial, &below_rr(R1,R2)), R1!=R2,
                                          #count {valid_arg_1 : true(rect(R1),K);
                                                  valid_arg_2 : true(rect(R2),K)} != 2,
                                                  time(K).
&sus{bottom(R1,K)}>=top(R2,K) :- true(&above_rr(R1,R2),K).

true(&above_rr(R1,R2),K) :- formula(spatial, &above_rr(R1,R2)),
                          &sus{bottom(R1,K)}>=top(R2,K), time(K).

invalid_relation_arg(&above_rr(R1,R2)) :- formula(spatial, &above_rr(R1,R2)), R1!=R2,
                                          #count {valid_arg_1 : true(rect(R1),K);
                                                  valid_arg_2 : true(rect(R2),K)} != 2,
                                                  time(K).
&sus{bottom(R1,K)} = top(R2,K)           :- true(&on_rr(R1,R2),K), R1 != R2.
&sus{right_side(R1,K)} > left_side(R2,K) :- true(&on_rr(R1,R2),K), R1 != R2.
&sus{left_side(R1,K)} < right_side(R2,K) :- true(&on_rr(R1,R2),K), R1 != R2.

true(&on_rr(R1,R2),K) :- formula(spatial, &on_rr(R1,R2)), R1 != R2,
                       &sus{bottom(R1,K)} = top(R2,K),
                       &sus{right_side(R1,K)} > left_side(R2,K),
                       &sus{left_side(R1,K)} < right_side(R2,K), time(K).

invalid_relation_arg(&on_rr(R1,R2)) :- formula(spatial, &on_rr(R1,R2)), R1!=R2,
                                       #count { valid_arg_1 : true(rect(R1),K);
                                                valid_arg_2 : true(rect(R2),K) } != 2,
                                                time(K).

