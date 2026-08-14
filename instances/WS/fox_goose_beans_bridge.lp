%*
metasp solve flingo --meta-config config.yaml \
                    --warn=no-atom-undefined \
                    instances/ST/fox_goose_beans_bridge.lp  1 \
                    -c display_time=6  \
                    --project=show \
                    -c n=5 \
                    -t 4 \
                    --configuration=trendy
*%

&df :- &initial.
&inertia.

%%%% 4 facts below added for the bridge, + add option bridge with boat and bank in the rule below. That's it. 
rect(bridge).
&extConnected_rr(bridge,bank(near)).
&extConnected_rr(bridge,bank(far)).
&properPart_rr(bridge,river).

item(farmer;fox;goose;beans).
bank(near;far).
point(I) :- item(I).
rect(boat;river;bank(B)):- bank(B).

% items cannot be at the same place
:- &samePlace_pp(I1,I2), item(I1), item(I2).

&extConnected_rr(bank(near),river).
&extConnected_rr(bank(far),river).
&disconnected_rr(bank(near),bank(far)).
&properPart_rr(boat,river).

% the boat cannot reach both banks at the same time (implies that no animal can jump over the river)
:- &extConnected_rr(boat, bank(near)), &extConnected_rr(boat, bank(far)).

% items cannot be outside of banks or boat (implies no animals in the water)
:- item(I), not {&inEq_pr(I,boat);&inEq_pr(I,bridge); &in_pr(I, bank(B)): bank(B)}=1.

% the boat cannot move without the farmer in it
{&move(boat)} :- &inEq_pr(farmer, boat).

% the boat can only carry two items
:- #count{I : &inEq_pr(I,boat), item(I)}>2.

% the goose cannot stay with the beans without the farmer
:- &in_pr(goose,bank(Bank)), &in_pr(beans,bank(Bank)), not &in_pr(farmer,bank(Bank)), bank(Bank).

% the fox cannot stay with the goose without the farmer
:- &in_pr(fox,bank(Bank)), &in_pr(goose,bank(Bank)), not &in_pr(farmer,bank(Bank)), bank(Bank).

&in_pr(I,bank(near)):- item(I), &initial.
&in_pr(I,bank(far)):- item(I), &final.

{&move(I):item(I)}.





