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
&extConnected(bridge,bank(near)).
&extConnected(bridge,bank(far)).
&properPart(bridge,river).

item(farmer;fox;goose;beans).
bank(near;far).
point(I) :- item(I).
rect(boat;river;bank(B)):- bank(B).

% items cannot be at the same place
:- &samePlace(I1,I2), item(I1), item(I2).

&extConnected(bank(near),river).
&extConnected(bank(far),river).
&disconnected(bank(near),bank(far)).
&properPart(boat,river).

% the boat cannot reach both banks at the same time (implies that no animal can jump over the river)
:- &extConnected(boat, bank(near)), &extConnected(boat, bank(far)).

% items cannot be outside of banks or boat (implies no animals in the water)
:- item(I), not {&inEq(I,boat);&inEq(I,bridge); &in(I, bank(B)): bank(B)}=1.

% the boat cannot move without the farmer in it
{&move(boat)} :- &inEq(farmer, boat).

% the boat can only carry two items
:- #count{I : &inEq(I,boat), item(I)}>2.

% the goose cannot stay with the beans without the farmer
:- &in(goose,bank(Bank)), &in(beans,bank(Bank)), not &in(farmer,bank(Bank)), bank(Bank).

% the fox cannot stay with the goose without the farmer
:- &in(fox,bank(Bank)), &in(goose,bank(Bank)), not &in(farmer,bank(Bank)), bank(Bank).

&in(I,bank(near)):- item(I), &initial.
&in(I,bank(far)):- item(I), &final.

{&move(I):item(I)}.





