%*
metasp solve flingo --meta-config config.yaml \
                    --warn=no-atom-undefined \
                    instances/ST/fox_goose_beans.lp  1 \
                    -c display_time=7  \
                    --project=show \
                    -c n=12 \
                    -t 4 \
                    --configuration=trendy
*%

% n=12 seems to be the fastest (11 seems slower, at 10 it is unsat)
% inEq is containmnent for items in the boat only (on banks, items are strictly contained)
point(I) :- item(I).                    item(farmer;fox;goose;beans).
rect(boat;river;bank(B)):- bank(B).     bank(near;far).

% Initially declare the banks, the boat, and the position of the objects. 
&extConnected(bank(B),river):- &initial, bank(B).
&disconnected(bank(near),bank(far)):- &initial.
&properPart(boat,river):- &initial.
&in(I,bank(near)):- &initial, item(I).

% banks must remain connected to the river and disconnected from each other
% TODO: normally these are straightforward derived relations by inertia, but adding them explicitly improves the performance. 
:- not &extConnected(bank(near),river).
:- not &extConnected(bank(far),river).
:- not &disconnected(bank(near),bank(far)).

% Define the dynamic
{&move(I):item(I)}.        % All the items can move. 
{&move(boat)} :- &inEq(farmer, boat).  % The boat can move when the farmer is in it

% the boat must remain a proper part of the river
:- not &properPart(boat,river).

% the boat cannot reach both banks at the same time (implies that no animal can jump over the river)
:- &extConnected(boat, bank(near)), &extConnected(boat, bank(far)).

% items cannot be outside of banks or boat (implies no animals in the water)
:- item(I), not {&inEq(I,boat); &in(I, bank(B)): bank(B)}=1.
%:- item(I), not &inEq(I, R): rect(R), R!=river.
%:- item(I), &inEq(I, river), not &inEq(I, boat).

% the boat can only carry two items
:- #count{I : &inEq(I,boat), item(I)}>2.

% the goose+beans/fox+goose can't stay alone without the farmer.
:- &in(goose,bank(Bank)), &in(beans,bank(Bank)), not &in(farmer,bank(Bank)), bank(Bank).
:- &in(fox,bank(Bank)), &in(goose,bank(Bank)), not &in(farmer,bank(Bank)), bank(Bank).

% For visibility, items cannot be at the same place
:- &samePlace(I1,I2), item(I1), item(I2).

% Goal state
:- &final, item(I), not &in(I,bank(far)).







