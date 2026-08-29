


%%%%%%%%%%  POINT-RECTANGLE  %%%%%%%%%%%%%

%%%%%%%%%%%% in_pr  %%%%%%%%%%%%%
% TRUE: point strictly inside        
%    +---------+                        
%    |         | R                      
%    |    *P   |                       
%    +---------+                       

% FALSE: point on boundary           FALSE: point outside
%    +---------+                       +---------+ 
%    |         | R                     |         | R
%    *P        |                       |         |    *P
%    +---------+                       +---------+

&sus{x(P1,K)}>left_side(R2,K) :- true(&in_pr(P1,R2),K). 
&sus{y(P1,K)}>bottom(R2,K)    :- true(&in_pr(P1,R2),K). 
&sus{x(P1,K)}<right_side(R2,K):- true(&in_pr(P1,R2),K). 
&sus{y(P1,K)}<top(R2,K)       :- true(&in_pr(P1,R2),K). 

true(&in_pr(P1,R2),K):- formula(spatial, &in_pr(P1,R2)),
                      &sus{x(P1,K)}>left_side(R2,K), 
                      &sus{y(P1,K)}>bottom(R2,K), 
                      &sus{x(P1,K)}<right_side(R2,K), 
                      &sus{y(P1,K)}<top(R2,K),
                      time(K).

invalid_relation_arg(&in_pr(P1,R2)) :- formula(spatial, &in_pr(P1,R2)),
                                         #count {valid_arg_1 : true(point(P1),K);
                                                 valid_arg_2 : true(rect(R2),K)} != 2,
                                                 time(K).




%%%%%%%%%%%% inEq_pr  %%%%%%%%%%%%%
% TRUE: point strictly inside           point on boundary    
%    +---------+                   +---------+                     
%    |         | R                 |         | R             
%    |    *P   |                   *P        |          
%    +---------+                   +---------+          

%  FALSE: point outside
%     +---------+ 
%     |         | R
%     |         |    *P
%     +---------+

&sus{x(P1,K)}>=left_side(R2,K) :- true(&inEq_pr(P1,R2),K). 
&sus{y(P1,K)}>=bottom(R2,K)    :- true(&inEq_pr(P1,R2),K). 
&sus{x(P1,K)}<=right_side(R2,K):- true(&inEq_pr(P1,R2),K). 
&sus{y(P1,K)}<= top(R2,K)      :- true(&inEq_pr(P1,R2),K). 

true(&inEq_pr(P1,R2),K):- formula(spatial, &inEq_pr(P1,R2)),
                      &sus{x(P1,K)}>=left_side(R2,K), 
                      &sus{y(P1,K)}>=bottom(R2,K), 
                      &sus{x(P1,K)}<=right_side(R2,K), 
                      &sus{y(P1,K)}<=top(R2,K),
                      time(K).

invalid_relation_arg(&inEq_pr(P1,R2)) :- formula(spatial, &inEq_pr(P1,R2)),
                                         #count {valid_arg_1 : true(point(P1),K);
                                                 valid_arg_2 : true(rect(R2),K)} != 2,
                                                 time(K).

%%%%%%%%%%%% out_pr  %%%%%%%%%%%%%
% TRUE: point strictly outside the rectangle (not on its boundary).

c1_out_pr(P1,R2,K)|
    c2_out_pr(P1,R2,K)|
    c3_out_pr(P1,R2,K)|
    c4_out_pr(P1,R2,K) :- true(&out_pr(P1,R2),K).

&sus{x(P1,K)}<left_side(R2,K)  :- c1_out_pr(P1,R2,K).
&sus{y(P1,K)}<bottom(R2,K)     :- c2_out_pr(P1,R2,K).
&sus{x(P1,K)}>right_side(R2,K) :- c3_out_pr(P1,R2,K).
&sus{y(P1,K)}>top(R2,K)        :- c4_out_pr(P1,R2,K).

% Tie each disjunctive case to its geometric witness.
c1_out_pr(P1,R2,K) :- formula(spatial, &out_pr(P1,R2)),
                      &sus{x(P1,K)}<left_side(R2,K), time(K).
c2_out_pr(P1,R2,K) :- formula(spatial, &out_pr(P1,R2)),
                      &sus{y(P1,K)}<bottom(R2,K), time(K).
c3_out_pr(P1,R2,K) :- formula(spatial, &out_pr(P1,R2)),
                      &sus{x(P1,K)}>right_side(R2,K), time(K).
c4_out_pr(P1,R2,K) :- formula(spatial, &out_pr(P1,R2)),
                      &sus{y(P1,K)}>top(R2,K), time(K).

true(&out_pr(P1,R2),K) :- c1_out_pr(P1,R2,K).
true(&out_pr(P1,R2),K) :- c2_out_pr(P1,R2,K).
true(&out_pr(P1,R2),K) :- c3_out_pr(P1,R2,K).
true(&out_pr(P1,R2),K) :- c4_out_pr(P1,R2,K).

invalid_relation_arg(&out_pr(P1,R2)) :- formula(spatial, &out_pr(P1,R2)),
                                        #count {valid_arg_1 : true(point(P1),K);
                                                valid_arg_2 : true(rect(R2),K)} != 2,
                                                time(K).

%%%%%%%%%%%% left_pr  %%%%%%%%%%%%%

&sus{x(P1,K)}<left_side(R2,K) :- true(&left_pr(P1,R2),K). 

true(&left_pr(P1,R2),K):- formula(spatial, &left_pr(P1,R2)),
                      &sus{x(P1,K)}<left_side(R2,K), 
                      time(K).

invalid_relation_arg(&left_pr(P1,R2)) :- formula(spatial, &left_pr(P1,R2)),
                                         #count {valid_arg_1 : true(point(P1),K);
                                                 valid_arg_2 : true(rect(R2),K)} != 2,
                                                 time(K).


%%%%%%%%%%%% right_pr  %%%%%%%%%%%%%

&sus{right_side(R2,K)}<x(P1,K) :- true(&right_pr(P1,R2),K). 

true(&right_pr(P1,R2),K):- formula(spatial, &right_pr(P1,R2)),
                      &sus{right_side(R2,K)}<x(P1,K), 
                      time(K).

invalid_relation_arg(&right_pr(P1,R2)) :- formula(spatial, &right_pr(P1,R2)),
                                         #count {valid_arg_1 : true(point(P1),K);
                                                 valid_arg_2 : true(rect(R2),K)} != 2,
                                                 time(K).


%%%%%%%%%%%% alignedYEq_pr  %%%%%%%%%%%%%

&sus{y(P1,K)}>=bottom(R2,K) :- true(&alignedYEq_pr(P1,R2),K).
&sus{y(P1,K)}<=top(R2,K)    :- true(&alignedYEq_pr(P1,R2),K).

true(&alignedYEq_pr(P1,R2),K) :- formula(spatial, &alignedYEq_pr(P1,R2)),
                               &sus{y(P1,K)}>=bottom(R2,K),
                               &sus{y(P1,K)}<=top(R2,K),
                               time(K).

invalid_relation_arg(&alignedYEq_pr(P1,R2)) :- formula(spatial, &alignedYEq_pr(P1,R2)),
                                             #count {valid_arg_1 : true(point(P1),K);
                                                     valid_arg_2 : true(rect(R2),K)} != 2,
                                                     time(K).


%%%%%%%%%%%% alignedY_pr  %%%%%%%%%%%%%

&sus{y(P1,K)}>bottom(R2,K) :- true(&alignedY_pr(P1,R2),K).
&sus{y(P1,K)}<top(R2,K)    :- true(&alignedY_pr(P1,R2),K).

true(&alignedY_pr(P1,R2),K) :- formula(spatial, &alignedY_pr(P1,R2)),
                               &sus{y(P1,K)}>bottom(R2,K),
                               &sus{y(P1,K)}<top(R2,K),
                               time(K).

invalid_relation_arg(&alignedY_pr(P1,R2)) :- formula(spatial, &alignedY_pr(P1,R2)),
                                             #count {valid_arg_1 : true(point(P1),K);
                                                     valid_arg_2 : true(rect(R2),K)} != 2,
                                                     time(K).


