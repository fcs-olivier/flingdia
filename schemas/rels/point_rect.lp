


%%%%%%%%%%  POINT-RECTANGLE  %%%%%%%%%%%%%

%%%%%%%%%%%% in  %%%%%%%%%%%%%
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

&sus{x(P1,K)}>left_side(R2,K) :- true(&in(P1,R2),K), rel_in_pr(P1,R2,K). 
&sus{y(P1,K)}>bottom(R2,K)    :- true(&in(P1,R2),K), rel_in_pr(P1,R2,K). 
&sus{x(P1,K)}<right_side(R2,K):- true(&in(P1,R2),K), rel_in_pr(P1,R2,K). 
&sus{y(P1,K)}<top(R2,K)       :- true(&in(P1,R2),K), rel_in_pr(P1,R2,K). 

true(&in(P1,R2),K):- formula(spatial, &in(P1,R2)),
                      &sus{x(P1,K)}>left_side(R2,K), 
                      &sus{y(P1,K)}>bottom(R2,K), 
                      &sus{x(P1,K)}<right_side(R2,K), 
                      &sus{y(P1,K)}<top(R2,K),
                      time(K), rel_in_pr(P1,R2,K).





%%%%%%%%%%%% inEq  %%%%%%%%%%%%%
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

&sus{x(P1,K)}>=left_side(R2,K) :- true(&inEq(P1,R2),K), rel_inEq_pr(P1,R2,K). 
&sus{y(P1,K)}>=bottom(R2,K)    :- true(&inEq(P1,R2),K), rel_inEq_pr(P1,R2,K). 
&sus{x(P1,K)}<=right_side(R2,K):- true(&inEq(P1,R2),K), rel_inEq_pr(P1,R2,K). 
&sus{y(P1,K)}<= top(R2,K)      :- true(&inEq(P1,R2),K), rel_inEq_pr(P1,R2,K). 

true(&inEq(P1,R2),K):- formula(spatial, &inEq(P1,R2)),
                      &sus{x(P1,K)}>=left_side(R2,K), 
                      &sus{y(P1,K)}>=bottom(R2,K), 
                      &sus{x(P1,K)}<=right_side(R2,K), 
                      &sus{y(P1,K)}<=top(R2,K),
                      time(K), rel_inEq_pr(P1,R2,K).


%%%%%%%%%%%% out  %%%%%%%%%%%%%
% TRUE: point strictly outside the rectangle (not on its boundary).

c1_out_pr(P1,R2,K)|
    c2_out_pr(P1,R2,K)|
    c3_out_pr(P1,R2,K)|
    c4_out_pr(P1,R2,K) :- true(&out(P1,R2),K), rel_out_pr(P1,R2,K).

&sus{x(P1,K)}<=left_side(R2,K)  :- c1_out_pr(P1,R2,K).
&sus{y(P1,K)}<=bottom(R2,K)     :- c2_out_pr(P1,R2,K).
&sus{x(P1,K)}>=right_side(R2,K) :- c3_out_pr(P1,R2,K).
&sus{y(P1,K)}>=top(R2,K)        :- c4_out_pr(P1,R2,K).

% Tie each disjunctive case to its geometric witness.
c1_out_pr(P1,R2,K) :- formula(spatial, &out(P1,R2)), &sus{x(P1,K)}<=left_side(R2,K), time(K), rel_out_pr(P1,R2,K).
c2_out_pr(P1,R2,K) :- formula(spatial, &out(P1,R2)), &sus{y(P1,K)}<=bottom(R2,K), time(K), rel_out_pr(P1,R2,K).
c3_out_pr(P1,R2,K) :- formula(spatial, &out(P1,R2)), &sus{x(P1,K)}>=right_side(R2,K), time(K), rel_out_pr(P1,R2,K).
c4_out_pr(P1,R2,K) :- formula(spatial, &out(P1,R2)), &sus{y(P1,K)}>=top(R2,K), time(K), rel_out_pr(P1,R2,K).

true(&out(P1,R2),K) :- c1_out_pr(P1,R2,K), formula(spatial, &out(P1,R2)), rel_out_pr(P1,R2,K).
true(&out(P1,R2),K) :- c2_out_pr(P1,R2,K), formula(spatial, &out(P1,R2)), rel_out_pr(P1,R2,K).
true(&out(P1,R2),K) :- c3_out_pr(P1,R2,K), formula(spatial, &out(P1,R2)), rel_out_pr(P1,R2,K).
true(&out(P1,R2),K) :- c4_out_pr(P1,R2,K), formula(spatial, &out(P1,R2)), rel_out_pr(P1,R2,K).


%%%%%%%%%%%% left_pr  %%%%%%%%%%%%%

&sus{x(P1,K)}<left_side(R2,K) :- true(&left(P1,R2),K), rel_left_pr(P1,R2,K). 

true(&left(P1,R2),K):- formula(spatial, &left(P1,R2)),
                      &sus{x(P1,K)}<left_side(R2,K), 
                      time(K), rel_left_pr(P1,R2,K).



%%%%%%%%%%%% right_pr  %%%%%%%%%%%%%

&sus{right_side(R2,K)}<x(P1,K) :- true(&right(P1,R2),K), rel_right_pr(P1,R2,K). 

true(&right(P1,R2),K):- formula(spatial, &right(P1,R2)),
                      &sus{right_side(R2,K)}<x(P1,K), 
                      time(K), rel_right_pr(P1,R2,K).



%%%%%%%%%%%% alignedYEq  %%%%%%%%%%%%%

&sus{y(P1,K)}>=bottom(R2,K) :- true(&alignedYEq(P1,R2),K), rel_alignedYEq_pr(P1,R2,K).
&sus{y(P1,K)}<=top(R2,K)    :- true(&alignedYEq(P1,R2),K), rel_alignedYEq_pr(P1,R2,K).

true(&alignedYEq(P1,R2),K) :- formula(spatial, &alignedYEq(P1,R2)),
                               &sus{y(P1,K)}>=bottom(R2,K),
                               &sus{y(P1,K)}<=top(R2,K),
                               time(K), rel_alignedYEq_pr(P1,R2,K).



%%%%%%%%%%%% alignedY  %%%%%%%%%%%%%

&sus{y(P1,K)}>bottom(R2,K) :- true(&alignedY(P1,R2),K), rel_alignedY_pr(P1,R2,K).
&sus{y(P1,K)}<top(R2,K)    :- true(&alignedY(P1,R2),K), rel_alignedY_pr(P1,R2,K).

true(&alignedY(P1,R2),K) :- formula(spatial, &alignedY(P1,R2)),
                               &sus{y(P1,K)}>bottom(R2,K),
                               &sus{y(P1,K)}<top(R2,K),
                               time(K), rel_alignedY_pr(P1,R2,K).



