% Central sort-signature dispatch for suffix-free spatial relations.
% These predicates are internal; suffixes identify a supported signature.

rel_horizontal_l(A,K) :- true(line(A),K), time(K).
rel_horizontal_r(A,K) :- true(rect(A),K), time(K).

rel_vertical_l(A,K) :- true(line(A),K), time(K).
rel_vertical_r(A,K) :- true(rect(A),K), time(K).

rel_diagonal_l(A,K) :- true(line(A),K), time(K).

rel_rightmost_p(A,K) :- true(point(A),K), time(K).
rel_rightmost_r(A,K) :- true(rect(A),K), time(K).

rel_leftmost_p(A,K) :- true(point(A),K), time(K).
rel_leftmost_r(A,K) :- true(rect(A),K), time(K).

rel_empty_r(A,K) :- true(rect(A),K), time(K).

rel_startsAt_lp(A,B,K) :- true(line(A),K), true(point(B),K), time(K).

rel_endsAt_lp(A,B,K) :- true(line(A),K), true(point(B),K), time(K).

rel_fromTo_lpp(A,B,C,K) :- true(line(A),K), true(point(B),K), true(point(C),K), time(K).

rel_on_pl(A,B,K) :- true(point(A),K), true(line(B),K), time(K).
rel_on_rl(A,B,K) :- true(rect(A),K), true(line(B),K), time(K).
rel_on_rr(A,B,K) :- true(rect(A),K), true(rect(B),K), time(K).

rel_left_pp(A,B,K) :- true(point(A),K), true(point(B),K), time(K).
rel_left_pr(A,B,K) :- true(point(A),K), true(rect(B),K), time(K).
rel_left_rr(A,B,K) :- true(rect(A),K), true(rect(B),K), time(K).

rel_right_pp(A,B,K) :- true(point(A),K), true(point(B),K), time(K).
rel_right_pr(A,B,K) :- true(point(A),K), true(rect(B),K), time(K).
rel_right_rr(A,B,K) :- true(rect(A),K), true(rect(B),K), time(K).

rel_alignedY_pp(A,B,K) :- true(point(A),K), true(point(B),K), time(K).
rel_alignedY_pr(A,B,K) :- true(point(A),K), true(rect(B),K), time(K).

rel_alignedYEq_pr(A,B,K) :- true(point(A),K), true(rect(B),K), time(K).

rel_samePlace_pp(A,B,K) :- true(point(A),K), true(point(B),K), time(K).

% Far currently has no numerical schema, but both historical uses are typed.
rel_far_pp(A,B,K) :- true(point(A),K), true(point(B),K), time(K).
rel_far_rr(A,B,K) :- true(rect(A),K), true(rect(B),K), time(K).

rel_in_pr(A,B,K) :- true(point(A),K), true(rect(B),K), time(K).

rel_inEq_pr(A,B,K) :- true(point(A),K), true(rect(B),K), time(K).

rel_out_pr(A,B,K) :- true(point(A),K), true(rect(B),K), time(K).

rel_touches_rp(A,B,K) :- true(rect(A),K), true(point(B),K), time(K).

rel_above_rr(A,B,K) :- true(rect(A),K), true(rect(B),K), time(K).

rel_below_rr(A,B,K) :- true(rect(A),K), true(rect(B),K), time(K).

rel_overlap_rr(A,B,K) :- true(rect(A),K), true(rect(B),K), time(K).

rel_ntpp_rr(A,B,K) :- true(rect(A),K), true(rect(B),K), time(K).

rel_disconnected_rr(A,B,K) :- true(rect(A),K), true(rect(B),K), time(K).

rel_discrete_rr(A,B,K) :- true(rect(A),K), true(rect(B),K), time(K).

rel_equal_rr(A,B,K) :- true(rect(A),K), true(rect(B),K), time(K).

rel_partialOverlap_rr(A,B,K) :- true(rect(A),K), true(rect(B),K), time(K).

rel_properPart_rr(A,B,K) :- true(rect(A),K), true(rect(B),K), time(K).

rel_extConnected_rr(A,B,K) :- true(rect(A),K), true(rect(B),K), time(K).

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
valid_relation_arg(&left(A,B),K) :- rel_left_rr(A,B,K).
invalid_relation_arg(&left(A,B)) :- formula(spatial, &left(A,B)), time(K), not valid_relation_arg(&left(A,B),K).

valid_relation_arg(&right(A,B),K) :- rel_right_pp(A,B,K).
valid_relation_arg(&right(A,B),K) :- rel_right_pr(A,B,K).
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

