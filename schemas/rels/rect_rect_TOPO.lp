%%% RECT RECT

%# `overlap(R1,R2)`
%
% Rectangles `R1` and `R2` overlap when both horizontal and vertical intervals overlap strictly.
% This includes partial overlap, proper-part, and equal geometries, but excludes boundary-only contact.
%
% ![`&overlap`](../../assets/relations/overlap_rr.svg)
%
&sus{left_side(R1,T)}<right_side(R2,T)  :- true(&overlap(R1,R2),T), R1!=R2, rel_overlap_rr(R1,R2,T).
&sus{bottom(R1,T)}<top(R2,T)            :- true(&overlap(R1,R2),T), R1!=R2, rel_overlap_rr(R1,R2,T).
&sus{right_side(R1,T)}>left_side(R2,T)  :- true(&overlap(R1,R2),T), R1!=R2, rel_overlap_rr(R1,R2,T).
&sus{top(R1,T)}>bottom(R2,T)            :- true(&overlap(R1,R2),T), R1!=R2, rel_overlap_rr(R1,R2,T).
true(&overlap(R1,R2),T) :- formula(spatial, &overlap(R1,R2)), R1!=R2,
                            &sus{left_side(R1,T)}<right_side(R2,T),
                            &sus{bottom(R1,T)}<top(R2,T),
                            &sus{right_side(R1,T)}>left_side(R2,T),
                            &sus{top(R1,T)}>bottom(R2,T), time(T), rel_overlap_rr(R1,R2,T).


%# `partialOverlap(R1,R2)`
%
% Rectangles `R1` and `R2` overlap with positive area, and each extends outside the other in at least one direction.
% Thus neither rectangle is a part of the other.
%
% ![`&partialOverlap`](../../assets/relations/partialOverlap_rr.svg)
%
&sus{left_side(R1,T)}<right_side(R2,T)  :- true(&partialOverlap(R1,R2),T), R1!=R2, rel_partialOverlap_rr(R1,R2,T).
&sus{bottom(R1,T)}<top(R2,T)            :- true(&partialOverlap(R1,R2),T), R1!=R2, rel_partialOverlap_rr(R1,R2,T).
&sus{right_side(R1,T)}>left_side(R2,T)  :- true(&partialOverlap(R1,R2),T), R1!=R2, rel_partialOverlap_rr(R1,R2,T).
&sus{top(R1,T)}>bottom(R2,T)            :- true(&partialOverlap(R1,R2),T), R1!=R2, rel_partialOverlap_rr(R1,R2,T).
po_left_out_rr(R1,R2,T)|
    po_right_out_rr(R1,R2,T)|
    po_bottom_out_rr(R1,R2,T)|
    po_top_out_rr(R1,R2,T) :-  true(&partialOverlap(R1,R2),T), R1!=R2, rel_partialOverlap_rr(R1,R2,T).
po_left_out_rr(R2,R1,T)|
    po_right_out_rr(R2,R1,T)|
    po_bottom_out_rr(R2,R1,T)|
    po_top_out_rr(R2,R1,T) :-  true(&partialOverlap(R1,R2),T), R1!=R2, rel_partialOverlap_rr(R1,R2,T).
&sus{left_side(R1,T)}<left_side(R2,T)   :- po_left_out_rr(R1,R2,T).
&sus{right_side(R1,T)}>right_side(R2,T) :- po_right_out_rr(R1,R2,T).
&sus{bottom(R1,T)}<bottom(R2,T)         :- po_bottom_out_rr(R1,R2,T).
&sus{top(R1,T)}>top(R2,T)               :- po_top_out_rr(R1,R2,T).
out_rr(R1,R2,T) :- formula(spatial, &partialOverlap(R1,R2)), R1!=R2,
                 &sus{left_side(R1,T)}<left_side(R2,T), time(T), rel_partialOverlap_rr(R1,R2,T).
out_rr(R1,R2,T) :- formula(spatial, &partialOverlap(R1,R2)), R1!=R2,
                 &sus{right_side(R1,T)}>right_side(R2,T), time(T), rel_partialOverlap_rr(R1,R2,T).
out_rr(R1,R2,T) :- formula(spatial, &partialOverlap(R1,R2)), R1!=R2,
                 &sus{bottom(R1,T)}<bottom(R2,T), time(T), rel_partialOverlap_rr(R1,R2,T).
out_rr(R1,R2,T) :- formula(spatial, &partialOverlap(R1,R2)), R1!=R2,
                 &sus{top(R1,T)}>top(R2,T), time(T), rel_partialOverlap_rr(R1,R2,T).
out_rr(R2,R1,T) :- formula(spatial, &partialOverlap(R1,R2)), R1!=R2,
                 &sus{left_side(R2,T)}<left_side(R1,T), time(T), rel_partialOverlap_rr(R1,R2,T).
out_rr(R2,R1,T) :- formula(spatial, &partialOverlap(R1,R2)), R1!=R2,
                 &sus{right_side(R2,T)}>right_side(R1,T), time(T), rel_partialOverlap_rr(R1,R2,T).
out_rr(R2,R1,T) :- formula(spatial, &partialOverlap(R1,R2)), R1!=R2,
                 &sus{bottom(R2,T)}<bottom(R1,T), time(T), rel_partialOverlap_rr(R1,R2,T).
out_rr(R2,R1,T) :- formula(spatial, &partialOverlap(R1,R2)), R1!=R2,
                 &sus{top(R2,T)}>top(R1,T), time(T), rel_partialOverlap_rr(R1,R2,T).
po_left_out_rr(R1,R2,T)   :- out_rr(R1,R2,T), &sus{left_side(R1,T)}<left_side(R2,T).
po_right_out_rr(R1,R2,T)  :- out_rr(R1,R2,T), &sus{right_side(R1,T)}>right_side(R2,T).
po_bottom_out_rr(R1,R2,T) :- out_rr(R1,R2,T), &sus{bottom(R1,T)}<bottom(R2,T).
po_top_out_rr(R1,R2,T)    :- out_rr(R1,R2,T), &sus{top(R1,T)}>top(R2,T).
true(&partialOverlap(R1,R2),T) :-
    formula(spatial, &partialOverlap(R1,R2)), R1!=R2,
    &sus{left_side(R1,T)}<right_side(R2,T),
    &sus{bottom(R1,T)}<top(R2,T),
    &sus{right_side(R1,T)}>left_side(R2,T),
    &sus{top(R1,T)}>bottom(R2,T),
    out_rr(R1,R2,T),
    out_rr(R2,R1,T),
    time(T), rel_partialOverlap_rr(R1,R2,T).


%# `ntpp(R1,R2)`
%
% Rectangle `R1` is a non-tangential proper part of `R2`: all four sides lie strictly inside `R2`.
%
% ![`&ntpp`](../../assets/relations/ntpp_rr.svg)
%
&sus{left_side(R1,T)}>left_side(R2,T)   :- true(&ntpp(R1,R2),T), R1!=R2, rel_ntpp_rr(R1,R2,T).
&sus{right_side(R1,T)}<right_side(R2,T) :- true(&ntpp(R1,R2),T), R1!=R2, rel_ntpp_rr(R1,R2,T).
&sus{bottom(R1,T)}>bottom(R2,T)         :- true(&ntpp(R1,R2),T), R1!=R2, rel_ntpp_rr(R1,R2,T).
&sus{top(R1,T)}<top(R2,T)               :- true(&ntpp(R1,R2),T), R1!=R2, rel_ntpp_rr(R1,R2,T). 
true(&ntpp(R1,R2),T) :- formula(spatial, &ntpp(R1,R2)), R1!=R2,
                        &sus{left_side(R1,T)}>left_side(R2,T), 
                        &sus{right_side(R1,T)}<right_side(R2,T), 
                        &sus{bottom(R1,T)}>bottom(R2,T), 
                        &sus{top(R1,T)}<top(R2,T), time(T), rel_ntpp_rr(R1,R2,T). 


%# `disconnected(R1,R2)`
%
% Rectangles `R1` and `R2` are strictly separated along at least one axis.
% Boundary contact is excluded by the strict inequalities.
%
% ![`&disconnected`](../../assets/relations/disconnected_rr.svg)
%
c1_disconnected_rr(R1,R2,T)| 
  c2_disconnected_rr(R1,R2,T)| 
  c3_disconnected_rr(R1,R2,T)|
  c4_disconnected_rr(R1,R2,T) :- true(&disconnected(R1,R2),T), R1!=R2, rel_disconnected_rr(R1,R2,T).
&sus{left_side(R1,T)}>right_side(R2,T) :- c1_disconnected_rr(R1,R2,T).
&sus{bottom(R1,T)}>top(R2,T)           :- c2_disconnected_rr(R1,R2,T).
&sus{right_side(R1,T)}<left_side(R2,T) :- c3_disconnected_rr(R1,R2,T).
&sus{top(R1,T)}<bottom(R2,T)           :- c4_disconnected_rr(R1,R2,T).
c1_disconnected_rr(R1,R2,T) :- formula(spatial, &disconnected(R1,R2)), &sus{left_side(R1,T)}>right_side(R2,T),   R1!=R2, time(T), rel_disconnected_rr(R1,R2,T). 
c2_disconnected_rr(R1,R2,T) :- formula(spatial, &disconnected(R1,R2)), &sus{bottom(R1,T)} > top(R2,T),           R1!=R2, time(T), rel_disconnected_rr(R1,R2,T).
c3_disconnected_rr(R1,R2,T) :- formula(spatial, &disconnected(R1,R2)), &sus{right_side(R1,T)} < left_side(R2,T), R1!=R2, time(T), rel_disconnected_rr(R1,R2,T).
c4_disconnected_rr(R1,R2,T) :- formula(spatial, &disconnected(R1,R2)), &sus{top(R1,T)} < bottom(R2,T),           R1!=R2, time(T), rel_disconnected_rr(R1,R2,T).
true(&disconnected(R1,R2),T) :- c1_disconnected_rr(R1, R2, T), rel_disconnected_rr(R1,R2,T).
true(&disconnected(R1,R2),T) :- c2_disconnected_rr(R1, R2, T), rel_disconnected_rr(R1,R2,T).
true(&disconnected(R1,R2),T) :- c3_disconnected_rr(R1, R2, T), rel_disconnected_rr(R1,R2,T).
true(&disconnected(R1,R2),T) :- c4_disconnected_rr(R1, R2, T), rel_disconnected_rr(R1,R2,T).


%# `discrete(R1,R2)`
%
% Rectangles `R1` and `R2` have disjoint interiors along at least one axis.
% Boundary contact is included because the separating inequalities are non-strict.
%
% ![`&discrete`](../../assets/relations/discrete_rr.svg)
%
c1_discrete_rr(R1,R2,T)| 
  c2_discrete_rr(R1,R2,T)| 
  c3_discrete_rr(R1,R2,T)|  
  c4_discrete_rr(R1,R2,T) :- true(&discrete(R1,R2),T), R1!=R2, rel_discrete_rr(R1,R2,T).
&sus{left_side(R1,T)}>=right_side(R2,T) :- c1_discrete_rr(R1,R2,T).
&sus{bottom(R1,T)}>=top(R2,T)           :- c2_discrete_rr(R1,R2,T).
&sus{right_side(R1,T)}<=left_side(R2,T) :- c3_discrete_rr(R1,R2,T).
&sus{top(R1,T)}<=bottom(R2,T)           :- c4_discrete_rr(R1,R2,T).
c1_discrete_rr(R1,R2,T):- formula(spatial, &discrete(R1,R2)), &sus{left_side(R1,T)}>=right_side(R2,T), R1!=R2, time(T), rel_discrete_rr(R1,R2,T). 
c2_discrete_rr(R1,R2,T):- formula(spatial, &discrete(R1,R2)), &sus{bottom(R1,T)} >= top(R2,T),         R1!=R2, time(T), rel_discrete_rr(R1,R2,T).
c3_discrete_rr(R1,R2,T):- formula(spatial, &discrete(R1,R2)), &sus{right_side(R1,T)} <= left_side(R2,T), R1!=R2, time(T), rel_discrete_rr(R1,R2,T).
c4_discrete_rr(R1,R2,T):- formula(spatial, &discrete(R1,R2)), &sus{top(R1,T)} <= bottom(R2,T),           R1!=R2, time(T), rel_discrete_rr(R1,R2,T).
true(&discrete(R1,R2),T):- c1_discrete_rr(R1,R2,T), formula(spatial, &discrete(R1,R2)), rel_discrete_rr(R1,R2,T).
true(&discrete(R1,R2),T):- c2_discrete_rr(R1,R2,T), formula(spatial, &discrete(R1,R2)), rel_discrete_rr(R1,R2,T).
true(&discrete(R1,R2),T):- c3_discrete_rr(R1,R2,T), formula(spatial, &discrete(R1,R2)), rel_discrete_rr(R1,R2,T).
true(&discrete(R1,R2),T):- c4_discrete_rr(R1,R2,T), formula(spatial, &discrete(R1,R2)), rel_discrete_rr(R1,R2,T).


%# `equal(R1,R2)`
%
% Rectangles `R1` and `R2` have equal left, right, bottom, and top coordinates.
%
% ![`&equal`](../../assets/relations/equal_rr.svg)
%
&sus{right_side(R1,T)}=right_side(R2,T):- true(&equal(R1,R2),T), R1!=R2, rel_equal_rr(R1,R2,T). 
&sus{left_side(R1,T)}=left_side(R2,T)  :- true(&equal(R1,R2),T), R1!=R2, rel_equal_rr(R1,R2,T).
&sus{top(R1,T)}=top(R2,T)              :- true(&equal(R1,R2),T), R1!=R2, rel_equal_rr(R1,R2,T).
&sus{bottom(R1,T)}=bottom(R2,T)        :- true(&equal(R1,R2),T), R1!=R2, rel_equal_rr(R1,R2,T).
true(&equal(R1,R2),T) :- formula(spatial, &equal(R1,R2)), R1!=R2,
                          &sus{right_side(R1,T)}=right_side(R2,T), 
                          &sus{left_side(R1,T)}=left_side(R2,T),
                          &sus{top(R1,T)}=top(R2,T),
                          &sus{bottom(R1,T)}=bottom(R2,T), time(T), rel_equal_rr(R1,R2,T).


%# `properPart(R1,R2)`
%
% Rectangle `R1` lies within `R2`, with each side weakly inside the corresponding side of `R2`.
% At least one dimension is strictly smaller, so equality is excluded while boundary contact is allowed.
%
% ![`&properPart`](../../assets/relations/properPart_rr.svg)
%
&sus{left_side(R1,T)}>=left_side(R2,T)                 :- true(&properPart(R1,R2),T), R1!=R2, rel_properPart_rr(R1,R2,T). 
&sus{right_side(R1,T)}<=right_side(R2,T)               :- true(&properPart(R1,R2),T), R1!=R2, rel_properPart_rr(R1,R2,T).
&sus{bottom(R1,T)}>=bottom(R2,T)                       :- true(&properPart(R1,R2),T), R1!=R2, rel_properPart_rr(R1,R2,T).
&sus{top(R1,T)}<=top(R2,T)                             :- true(&properPart(R1,R2),T), R1!=R2, rel_properPart_rr(R1,R2,T).  
c1_properPart_rr(R1,R2,T)| c2_properPart_rr(R1,R2,T) :- true(&properPart(R1,R2),T), R1!=R2, rel_properPart_rr(R1,R2,T).
&sus{width(R1,T)}<width(R2,T)  :- c1_properPart_rr(R1,R2,T).
&sus{height(R1,T)}<height(R2,T):- c2_properPart_rr(R1,R2,T). 
true(&properPart(R1,R2),T) :- formula(spatial, &properPart(R1,R2)), R1!=R2, 
                               &sus{left_side(R1,T)}>=left_side(R2,T), 
                               &sus{right_side(R1,T)}<=right_side(R2,T), 
                               &sus{bottom(R1,T)}>=bottom(R2,T), 
                               &sus{top(R1,T)}<=top(R2,T), 
                               &sus{height(R1,T)}<=height(R2,T), 
                               &sus{width(R1,T)}<width(R2,T), time(T), rel_properPart_rr(R1,R2,T). 
true(&properPart(R1,R2),T) :- formula(spatial, &properPart(R1,R2)), R1!=R2, 
                               &sus{left_side(R1,T)}>=left_side(R2,T), 
                               &sus{right_side(R1,T)}<=right_side(R2,T), 
                               &sus{bottom(R1,T)}>=bottom(R2,T), 
                               &sus{top(R1,T)}<=top(R2,T), 
                               &sus{width(R1,T)}<=width(R2,T), 
                               &sus{height(R1,T)}<height(R2,T), time(T), rel_properPart_rr(R1,R2,T). 


%# `extConnected(R1,R2)`
%
% Rectangles `R1` and `R2` are externally connected when one pair of facing sides is equal and their projections on the other axis overlap or touch.
% This includes side and corner contact but excludes a positive gap or interior overlap.
%
% ![`&extConnected`](../../assets/relations/extConnected_rr.svg)
%
c1_extConnected_rr(R1,R2,T)|
    c2_extConnected_rr(R1,R2,T)|
    c3_extConnected_rr(R1,R2,T)|
    c4_extConnected_rr(R1,R2,T) :-
    true(&extConnected(R1,R2),T), R1!=R2, rel_extConnected_rr(R1,R2,T).
&sus{right_side(R1,T)} = left_side(R2,T) :- c1_extConnected_rr(R1,R2,T).
&sus{top(R1,T)} >= bottom(R2,T)          :- c1_extConnected_rr(R1,R2,T).
&sus{bottom(R1,T)} <= top(R2,T)          :- c1_extConnected_rr(R1,R2,T).
&sus{top(R1,T)} = bottom(R2,T)           :- c2_extConnected_rr(R1,R2,T).
&sus{right_side(R1,T)} >= left_side(R2,T):- c2_extConnected_rr(R1,R2,T).
&sus{left_side(R1,T)} <= right_side(R2,T):- c2_extConnected_rr(R1,R2,T).
&sus{left_side(R1,T)} = right_side(R2,T) :- c3_extConnected_rr(R1,R2,T).
&sus{top(R1,T)} >= bottom(R2,T)          :- c3_extConnected_rr(R1,R2,T).
&sus{bottom(R1,T)} <= top(R2,T)          :- c3_extConnected_rr(R1,R2,T).
&sus{bottom(R1,T)} = top(R2,T)           :- c4_extConnected_rr(R1,R2,T).
&sus{right_side(R1,T)} >= left_side(R2,T):- c4_extConnected_rr(R1,R2,T).
&sus{left_side(R1,T)} <= right_side(R2,T):- c4_extConnected_rr(R1,R2,T).
true(&extConnected(R1,R2),T) :- formula(spatial, &extConnected(R1,R2)), R1!=R2,
                                 &sus{right_side(R1,T)} = left_side(R2,T),
                                 &sus{top(R1,T)} >= bottom(R2,T),
                                 &sus{bottom(R1,T)} <= top(R2,T), time(T), rel_extConnected_rr(R1,R2,T).
true(&extConnected(R1,R2),T) :- formula(spatial, &extConnected(R1,R2)), R1!=R2,
                                 &sus{top(R1,T)} = bottom(R2,T),
                                 &sus{right_side(R1,T)} >= left_side(R2,T),
                                 &sus{left_side(R1,T)} <= right_side(R2,T), time(T), rel_extConnected_rr(R1,R2,T).
true(&extConnected(R1,R2),T) :-  formula(spatial, &extConnected(R1,R2)), R1!=R2,
                                  &sus{left_side(R1,T)} = right_side(R2,T),
                                  &sus{top(R1,T)} >= bottom(R2,T),
                                  &sus{bottom(R1,T)} <= top(R2,T), time(T), rel_extConnected_rr(R1,R2,T).
true(&extConnected(R1,R2),T) :- formula(spatial, &extConnected(R1,R2)), R1!=R2,
                                 &sus{bottom(R1,T)} = top(R2,T),
                                 &sus{right_side(R1,T)} >= left_side(R2,T),
                                 &sus{left_side(R1,T)} <= right_side(R2,T), time(T), rel_extConnected_rr(R1,R2,T).
