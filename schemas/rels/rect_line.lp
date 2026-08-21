&sus{xstart(L2,K)}<= left_side(R1,K) :- true(&on_rl(R1,L2),K).
&sus{xend(L2,K)}>= right_side(R1,K) :- true(&on_rl(R1,L2),K).
&sus{ystart(L2,K)}= bottom(R1,K) :- true(&on_rl(R1,L2),K).
:- true(&on_rl(R1,L2),K), not &sus{ystart(L2,K)}=yend(L2,K).  % the line must be horizontal

true(&on_rl(R1,L2),K) :- formula(spatial, &on_rl(R1,L2)),
                        &sus{ystart(L2,K)}=yend(L2,K),    % the line must be horizontal
                        &sus{xstart(L2,K)}<= left_side(R1,K),
                        &sus{xend(L2,K)}>= right_side(R1,K),
                        &sus{ystart(L2,K)}= bottom(R1,K),
                        time(K).

invalid_relation_arg(&on_rl(R1,L2)) :- formula(spatial, &on_rl(R1,L2)),
                                         #count {valid_arg_1 : true(rect(R1),K);
                                                 valid_arg_2 : true(line(L2),K)} != 2,
                                                 time(K).