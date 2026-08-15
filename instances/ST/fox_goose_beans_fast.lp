%*
metasp solve flingo --meta-config config.yaml \
                    --warn=no-atom-undefined \
                    instances/ST/fox_goose_beans_fast.lp  1 \
                    -c display_time=7  \
                    --project=show \
                    -c n=12 \
                    -t 4 \
                    --configuration=trendy
*%

% with n=12, it can go down to 8 seconds. At 11 seems slower, at 10 it is unsat. 

point(I) :- item(I).                    item(farmer;fox;goose;beans).
rect(boat;river;bank(B)):- bank(B).     bank(near;far).

% Initially declare the banks, the boat, and the position of the objects. 
&extConnected_rr(bank(near),river):- &initial.
&extConnected_rr(bank(far),river):- &initial.
&disconnected_rr(bank(near),bank(far)):- &initial.
&properPart_rr(boat,river):- &initial.
&in_pr(I,bank(near)):- item(I), &initial.

% Define the dynamic
{&move(I):item(I)}.        % All the items can move. 
{&move(boat)} :- &inEq_pr(farmer, boat).  % The boat can move when the farmer is in it

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
:- &extConnected_rr(boat, bank(near)), &extConnected_rr(boat, bank(far)).

% items cannot be outside of banks or boat (implies no animals in the water)
:- item(I), not {&inEq_pr(I,boat); &in_pr(I, bank(B)): bank(B)}=1.
%:- item(I), &in_pr(I, river), not {&inEq_pr(I, R): rect(R), R!=river}=1.

% the boat can only carry two items
:- #count{I : &inEq_pr(I,boat), item(I)}>2.

% the goose+beans/fox+goose can stay alone without the farmer.
:- &in_pr(goose,bank(Bank)), &in_pr(beans,bank(Bank)), not &in_pr(farmer,bank(Bank)), bank(Bank).
:- &in_pr(fox,bank(Bank)), &in_pr(goose,bank(Bank)), not &in_pr(farmer,bank(Bank)), bank(Bank).

% Goal state
:- item(I), &final, not &in_pr(I,bank(far)).






