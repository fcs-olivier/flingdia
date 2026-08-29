

%%%%%%%%%  LINE-POINT  %%%%%%%%%%%%%

%%%%%%%%%%%%%% startsAt_lp  %%%%%%%%%%%%%
&sus{xstart(L,K)} = x(P,K) :- true(&startsAt_lp(L,P),K).
&sus{ystart(L,K)} = y(P,K) :- true(&startsAt_lp(L,P),K).

true(&startsAt_lp(L,P),K) :- formula(spatial, &startsAt_lp(L,P)),
                             &sus{xstart(L,K)} = x(P,K),
                             &sus{ystart(L,K)} = y(P,K),
                             time(K).

invalid_relation_arg(&startsAt_lp(L,P)) :- formula(spatial, &startsAt_lp(L,P)),
                                           #count {valid_arg_1 : true(line(L),K);
                                                   valid_arg_2 : true(point(P),K)} != 2,
                                           time(K).

%%%%%%%%%%%%%% endsAt_lp  %%%%%%%%%%%%%
&sus{xend(L,K)} = x(P,K) :- true(&endsAt_lp(L,P),K).
&sus{yend(L,K)} = y(P,K) :- true(&endsAt_lp(L,P),K).

true(&endsAt_lp(L,P),K) :- formula(spatial, &endsAt_lp(L,P)),
                           &sus{xend(L,K)} = x(P,K),
                           &sus{yend(L,K)} = y(P,K),
                           time(K).

invalid_relation_arg(&endsAt_lp(L,P)) :- formula(spatial, &endsAt_lp(L,P)),
                                         #count {valid_arg_1 : true(line(L),K);
                                                 valid_arg_2 : true(point(P),K)} != 2,
                                         time(K).

%%%%%%%%%%%%%% fromTo_lpp  %%%%%%%%%%%%%
&sus{xstart(L,K)} = x(P1,K) :- true(&fromTo_lpp(L,P1,P2),K).
&sus{ystart(L,K)} = y(P1,K) :- true(&fromTo_lpp(L,P1,P2),K).
&sus{xend(L,K)} = x(P2,K)   :- true(&fromTo_lpp(L,P1,P2),K).
&sus{yend(L,K)} = y(P2,K)   :- true(&fromTo_lpp(L,P1,P2),K).

true(&fromTo_lpp(L,P1,P2),K) :- formula(spatial, &fromTo_lpp(L,P1,P2)),
                                 &sus{xstart(L,K)} = x(P1,K),
                                 &sus{ystart(L,K)} = y(P1,K),
                                 &sus{xend(L,K)} = x(P2,K),
                                 &sus{yend(L,K)} = y(P2,K),
                                 time(K).

invalid_relation_arg(&fromTo_lpp(L,P1,P2)) :- formula(spatial, &fromTo_lpp(L,P1,P2)),
                                              #count {valid_arg_1 : true(line(L),K);
                                                      valid_arg_2 : true(point(P1),K);
                                                      valid_arg_3 : true(point(P2),K)} != 3,
                                              time(K).

