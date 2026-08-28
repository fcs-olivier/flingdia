%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  RECT-RECT  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% NOTE: no need to use compound relations here since the rels are entirely fixed (no change possible).
% NOTE: the inverse relations are not useful and therefore not defined here. 

%%%%%%%%%%%%%% TOPOLOGY %%%%%%%%%%%%%                                   
%                                     C -----+            DR (rcc5)
%                                     |       \           |  \
%                          +--------- O        \          |   \
%                         /         /   \       \         |    \
%                        /         /     \       \        |     |
%                       /         /       \       \       |     |
%                      /         P         Pi      \      |     |
%                     /        /  \        /  \     \     |     |
%                    /        /    \      /    \     \    |     |
%                   /  (rcc5)PP     \    /   PPi(rcc5)\   |     |
%                  |       /   \     \  /    /   \     \  |     |
%                  |      /     \     \/    /     \     \ |     |
%            (rcc5)PO    TPP   NTPP   EQ  NTPPi   TPPi   EC     DC
%                                   (rcc5)


%%%%%%%%%%%%%%% overlap_rr (O) (this is not partial overlap) %%%%%%%%%%%%%
% TRUE cases:  PO   TPP     NTPP         EQ        NTPPi        TPPi
% +----+      +--------+   +--------+   +------+    +--------+   +--------+
% | R1 |      | R2     |   |   R2   |   |R1=R2 |    |   R1   |   |   R1   |
% |  +-+--+   |+----+  |   | +----+ |   |      |    | +----+ |   | +----+ |
% +--+-+R2|   || R1 |  |   | | R1 | |   +------+    | | R2 | |   | | R2 ||
%    +----+   |+----+  |   | +----+ |               | +----+ |   | +----+|
%             +--------+   +--------+               +--------+   +--------+
%
% FALSE cases:  DC    EC
% +----+   +----+        +----++----+          +----+
% | R1 |   | R2 |        | R1 || R2 |          | R1 |
% +----+   +----+        +----++----+          +----++----+
%                                                    | R2 |
%                                                    +----+

&sus{left_side(R1,T)}<right_side(R2,T)  :- true(&overlap_rr(R1,R2),T), R1!=R2.
&sus{bottom(R1,T)}<top(R2,T)            :- true(&overlap_rr(R1,R2),T), R1!=R2.
&sus{right_side(R1,T)}>left_side(R2,T)  :- true(&overlap_rr(R1,R2),T), R1!=R2.
&sus{top(R1,T)}>bottom(R2,T)            :- true(&overlap_rr(R1,R2),T), R1!=R2.

true(&overlap_rr(R1,R2),T) :- formula(spatial, &overlap_rr(R1,R2)), R1!=R2,
                            &sus{left_side(R1,T)}<right_side(R2,T),
                            &sus{bottom(R1,T)}<top(R2,T),
                            &sus{right_side(R1,T)}>left_side(R2,T),
                            &sus{top(R1,T)}>bottom(R2,T), time(T).

invalid_relation_arg(&overlap_rr(R1,R2)) :- formula(spatial, &overlap_rr(R1,R2)), R1!=R2,
                                         #count {valid_arg_1 : true(rect(R1),T);
                                                 valid_arg_2 : true(rect(R2),T)} != 2,
                                                 time(T).

%%%%%%%%%%%%%%% partialOverlap_rr (PO) %%%%%%%%%%%%%
% Positive-area overlap, but neither rectangle is part of the other.
%
% TRUE:   PO
% +----+
% | R1 |
% |  +-+----+
% +--+-+ R2 |
%    +------+
%
% FALSE: disconnected        externally connected       proper part
% +----+   +----+            +----++----+                     +--------+
% | R1 |   | R2 |            | R1 || R2 |                     |   R2   |
% +----+   +----+            +----++----+                     | +----+ |
%                                                             | | R1 | |
%                                                             | +----+ |
%                                                             +--------+

% Positive-area overlap: EC is excluded because inequalities are strict.
&sus{left_side(R1,T)}<right_side(R2,T)  :- true(&partialOverlap_rr(R1,R2),T), R1!=R2.
&sus{bottom(R1,T)}<top(R2,T)            :- true(&partialOverlap_rr(R1,R2),T), R1!=R2.
&sus{right_side(R1,T)}>left_side(R2,T)  :- true(&partialOverlap_rr(R1,R2),T), R1!=R2.
&sus{top(R1,T)}>bottom(R2,T)            :- true(&partialOverlap_rr(R1,R2),T), R1!=R2.

% R1 must stick out of R2 in at least one direction.
po_left_out_rr(R1,R2,T)|
    po_right_out_rr(R1,R2,T)|
    po_bottom_out_rr(R1,R2,T)|
    po_top_out_rr(R1,R2,T) :-  true(&partialOverlap_rr(R1,R2),T), R1!=R2.

% R2 must also stick out of R1 in at least one direction.
% This excludes proper-part cases.
po_left_out_rr(R2,R1,T)|
    po_right_out_rr(R2,R1,T)|
    po_bottom_out_rr(R2,R1,T)|
    po_top_out_rr(R2,R1,T) :-  true(&partialOverlap_rr(R1,R2),T), R1!=R2.

&sus{left_side(R1,T)}<left_side(R2,T)   :- po_left_out_rr(R1,R2,T).
&sus{right_side(R1,T)}>right_side(R2,T) :- po_right_out_rr(R1,R2,T).
&sus{bottom(R1,T)}<bottom(R2,T)         :- po_bottom_out_rr(R1,R2,T).
&sus{top(R1,T)}>top(R2,T)               :- po_top_out_rr(R1,R2,T).

% Other direction
% R1 sticks out of R2.
out_rr(R1,R2,T) :- formula(spatial, &partialOverlap_rr(R1,R2)), R1!=R2,
                 &sus{left_side(R1,T)}<left_side(R2,T), time(T).

out_rr(R1,R2,T) :- formula(spatial, &partialOverlap_rr(R1,R2)), R1!=R2,
                 &sus{right_side(R1,T)}>right_side(R2,T), time(T).

out_rr(R1,R2,T) :- formula(spatial, &partialOverlap_rr(R1,R2)), R1!=R2,
                 &sus{bottom(R1,T)}<bottom(R2,T), time(T).

out_rr(R1,R2,T) :- formula(spatial, &partialOverlap_rr(R1,R2)), R1!=R2,
                 &sus{top(R1,T)}>top(R2,T), time(T).

% R2 sticks out of R1, still guarded by the original formula orientation.
% This is the critical symmetric check.
out_rr(R2,R1,T) :- formula(spatial, &partialOverlap_rr(R1,R2)), R1!=R2,
                 &sus{left_side(R2,T)}<left_side(R1,T), time(T).

out_rr(R2,R1,T) :- formula(spatial, &partialOverlap_rr(R1,R2)), R1!=R2,
                 &sus{right_side(R2,T)}>right_side(R1,T), time(T).

out_rr(R2,R1,T) :- formula(spatial, &partialOverlap_rr(R1,R2)), R1!=R2,
                 &sus{bottom(R2,T)}<bottom(R1,T), time(T).

out_rr(R2,R1,T) :- formula(spatial, &partialOverlap_rr(R1,R2)), R1!=R2,
                 &sus{top(R2,T)}>top(R1,T), time(T).

% Tie each disjunctive case to its actual geometric witness; otherwise an
% unrelated case could be selected solely to provide support for parameters.
po_left_out_rr(R1,R2,T)   :- out_rr(R1,R2,T), &sus{left_side(R1,T)}<left_side(R2,T).
po_right_out_rr(R1,R2,T)  :- out_rr(R1,R2,T), &sus{right_side(R1,T)}>right_side(R2,T).
po_bottom_out_rr(R1,R2,T) :- out_rr(R1,R2,T), &sus{bottom(R1,T)}<bottom(R2,T).
po_top_out_rr(R1,R2,T)    :- out_rr(R1,R2,T), &sus{top(R1,T)}>top(R2,T).


true(&partialOverlap_rr(R1,R2),T) :-
    formula(spatial, &partialOverlap_rr(R1,R2)), R1!=R2,
    % positive-area overlap
    &sus{left_side(R1,T)}<right_side(R2,T),
    &sus{bottom(R1,T)}<top(R2,T),
    &sus{right_side(R1,T)}>left_side(R2,T),
    &sus{top(R1,T)}>bottom(R2,T),
    % neither rectangle is part of the other
    out_rr(R1,R2,T),
    out_rr(R2,R1,T),
    time(T).


invalid_relation_arg(&partialOverlap_rr(R1,R2)) :-
    formula(spatial, &partialOverlap_rr(R1,R2)),
    #count { valid_arg_1 : true(rect(R1),T);
             valid_arg_2 : true(rect(R2),T) } != 2,
    time(T).

%%%%%%%%%%%%%%% ntpp_rr (NTPP) %%%%%%%%%%%%%
% TRUE cases:  NTPP
%  +--------+
%  |   R2   |
%  | +----+ |
%  | | R1 | |
%  | +----+ |
%  +--------+

&sus{left_side(R1,T)}>left_side(R2,T)   :- true(&ntpp_rr(R1,R2),T), R1!=R2.
&sus{right_side(R1,T)}<right_side(R2,T) :- true(&ntpp_rr(R1,R2),T), R1!=R2.
&sus{bottom(R1,T)}>bottom(R2,T)         :- true(&ntpp_rr(R1,R2),T), R1!=R2.
&sus{top(R1,T)}<top(R2,T)               :- true(&ntpp_rr(R1,R2),T), R1!=R2. 


true(&ntpp_rr(R1,R2),T) :- formula(spatial, &ntpp_rr(R1,R2)), R1!=R2,
                        &sus{left_side(R1,T)}>left_side(R2,T), 
                        &sus{right_side(R1,T)}<right_side(R2,T), 
                        &sus{bottom(R1,T)}>bottom(R2,T), 
                        &sus{top(R1,T)}<top(R2,T), time(T). 

invalid_relation_arg(&ntpp_rr(R1,R2)) :- formula(spatial, &ntpp_rr(R1,R2)), R1!=R2,
                                         #count {valid_arg_1 : true(rect(R1),T);
                                                 valid_arg_2 : true(rect(R2),T)} != 2,
                                                 time(T).


%%%%%%%%%%%%%%% disconnected_rr (DC) %%%%%%%%%%%%%
% TRUE cases:  DC         FALSE cases:  EC
% +----+   +----+        +----++----+
% | R1 |   | R2 |        | R1 || R2 |
% +----+   +----+        +----++----+                               

c1_disconnected_rr(R1,R2,T)| 
  c2_disconnected_rr(R1,R2,T)| 
  c3_disconnected_rr(R1,R2,T)|
  c4_disconnected_rr(R1,R2,T) :- true(&disconnected_rr(R1,R2),T), R1!=R2.

&sus{left_side(R1,T)}>right_side(R2,T) :- c1_disconnected_rr(R1,R2,T).
&sus{bottom(R1,T)}>top(R2,T)           :- c2_disconnected_rr(R1,R2,T).
&sus{right_side(R1,T)}<left_side(R2,T) :- c3_disconnected_rr(R1,R2,T).
&sus{top(R1,T)}<bottom(R2,T)           :- c4_disconnected_rr(R1,R2,T).

c1_disconnected_rr(R1,R2,T) :- formula(spatial, &disconnected_rr(R1,R2)), &sus{left_side(R1,T)}>right_side(R2,T),   R1!=R2, time(T). 
c2_disconnected_rr(R1,R2,T) :- formula(spatial, &disconnected_rr(R1,R2)), &sus{bottom(R1,T)} > top(R2,T),           R1!=R2, time(T).
c3_disconnected_rr(R1,R2,T) :- formula(spatial, &disconnected_rr(R1,R2)), &sus{right_side(R1,T)} < left_side(R2,T), R1!=R2, time(T).
c4_disconnected_rr(R1,R2,T) :- formula(spatial, &disconnected_rr(R1,R2)), &sus{top(R1,T)} < bottom(R2,T),           R1!=R2, time(T).

true(&disconnected_rr(R1,R2),T) :- c1_disconnected_rr(R1, R2, T).
true(&disconnected_rr(R1,R2),T) :- c2_disconnected_rr(R1, R2, T).
true(&disconnected_rr(R1,R2),T) :- c3_disconnected_rr(R1, R2, T).
true(&disconnected_rr(R1,R2),T) :- c4_disconnected_rr(R1, R2, T).

invalid_relation_arg(&disconnected_rr(R1,R2)) :- formula(spatial, &disconnected_rr(R1,R2)), R1!=R2,
                                         #count {valid_arg_1 : true(rect(R1),T);
                                                 valid_arg_2 : true(rect(R2),T)} != 2,
                                                 time(T).


%%%%%%%%%%%%%%% discrete_rr (DC) %%%%%%%%%%%%%
% TRUE cases:  DC         EC
%    +----+   +----+        +----++----+
%    | R1 |   | R2 |        | R1 || R2 |
%    +----+   +----+        +----++----+                               

c1_discrete_rr(R1,R2,T)| 
  c2_discrete_rr(R1,R2,T)| 
  c3_discrete_rr(R1,R2,T)|  
  c4_discrete_rr(R1,R2,T) :- true(&discrete_rr(R1,R2),T), R1!=R2.

&sus{left_side(R1,T)}>=right_side(R2,T) :- c1_discrete_rr(R1,R2,T).
&sus{bottom(R1,T)}>=top(R2,T)           :- c2_discrete_rr(R1,R2,T).
&sus{right_side(R1,T)}<=left_side(R2,T) :- c3_discrete_rr(R1,R2,T).
&sus{top(R1,T)}<=bottom(R2,T)           :- c4_discrete_rr(R1,R2,T).

c1_discrete_rr(R1,R2,T):- formula(spatial, &discrete_rr(R1,R2)), &sus{left_side(R1,T)}>=right_side(R2,T), R1!=R2, time(T). 
c2_discrete_rr(R1,R2,T):- formula(spatial, &discrete_rr(R1,R2)), &sus{bottom(R1,T)} >= top(R2,T),         R1!=R2, time(T).
c3_discrete_rr(R1,R2,T):- formula(spatial, &discrete_rr(R1,R2)), &sus{right_side(R1,T)} <= left_side(R2,T), R1!=R2, time(T).
c4_discrete_rr(R1,R2,T):- formula(spatial, &discrete_rr(R1,R2)), &sus{top(R1,T)} <= bottom(R2,T),           R1!=R2, time(T).

true(&discrete_rr(R1,R2),T):- c1_discrete_rr(R1,R2,T).
true(&discrete_rr(R1,R2),T):- c2_discrete_rr(R1,R2,T).
true(&discrete_rr(R1,R2),T):- c3_discrete_rr(R1,R2,T).
true(&discrete_rr(R1,R2),T):- c4_discrete_rr(R1,R2,T).

invalid_relation_arg(&discrete_rr(R1,R2)) :- formula(spatial, &discrete_rr(R1,R2)), R1!=R2,
                                         #count {valid_arg_1 : true(rect(R1),T);
                                                 valid_arg_2 : true(rect(R2),T)} != 2,
                                                 time(T).


%%%%%%%%%%%%%%% equal_rr (EQ) %%%%%%%%%%%%%
% TRUE cases:  EQ
%  +----+
%  | R1 |
%  | R2 |
%  +----+

&sus{right_side(R1,T)}=right_side(R2,T):- true(&equal_rr(R1,R2),T), R1!=R2. 
&sus{left_side(R1,T)}=left_side(R2,T)  :- true(&equal_rr(R1,R2),T), R1!=R2.
&sus{top(R1,T)}=top(R2,T)              :- true(&equal_rr(R1,R2),T), R1!=R2.
&sus{bottom(R1,T)}=bottom(R2,T)        :- true(&equal_rr(R1,R2),T), R1!=R2.

true(&equal_rr(R1,R2),T) :- formula(spatial, &equal_rr(R1,R2)), R1!=R2,
                          &sus{right_side(R1,T)}=right_side(R2,T), 
                          &sus{left_side(R1,T)}=left_side(R2,T),
                          &sus{top(R1,T)}=top(R2,T),
                          &sus{bottom(R1,T)}=bottom(R2,T), time(T).

invalid_relation_arg(&equal_rr(R1,R2)) :- formula(spatial, &equal_rr(R1,R2)), R1!=R2,
                                         #count {valid_arg_1 : true(rect(R1),T);
                                                 valid_arg_2 : true(rect(R2),T)} != 2,
                                                 time(T).

%%%%%%%%%%%%%%% properPart_rr (PP) %%%%%%%%%%%%%
% TRUE cases:  NTPP     TPP                     FALSE case : EQ
%     +--------+      +--------+                   +----+
%     | R2     |      |   R2   |                   | R1 |
%     |+----+  |      | +----+ |                   |    |
%     || R1 |  |      | | R1 | |                   | R2 |
%     |+----+  |      | +----+ |                   +----+
%     +--------+      +--------+                   


&sus{left_side(R1,T)}>=left_side(R2,T)                 :- true(&properPart_rr(R1,R2),T), R1!=R2. 
&sus{right_side(R1,T)}<=right_side(R2,T)               :- true(&properPart_rr(R1,R2),T), R1!=R2.
&sus{bottom(R1,T)}>=bottom(R2,T)                       :- true(&properPart_rr(R1,R2),T), R1!=R2.
&sus{top(R1,T)}<=top(R2,T)                             :- true(&properPart_rr(R1,R2),T), R1!=R2.  
c1_properPart_rr(R1,R2,T)| c2_properPart_rr(R1,R2,T) :- true(&properPart_rr(R1,R2),T), R1!=R2.

&sus{width(R1,T)}<width(R2,T)  :- c1_properPart_rr(R1,R2,T).
&sus{height(R1,T)}<height(R2,T):- c2_properPart_rr(R1,R2,T). 


true(&properPart_rr(R1,R2),T) :- formula(spatial, &properPart_rr(R1,R2)), R1!=R2, 
                               &sus{left_side(R1,T)}>=left_side(R2,T), 
                               &sus{right_side(R1,T)}<=right_side(R2,T), 
                               &sus{bottom(R1,T)}>=bottom(R2,T), 
                               &sus{top(R1,T)}<=top(R2,T), 
                               &sus{height(R1,T)}<=height(R2,T), 
                               &sus{width(R1,T)}<width(R2,T), time(T). 

true(&properPart_rr(R1,R2),T) :- formula(spatial, &properPart_rr(R1,R2)), R1!=R2, 
                               &sus{left_side(R1,T)}>=left_side(R2,T), 
                               &sus{right_side(R1,T)}<=right_side(R2,T), 
                               &sus{bottom(R1,T)}>=bottom(R2,T), 
                               &sus{top(R1,T)}<=top(R2,T), 
                               &sus{width(R1,T)}<=width(R2,T), 
                               &sus{height(R1,T)}<height(R2,T), time(T). 

invalid_relation_arg(&properPart_rr(R1,R2)) :- formula(spatial, &properPart_rr(R1,R2)), R1!=R2,
                                         #count {valid_arg_1 : true(rect(R1),T);
                                                 valid_arg_2 : true(rect(R2),T)} != 2,
                                                 time(T).



%%%%%%%%%%%%%%% extConnected_rr (EC) %%%%%%%%%%%%%
% Boundary contact, but no interior overlap.
%
% TRUE: shared side                    corner contact
% +----++----+                         +----+
% | R1 || R2 |                         | R1 |
% +----++----+                         +----+----+
%                                           | R2 |
%                                           +----+
%
% FALSE: disconnected        partial overlap              proper part
% +----+   +----+            +----+                       +--------+
% | R1 |   | R2 |            | R1 |                       |   R2   |
% +----+   +----+            |  +-+----+                  | +----+ |
%                            +--+-+ R2 |                  | | R1 | |
%                               +------+                  | +----+ |
%                                                         +--------+

c1_extConnected_rr(R1,R2,T)|
    c2_extConnected_rr(R1,R2,T)|
    c3_extConnected_rr(R1,R2,T)|
    c4_extConnected_rr(R1,R2,T) :-
    true(&extConnected_rr(R1,R2),T), R1!=R2.

% R1 touches R2 from the left
&sus{right_side(R1,T)} = left_side(R2,T) :- c1_extConnected_rr(R1,R2,T).
&sus{top(R1,T)} >= bottom(R2,T)          :- c1_extConnected_rr(R1,R2,T).
&sus{bottom(R1,T)} <= top(R2,T)          :- c1_extConnected_rr(R1,R2,T).

% R1 touches R2 from below
&sus{top(R1,T)} = bottom(R2,T)           :- c2_extConnected_rr(R1,R2,T).
&sus{right_side(R1,T)} >= left_side(R2,T):- c2_extConnected_rr(R1,R2,T).
&sus{left_side(R1,T)} <= right_side(R2,T):- c2_extConnected_rr(R1,R2,T).

% R1 touches R2 from the right
&sus{left_side(R1,T)} = right_side(R2,T) :- c3_extConnected_rr(R1,R2,T).
&sus{top(R1,T)} >= bottom(R2,T)          :- c3_extConnected_rr(R1,R2,T).
&sus{bottom(R1,T)} <= top(R2,T)          :- c3_extConnected_rr(R1,R2,T).

% R1 touches R2 from above
&sus{bottom(R1,T)} = top(R2,T)           :- c4_extConnected_rr(R1,R2,T).
&sus{right_side(R1,T)} >= left_side(R2,T):- c4_extConnected_rr(R1,R2,T).
&sus{left_side(R1,T)} <= right_side(R2,T):- c4_extConnected_rr(R1,R2,T).


true(&extConnected_rr(R1,R2),T) :- formula(spatial, &extConnected_rr(R1,R2)), R1!=R2,
                                 &sus{right_side(R1,T)} = left_side(R2,T),
                                 &sus{top(R1,T)} >= bottom(R2,T),
                                 &sus{bottom(R1,T)} <= top(R2,T), time(T).

true(&extConnected_rr(R1,R2),T) :- formula(spatial, &extConnected_rr(R1,R2)), R1!=R2,
                                 &sus{top(R1,T)} = bottom(R2,T),
                                 &sus{right_side(R1,T)} >= left_side(R2,T),
                                 &sus{left_side(R1,T)} <= right_side(R2,T), time(T).

true(&extConnected_rr(R1,R2),T) :-  formula(spatial, &extConnected_rr(R1,R2)), R1!=R2,
                                  &sus{left_side(R1,T)} = right_side(R2,T),
                                  &sus{top(R1,T)} >= bottom(R2,T),
                                  &sus{bottom(R1,T)} <= top(R2,T), time(T).

true(&extConnected_rr(R1,R2),T) :- formula(spatial, &extConnected_rr(R1,R2)), R1!=R2,
                                 &sus{bottom(R1,T)} = top(R2,T),
                                 &sus{right_side(R1,T)} >= left_side(R2,T),
                                 &sus{left_side(R1,T)} <= right_side(R2,T), time(T).


invalid_relation_arg(&extConnected_rr(R1,R2)) :- formula(spatial, &extConnected_rr(R1,R2)), R1!=R2,
                                                 #count { valid_arg_1 : true(rect(R1),T);
                                                valid_arg_2 : true(rect(R2),T) } != 2,
                                                time(T).


