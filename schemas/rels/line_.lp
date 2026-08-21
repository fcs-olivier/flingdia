&sus{ystart(L,K)}=yend(L,K) :- true(&horizontal_l(L),K).

true(&horizontal_l(L),K) :- formula(spatial, &horizontal_l(L)), &sus{ystart(L,K)}=yend(L,K), time(K).

invalid_relation_arg(&horizontal_l(L)) :- formula(spatial, &horizontal_l(L)),
                                         #count {valid_arg_1 : true(line(L),K)} != 1,
                                         time(K).

&sus{xstart(L,K)}=xend(L,K) :- true(&vertical_l(L),K).

true(&vertical_l(L),K) :- formula(spatial, &vertical_l(L)), &sus{xstart(L,K)}=xend(L,K), time(K).

invalid_relation_arg(&vertical_l(L)) :- formula(spatial, &vertical_l(L)),
                                         #count {valid_arg_1 : true(line(L),K)} != 1,
                                         time(K).

