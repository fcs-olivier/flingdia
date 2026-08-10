%*
metasp solve flingo --meta-config config.yaml \
                    --warn=no-atom-undefined \
                    instances/ST/fox_goose_beans.lp  1 \
                    -c display_time=20  \
                    --project=show \
                    -c n=17
*%

% n<=16  UNSAT, from 17 it works and this is the faster  (16 is slower)
&df :- &initial.
&inertia.

item(farmer;fox;goose;beans).
bank(near;far).
point(I) :- item(I).
rect(boat;river;bank(B)):- bank(B).

% FIRST VERSION BUG 
% Putting &disconnected_rr / &properPart_rr in a rule head makes flingo's foundedness check 
% thrash on the schema's strict inequalities (EC in the head is fine).
% &extConnected_rr(bank(near),river):- &initial.
% &extConnected_rr(bank(far),river):- &initial.
% &disconnected_rr(bank(near),bank(far)):- &initial.
% &properPart_rr(boat,river):- &initial.
% SECOND VERSION (I use the axiom df so it should be equivalent to the first OPTION)
:- &initial, not &extConnected_rr(bank(near),river).  
:- &initial, not &extConnected_rr(bank(far),river).
:- &initial, not &disconnected_rr(bank(near),bank(far)).
:- &initial, not &properPart_rr(boat,river).
% THIRD VERSION (but does not work, loops)
% &eq(left_side(bank(near)),0) :- &initial.
% &eq(bottom(bank(near)),0) :- &initial.
% &eq(width(bank(near)),3) :- &initial.
% &eq(height(bank(near)),10) :- &initial.

% &eq(left_side(river),3) :- &initial.
% &eq(bottom(river),0) :- &initial.
% &eq(width(river),4) :- &initial.
% &eq(height(river),10) :- &initial.

% &eq(left_side(bank(far)),7) :- &initial.
% &eq(bottom(bank(far)),0) :- &initial.
% &eq(width(bank(far)),3) :- &initial.
% &eq(height(bank(far)),10) :- &initial.

% &eq(left_side(boat),3) :- &initial.
% &eq(bottom(boat),4) :- &initial.
% &eq(width(boat),2) :- &initial.
% &eq(height(boat),2) :- &initial.

% items cannot be at the same place
:- &samePlace_pp(I1,I2), item(I1), item(I2).

% banks must remain connected to the river and disconnected from each other, 
:- not &extConnected_rr(bank(near),river).
:- not &extConnected_rr(bank(far),river).
:- not &disconnected_rr(bank(near),bank(far)).

% the boat must remain a proper part of the river
:- not &properPart_rr(boat,river).

% the boat cannot reach both banks at the same time (implies that no animal can jump over the river)
% (metasp bug) not &not: force registration (guard-free :- &EC(boat,…) is dropped by metasp)
:- not &not(&extConnected_rr(boat, bank(near))), not &not(&extConnected_rr(boat, bank(far))).

% items cannot be outside of banks or boat (implies no animals in the water)
:- item(I), not {&inEq_pr(I,boat); &in_pr(I, bank(B)): bank(B)}=1.

%:- item(I), &in_pr(I, river), not {&inEq_pr(I, R): rect(R), R!=river}=1.

% the boat cannot move without the farmer in it
{&move(boat)} :- &inEq_pr(farmer, boat).

% the boat can only carry two items
:- #count{I : &inEq_pr(I,boat), item(I)}>2.

% the goose cannot stay with the beans without the farmer
:- &in_pr(goose,bank(Bank)), &in_pr(beans,bank(Bank)), not &in_pr(farmer,bank(Bank)), bank(Bank).

% the fox cannot stay with the goose without the farmer
:- &in_pr(fox,bank(Bank)), &in_pr(goose,bank(Bank)), not &in_pr(farmer,bank(Bank)), bank(Bank).

&in_pr(I,bank(near)):- item(I), &initial.
:- item(I), &final, not &in_pr(I,bank(far)).

{&move(I):item(I)}.





