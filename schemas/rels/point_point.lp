%# Point-point relations
%
% Relations between two points.

%*! alignedY_pp(P1,P2)

Points `P1` and `P2` have the same `y` coordinate.

![`&alignedY_pp`](../../assets/relations/alignedY_pp.svg)

*%

%*! left_pp(P1,P2)

Theory atom `&left_pp/2`: point `P1` is strictly to the left of point `P2`.

![`&left_pp`](../../assets/relations/left_pp.svg)
*%

%*! right_pp(P1,P2)

Theory atom `&right_pp/2`: point `P1` is strictly to the right of point `P2`.

![`&right_pp`](../../assets/relations/right_pp.svg)
*%



%*! samePlace_pp(P1,P2)

Theory atom `&samePlace_pp/2`: distinct points `P1` and `P2` occupy the same position.

![`&samePlace_pp`](../../assets/relations/samePlace_pp.svg)
*%

%## `&alignedY_pp`
&sus{y(P1,K)} = y(P2,K) :- true(&alignedY_pp(P1,P2),K).

true(&alignedY_pp(P1,P2),K) :- formula(spatial, &alignedY_pp(P1,P2)), &sus{y(P1,K)} = y(P2,K), time(K).

invalid_relation_arg(&alignedY_pp(P1,P2)) :- formula(spatial, &alignedY_pp(P1,P2)),
                                         #count {valid_arg_1 : true(point(P1),K);
                                                 valid_arg_2 : true(point(P2),K)} != 2,
                                                 time(K).

%## `&left_pp`
&sus{x(P1,K)} < x(P2,K) :- true(&left_pp(P1,P2),K).

true(&left_pp(P1,P2),K) :- formula(spatial, &left_pp(P1,P2)), P1!=P2, &sus{x(P1,K)} < x(P2,K), time(K).

invalid_relation_arg(&left_pp(P1,P2)) :- formula(spatial, &left_pp(P1,P2)),
                                         #count {valid_arg_1 : true(point(P1),K);
                                                 valid_arg_2 : true(point(P2),K)} != 2,
                                                 time(K).

%## `&right_pp`
&sus{x(P1,K)} > x(P2,K) :- true(&right_pp(P1,P2),K).

true(&right_pp(P1,P2),K) :- formula(spatial, &right_pp(P1,P2)), P1!=P2, &sus{x(P1,K)} > x(P2,K), time(K).

invalid_relation_arg(&right_pp(P1,P2)) :- formula(spatial, &right_pp(P1,P2)),
                                         #count {valid_arg_1 : true(point(P1),K);
                                                 valid_arg_2 : true(point(P2),K)} != 2,
                                                 time(K).



%## `&samePlace_pp`
&sus{x(P1,K)}=x(P2,K) :- true(&samePlace_pp(P1,P2),K), P1!=P2.
&sus{y(P1,K)}=y(P2,K) :- true(&samePlace_pp(P1,P2),K), P1!=P2.

true(&samePlace_pp(P1,P2),K) :- formula(spatial, &samePlace_pp(P1,P2)), P1!=P2,
                              &sus{x(P1,K)}=x(P2,K), &sus{y(P1,K)}=y(P2,K), time(K).

invalid_relation_arg(&samePlace_pp(P1,P2)) :- formula(spatial, &samePlace_pp(P1,P2)),
                                         #count {valid_arg_1 : true(point(P1),K);
                                                 valid_arg_2 : true(point(P2),K)} != 2,
                                                 time(K).
