
%%%%%%%%%  RECT  %%%%%%%%%%%%%


%%%%%%%%%%%%%%% leftmost_r  %%%%%%%%%%%%%
:- true(&leftmost_r(R1),T), #count{R2 : true(&left_rr(R2,R1),T), true(rect(R2),T)}!=0.

true(&leftmost_r(R1),T) :- formula(spatial, &leftmost_r(R1)),
                        #count{R2 : true(&left_rr(R2,R1),T), true(rect(R2),T)}=0, time(T).


invalid_relation_arg(&leftmost_r(R1)) :- formula(spatial, &leftmost_r(R1)),
                                         #count {valid_arg_1 : true(rect(R1),T)} != 1,
                                         time(T).



%%%%%%% rightmost_r  %%%%%%%%%%%%%
:- true(&rightmost_r(R1),T), #count{R2 : true(&right_rr(R2,R1),T), true(rect(R2),T)}!=0.

true(&rightmost_r(R1),T) :- formula(spatial, &rightmost_r(R1)),
                        #count{R2 : true(&right_rr(R2,R1),T), true(rect(R2),T)}=0, time(T).


invalid_relation_arg(&rightmost_r(R1)) :- formula(spatial, &rightmost_r(R1)),
                                         #count {valid_arg_1 : true(rect(R1),T)} != 1,
                                         time(T).


%%%%%%% horizontal_r  %%%%%%%%%%%%%
&sus{width(R,T)} > height(R,T) :- true(&horizontal_r(R),T), true(rect(R),T), time(T).

true(&horizontal_r(R),T) :- formula(spatial, &horizontal_r(R)), 
                            true(rect(R),T), 
                            &sus{width(R,T)} > height(R,T), time(T).

invalid_relation_arg(&horizontal_r(R)) :- formula(spatial, &horizontal_r(R)), 
                                          #count { valid_arg_1 : true(rect(R),T) } != 1, time(T).

%%%%%%% vertical_r  %%%%%%%%%%%%%
&sus{height(R,T)} > width(R,T) :- true(&vertical_r(R),T), true(rect(R),T), time(T).

true(&vertical_r(R),T) :- formula(spatial, &vertical_r(R)), 
                          true(rect(R),T), &sus{height(R,T)} > width(R,T), time(T).

invalid_relation_arg(&vertical_r(R)) :- formula(spatial, &vertical_r(R)), 
                                        #count { valid_arg_1 : true(rect(R),T) } != 1, time(T).



%%%%%%% empty_r  %%%%%%%%%%
:- true(&empty_r(R1),T), not discrete_rr(R1,R2,T), true(rect(R2),T), R1!=R2, time(T).

discrete_rr(R1,R2,T):- formula(spatial, &empty_r(R1)), true(rect(R2),T), &sus{left_side(R1,T)}>=right_side(R2,T), R1!=R2, time(T). 
discrete_rr(R1,R2,T):- formula(spatial, &empty_r(R1)), true(rect(R2),T), &sus{bottom(R1,T)} >= top(R2,T), R1!=R2, time(T).
discrete_rr(R1,R2,T):- formula(spatial, &empty_r(R1)), true(rect(R2),T), &sus{right_side(R1,T)} <= left_side(R2,T), R1!=R2, time(T).
discrete_rr(R1,R2,T):- formula(spatial, &empty_r(R1)), true(rect(R2),T), &sus{top(R1,T)} <= bottom(R2,T), R1!=R2, time(T).


true(&empty_r(R1),T) :-  time(T), true(rect(R1),T), discrete_rr(R1,R2,T): true(rect(R2),T), R1!=R2.

invalid_relation_arg(&empty_r(R)) :- formula(spatial, &empty_r(R)), 
                                        #count { valid_arg_1 : true(rect(R),T) } != 1, time(T).
                         

