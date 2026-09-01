% Central sort-signature dispatch for suffix-free spatial relations.
% These predicates are internal; suffixes identify a supported signature.

rel_horizontal_l(L,K) :- formula(spatial, &horizontal(L)), true(line(L),K), time(K).
rel_horizontal_r(R,K) :- formula(spatial, &horizontal(R)), true(rect(R),K), time(K).

rel_vertical_l(L,K) :- formula(spatial, &vertical(L)), true(line(L),K), time(K).
rel_vertical_r(R,K) :- formula(spatial, &vertical(R)), true(rect(R),K), time(K).

rel_diagonal_l(L,K) :- formula(spatial, &diagonal(L)), true(line(L),K), time(K).

rel_rightmost_p(P,K) :- formula(spatial, &rightmost(P)), true(point(P),K), time(K).
rel_rightmost_r(R,K) :- formula(spatial, &rightmost(R)), true(rect(R),K), time(K).

rel_leftmost_p(P,K) :- formula(spatial, &leftmost(P)), true(point(P),K), time(K).
rel_leftmost_r(R,K) :- formula(spatial, &leftmost(R)), true(rect(R),K), time(K).

rel_empty_r(R,K) :- formula(spatial, &empty(R)), true(rect(R),K), time(K).

rel_startsAt_lp(L,P,K) :- formula(spatial, &startsAt(L,P)), true(line(L),K), true(point(P),K), time(K).

rel_endsAt_lp(L,P,K) :- formula(spatial, &endsAt(L,P)), true(line(L),K), true(point(P),K), time(K).

rel_fromTo_lpp(L,P1,P2,K) :- formula(spatial, &fromTo(L,P1,P2)), true(line(L),K), true(point(P1),K), true(point(P2),K), time(K).

rel_on_pl(P,L,K) :- formula(spatial, &on(P,L)), true(point(P),K), true(line(L),K), time(K).
rel_on_rl(R,L,K) :- formula(spatial, &on(R,L)), true(rect(R),K), true(line(L),K), time(K).
rel_on_rr(R1,R2,K) :- formula(spatial, &on(R1,R2)), true(rect(R1),K), true(rect(R2),K), time(K).

rel_left_pp(P1,P2,K) :- formula(spatial, &left(P1,P2)), true(point(P1),K), true(point(P2),K), time(K).
rel_left_pr(P,R,K) :- formula(spatial, &left(P,R)), true(point(P),K), true(rect(R),K), time(K).
rel_left_pl(P,L,K) :- formula(spatial, &left(P,L)), true(point(P),K), true(line(L),K), time(K).
rel_left_rr(R1,R2,K) :- formula(spatial, &left(R1,R2)), true(rect(R1),K), true(rect(R2),K), time(K).

rel_right_pp(P1,P2,K) :- formula(spatial, &right(P1,P2)), true(point(P1),K), true(point(P2),K), time(K).
rel_right_pr(P,R,K) :- formula(spatial, &right(P,R)), true(point(P),K), true(rect(R),K), time(K).
rel_right_pl(P,L,K) :- formula(spatial, &right(P,L)), true(point(P),K), true(line(L),K), time(K).
rel_right_rr(R1,R2,K) :- formula(spatial, &right(R1,R2)), true(rect(R1),K), true(rect(R2),K), time(K).

rel_alignedY_pp(P1,P2,K) :- formula(spatial, &alignedY(P1,P2)), true(point(P1),K), true(point(P2),K), time(K).
rel_alignedY_pr(P,R,K) :- formula(spatial, &alignedY(P,R)), true(point(P),K), true(rect(R),K), time(K).

rel_alignedYEq_pr(P,R,K) :- formula(spatial, &alignedYEq(P,R)), true(point(P),K), true(rect(R),K), time(K).

rel_samePlace_pp(P1,P2,K) :- formula(spatial, &samePlace(P1,P2)), true(point(P1),K), true(point(P2),K), time(K).

% Far currently has no numerical schema, but both historical uses are typed.
rel_far_pp(P1,P2,K) :- formula(spatial, &far(P1,P2)), true(point(P1),K), true(point(P2),K), time(K).
rel_far_rr(R1,R2,K) :- formula(spatial, &far(R1,R2)), true(rect(R1),K), true(rect(R2),K), time(K).

rel_in_pr(P,R,K) :- formula(spatial, &in(P,R)), true(point(P),K), true(rect(R),K), time(K).

rel_inEq_pr(P,R,K) :- formula(spatial, &inEq(P,R)), true(point(P),K), true(rect(R),K), time(K).

rel_out_pr(P,R,K) :- formula(spatial, &out(P,R)), true(point(P),K), true(rect(R),K), time(K).

rel_touches_rp(R,P,K) :- formula(spatial, &touches(R,P)), true(rect(R),K), true(point(P),K), time(K).

rel_above_rr(R1,R2,K) :- formula(spatial, &above(R1,R2)), true(rect(R1),K), true(rect(R2),K), time(K).

rel_below_rr(R1,R2,K) :- formula(spatial, &below(R1,R2)), true(rect(R1),K), true(rect(R2),K), time(K).

rel_overlap_rr(R1,R2,K) :- formula(spatial, &overlap(R1,R2)), true(rect(R1),K), true(rect(R2),K), time(K).

rel_ntpp_rr(R1,R2,K) :- formula(spatial, &ntpp(R1,R2)), true(rect(R1),K), true(rect(R2),K), time(K).

rel_disconnected_rr(R1,R2,K) :- formula(spatial, &disconnected(R1,R2)), true(rect(R1),K), true(rect(R2),K), time(K).

rel_discrete_rr(R1,R2,K) :- formula(spatial, &discrete(R1,R2)), true(rect(R1),K), true(rect(R2),K), time(K).

rel_equal_rr(R1,R2,K) :- formula(spatial, &equal(R1,R2)), true(rect(R1),K), true(rect(R2),K), time(K).

rel_partialOverlap_rr(R1,R2,K) :- formula(spatial, &partialOverlap(R1,R2)), true(rect(R1),K), true(rect(R2),K), time(K).

rel_properPart_rr(R1,R2,K) :- formula(spatial, &properPart(R1,R2)), true(rect(R1),K), true(rect(R2),K), time(K).

rel_extConnected_rr(R1,R2,K) :- formula(spatial, &extConnected(R1,R2)), true(rect(R1),K), true(rect(R2),K), time(K).

% A relation argument tuple is valid when at least one overload matches.
valid_relation_arg(&horizontal(A),K) :- rel_horizontal_l(A,K).
valid_relation_arg(&horizontal(A),K) :- rel_horizontal_r(A,K).
invalid_relation_arg(&horizontal(A)) :- formula(spatial, &horizontal(A)), time(K), not valid_relation_arg(&horizontal(A),K).

valid_relation_arg(&vertical(A),K) :- rel_vertical_l(A,K).
valid_relation_arg(&vertical(A),K) :- rel_vertical_r(A,K).
invalid_relation_arg(&vertical(A)) :- formula(spatial, &vertical(A)), time(K), not valid_relation_arg(&vertical(A),K).

valid_relation_arg(&diagonal(A),K) :- rel_diagonal_l(A,K).
invalid_relation_arg(&diagonal(A)) :- formula(spatial, &diagonal(A)), time(K), not valid_relation_arg(&diagonal(A),K).

valid_relation_arg(&rightmost(A),K) :- rel_rightmost_p(A,K).
valid_relation_arg(&rightmost(A),K) :- rel_rightmost_r(A,K).
invalid_relation_arg(&rightmost(A)) :- formula(spatial, &rightmost(A)), time(K), not valid_relation_arg(&rightmost(A),K).

valid_relation_arg(&leftmost(A),K) :- rel_leftmost_p(A,K).
valid_relation_arg(&leftmost(A),K) :- rel_leftmost_r(A,K).
invalid_relation_arg(&leftmost(A)) :- formula(spatial, &leftmost(A)), time(K), not valid_relation_arg(&leftmost(A),K).

valid_relation_arg(&empty(A),K) :- rel_empty_r(A,K).
invalid_relation_arg(&empty(A)) :- formula(spatial, &empty(A)), time(K), not valid_relation_arg(&empty(A),K).

valid_relation_arg(&startsAt(A,B),K) :- rel_startsAt_lp(A,B,K).
invalid_relation_arg(&startsAt(A,B)) :- formula(spatial, &startsAt(A,B)), time(K), not valid_relation_arg(&startsAt(A,B),K).

valid_relation_arg(&endsAt(A,B),K) :- rel_endsAt_lp(A,B,K).
invalid_relation_arg(&endsAt(A,B)) :- formula(spatial, &endsAt(A,B)), time(K), not valid_relation_arg(&endsAt(A,B),K).

valid_relation_arg(&fromTo(A,B,C),K) :- rel_fromTo_lpp(A,B,C,K).
invalid_relation_arg(&fromTo(A,B,C)) :- formula(spatial, &fromTo(A,B,C)), time(K), not valid_relation_arg(&fromTo(A,B,C),K).

valid_relation_arg(&on(A,B),K) :- rel_on_pl(A,B,K).
valid_relation_arg(&on(A,B),K) :- rel_on_rl(A,B,K).
valid_relation_arg(&on(A,B),K) :- rel_on_rr(A,B,K).
invalid_relation_arg(&on(A,B)) :- formula(spatial, &on(A,B)), time(K), not valid_relation_arg(&on(A,B),K).

valid_relation_arg(&left(A,B),K) :- rel_left_pp(A,B,K).
valid_relation_arg(&left(A,B),K) :- rel_left_pr(A,B,K).
valid_relation_arg(&left(A,B),K) :- rel_left_pl(A,B,K).
valid_relation_arg(&left(A,B),K) :- rel_left_rr(A,B,K).
invalid_relation_arg(&left(A,B)) :- formula(spatial, &left(A,B)), time(K), not valid_relation_arg(&left(A,B),K).

valid_relation_arg(&right(A,B),K) :- rel_right_pp(A,B,K).
valid_relation_arg(&right(A,B),K) :- rel_right_pr(A,B,K).
valid_relation_arg(&right(A,B),K) :- rel_right_pl(A,B,K).
valid_relation_arg(&right(A,B),K) :- rel_right_rr(A,B,K).
invalid_relation_arg(&right(A,B)) :- formula(spatial, &right(A,B)), time(K), not valid_relation_arg(&right(A,B),K).

valid_relation_arg(&alignedY(A,B),K) :- rel_alignedY_pp(A,B,K).
valid_relation_arg(&alignedY(A,B),K) :- rel_alignedY_pr(A,B,K).
invalid_relation_arg(&alignedY(A,B)) :- formula(spatial, &alignedY(A,B)), time(K), not valid_relation_arg(&alignedY(A,B),K).

valid_relation_arg(&alignedYEq(A,B),K) :- rel_alignedYEq_pr(A,B,K).
invalid_relation_arg(&alignedYEq(A,B)) :- formula(spatial, &alignedYEq(A,B)), time(K), not valid_relation_arg(&alignedYEq(A,B),K).

valid_relation_arg(&samePlace(A,B),K) :- rel_samePlace_pp(A,B,K).
invalid_relation_arg(&samePlace(A,B)) :- formula(spatial, &samePlace(A,B)), time(K), not valid_relation_arg(&samePlace(A,B),K).

valid_relation_arg(&far(A,B),K) :- rel_far_pp(A,B,K).
valid_relation_arg(&far(A,B),K) :- rel_far_rr(A,B,K).
invalid_relation_arg(&far(A,B)) :- formula(spatial, &far(A,B)), time(K), not valid_relation_arg(&far(A,B),K).

valid_relation_arg(&in(A,B),K) :- rel_in_pr(A,B,K).
invalid_relation_arg(&in(A,B)) :- formula(spatial, &in(A,B)), time(K), not valid_relation_arg(&in(A,B),K).

valid_relation_arg(&inEq(A,B),K) :- rel_inEq_pr(A,B,K).
invalid_relation_arg(&inEq(A,B)) :- formula(spatial, &inEq(A,B)), time(K), not valid_relation_arg(&inEq(A,B),K).

valid_relation_arg(&out(A,B),K) :- rel_out_pr(A,B,K).
invalid_relation_arg(&out(A,B)) :- formula(spatial, &out(A,B)), time(K), not valid_relation_arg(&out(A,B),K).

valid_relation_arg(&touches(A,B),K) :- rel_touches_rp(A,B,K).
invalid_relation_arg(&touches(A,B)) :- formula(spatial, &touches(A,B)), time(K), not valid_relation_arg(&touches(A,B),K).

valid_relation_arg(&above(A,B),K) :- rel_above_rr(A,B,K).
invalid_relation_arg(&above(A,B)) :- formula(spatial, &above(A,B)), time(K), not valid_relation_arg(&above(A,B),K).

valid_relation_arg(&below(A,B),K) :- rel_below_rr(A,B,K).
invalid_relation_arg(&below(A,B)) :- formula(spatial, &below(A,B)), time(K), not valid_relation_arg(&below(A,B),K).

valid_relation_arg(&overlap(A,B),K) :- rel_overlap_rr(A,B,K).
invalid_relation_arg(&overlap(A,B)) :- formula(spatial, &overlap(A,B)), time(K), not valid_relation_arg(&overlap(A,B),K).

valid_relation_arg(&ntpp(A,B),K) :- rel_ntpp_rr(A,B,K).
invalid_relation_arg(&ntpp(A,B)) :- formula(spatial, &ntpp(A,B)), time(K), not valid_relation_arg(&ntpp(A,B),K).

valid_relation_arg(&disconnected(A,B),K) :- rel_disconnected_rr(A,B,K).
invalid_relation_arg(&disconnected(A,B)) :- formula(spatial, &disconnected(A,B)), time(K), not valid_relation_arg(&disconnected(A,B),K).

valid_relation_arg(&discrete(A,B),K) :- rel_discrete_rr(A,B,K).
invalid_relation_arg(&discrete(A,B)) :- formula(spatial, &discrete(A,B)), time(K), not valid_relation_arg(&discrete(A,B),K).

valid_relation_arg(&equal(A,B),K) :- rel_equal_rr(A,B,K).
invalid_relation_arg(&equal(A,B)) :- formula(spatial, &equal(A,B)), time(K), not valid_relation_arg(&equal(A,B),K).

valid_relation_arg(&partialOverlap(A,B),K) :- rel_partialOverlap_rr(A,B,K).
invalid_relation_arg(&partialOverlap(A,B)) :- formula(spatial, &partialOverlap(A,B)), time(K), not valid_relation_arg(&partialOverlap(A,B),K).

valid_relation_arg(&properPart(A,B),K) :- rel_properPart_rr(A,B,K).
invalid_relation_arg(&properPart(A,B)) :- formula(spatial, &properPart(A,B)), time(K), not valid_relation_arg(&properPart(A,B),K).

valid_relation_arg(&extConnected(A,B),K) :- rel_extConnected_rr(A,B,K).
invalid_relation_arg(&extConnected(A,B)) :- formula(spatial, &extConnected(A,B)), time(K), not valid_relation_arg(&extConnected(A,B),K).

