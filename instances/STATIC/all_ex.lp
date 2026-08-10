% test while asking for all the answers

%%%%%%%%%%%%%%%% 1.left(ab) %%%%%%%%%%%%%%%%

point(a;b).
&left_pp(a,b). 


---- EXPECTED OUTPUT -----
Answer: 1
a b 


%%%%%%%%%%%%%%%% 2.left(ab) left(bc) %%%%%%%%%%%%%%%%

point(a;b;c).
&left_pp(a,b).
&left_pp(b,c).

---- EXPECTED OUTPUT -----
Answer: 1
a b c

%%%%%%%%%%%%%%%% 3.left(ab) left(ac) %%%%%%%%%%%%%%%%
% indet rel between b and c from the initial info. Third case where b and c are at the same place must also appear.

point(a;b;c).

&left_pp(a,b).
&left_pp(a,c).


----- EXPECTED OUTPUT -----
Answer: 1  (flingo will chose one of the 3 solutions depending of the witness)
a b c 
a b c (but with objects b and c at the same place)
a c b


%%%%%%%%%%%%%%%% 4.left(ab) left(ac) %%%%%%%%%%%%%%%%
% by adding the choice rule, we should get all the answers for left relation
point(a;b;c).

&left_pp(a,b).
&left_pp(a,c).

{&left_pp(P1,P2): point(P1), point(P2)}. 

----- EXPECTED OUTPUT -----
Answer: 1 
a b c 
Answer: 2 
a b c (but with objects b and c at the same place)
Answer: 3 
a c b



%%%%%%%%%%%%%%%% 5. combination of left_pp and alignedY_pp %%%%%%%%%%%%%%%%
point(a;b;c).

&left_pp(a,b).
&left_pp(a,c).

&alignedY_pp(a,b).
&alignedY_pp(a,c).

----- EXPECTED OUTPUT -----
Answer: 1  (flingo will chose one of the 3 solutions depending of the witness)
a b c 
a b c (but with objects b and c at the same place)
a c b

%%%%%%%%%%%%%%%% 6.indet+noSamePlace %%%%%%%%%%%%%%%%
% indet case where we normally have 3 answers but now the samePlace case with 'bc' is forbidden

point(a;b;c).

&left_pp(a,b).
&left_pp(a,c).

&alignedY_pp(a,b).
&alignedY_pp(a,c).

:- &samePlace_pp(P1,P2), point(P1), point(P2).


----- EXPECTED OUTPUT -----
Answer: 1 
a b c 
a c b  (with no obj at the same place)


%%%%%%%%%%%%%%%% 6. #count %%%%%%%%%%%%%%%%
% first(a) should be true because we haven't indeed been able to find something that is to the left of a. 

point(a;b).

&left_pp(a,b).
first(a) :- #count{P : &left_pp(P,a), point(P)}=0.  % unsafe without the point(X)


----- EXPECTED OUTPUT -----
Answer: 1
first(a) left_pp(a,b) 



%%%%%%%%%%%%%%%% 8. compound preds %%%%%%%%%%%%%%%%
% only 2 sols (and not 3) because the leftmost should remove the 'acb' solution 

point(a;b;c).

&left_pp(a,b).
&left_pp(a,c). 
&rightmost_p(c).

{&rightmost_p(P): point(P)}.


----- EXPECTED OUTPUT -----

Answer: 1 
a b c  (with b c at the same place)
Answer: 2
a b c




%%%%%%%%%%%%%%%% 9. eq %%%%%%%%%%%%%%%%
% we fix the value of x(a) to 5

point(a;b;c).

&left_pp(a,b).
&left_pp(a,c).

&eq(x(a),5).

%%%%%%%%%%%%%%%% 10. make_a_choice %%%%%%%%%%%%%%%%

&df.

point(a;b;c).

{&left_pp(a,b); &left_pp(b,a)}=1.

%%%%%%%%%%%%%%%% UP TO HERE %%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%% 8. rightmost_r %%%%%%%%%%%%%%%%
% rightmost_r(r1) should be true because we haven't indeed been able to find something that is to the right of r1. 

rect(a;b;c).

&right_rr(a,b).
&right_rr(a,c).

&rightmost_r(c).

% {&rightmost_r(R): rect(R)}.

%%%%%%%%%%%%%%%% 10. rules for testing optional answers %%%%%%%%%%%%%%%%

&left_pp(a, b).
&left_pp(b, c).
:- not #count{X : &right_pp(X, c)} = 1.  % only one elem to the right of c, as we'll see, can only be 'e'
:- not #count{X : &left_pp(X, d)} = 1.   % so 'd' must be same place as 'b' or between 'a' and 'b'
answer(a):- #count{X : &left_pp(X, e)} = 1.   % can never be triggered because 'e' as to be the one to the right of 'c'. 

----- EXPECTED OUTPUT -----
Answer 1: 
abcde
 d           % b and d at the same place
Answer 2:
adbce



%%%%%%%%%%%%%%%% 11. weak constraints that cannot be satisfied %%%%%%%%%%%%%%%%

&left_pp(a,b).
&left_pp(a,c).
:~ &left_pp(b,c). [1@1]

----- EXPECTED OUTPUT -----
Answer: 1 
left_pp(a,b) left_pp(b,c) left_pp(a,c)
Optimization: 1



%%%%%%%%%%%%%%%% 12. weak constraints that can be satisfied %%%%%%%%%%%%%%%%
% if we can, we avoid placing c and b on the same spot. 

&left_pp(a,b).
&left_pp(a,c).
:~ &samePlace_pp(b,c). [1@1]

----- EXPECTED OUTPUT -----
Answer: 1 
left_pp(a,b) left_pp(a,c) left_pp(c,b)
Optimization: 0



%%%%%%%%%%%%%%%% 13. weak constraints with 'not' %%%%%%%%%%%%%%%%
% we would like b and c to be on the same spot.  

&left_pp(a,b).
&left_pp(a,c).
:~ not &samePlace_pp(b,c). [1@1]

----- EXPECTED OUTPUT -----
% only 2 answers since we are looking for the optimum. 
Answer: 1 
left_pp(a,b) left_pp(a,c) point(c) point(a) point(b) left_pp(b,c)
Optimization: 1
Answer: 2 
left_pp(a,b) left_pp(a,c) point(c) point(a) point(b) samePlace_pp(b,c) samePlace_pp(c,b)
Optimization: 0





%%%%%%%%%%%%%%%% 14. strong negation %%%%%%%%%%%%%%%%

&left_pp(a,b).
&left_pp(a,c).
-&left_pp(b,c).

----- EXPECTED OUTPUT -----
Answer: 1 
left_pp(a,b) left_pp(a,c)  -left_pp(b,c) 
Answer: 2 
left_pp(a,b) left_pp(a,c)  -left_pp(b,c) 
 left_pp(c,b)






%%%%%%%%%%%%%%%% 15. strong negation %%%%%%%%%%%%%%%%

-&left_pp(a,b).
&samePlace_pp(a,b).

----- EXPECTED OUTPUT -----
Answer: 1 
samePlace_pp(a,b)  -left_pp(a,b) 
 samePlace_pp(b,a)





%%%%%%%%%%%%%%%% 16. By default (witout strong negation) %%%%%%%%%%%%%%%%


&left_pp(a,b).
&left_pp(a,c).
&left_pp(b,c):- not -&left_pp(b,c).

&left_pp(c,b).

%%%%%%%%%%%%%%%% 17. By default %%%%%%%%%%%%%%%%

&left_pp(a,b) :- not -&left_pp(b,c).
samePlace_pp(a,b).

----- EXPECTED OUTPUT -----
Answer: 1 
samePlace_pp(a,b)  -left_pp(a,b) 
 samePlace_pp(b,a)



%%%%%%%%%%%%%%%% 3.rectangle can only be 'on' a vertical line  %%%%%%%%%%%%%%%%
% this should be unsat considering the def of on_rl

line(a).
rect(b).

&vertical_l(a).
&on_rl(b,a).

----- EXPECTED OUTPUT -----
UNSATISFIABLE