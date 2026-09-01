%*
metasp solve flingo --meta-config config.yaml \
                    --warn=no-atom-undefined \
                    --project=show \
                    instances/TEMP/bridge_and_torch.lp  1 \
                    -c display_time=7  \
                    -c n=5 
*%

% A bridge will collapse in 17 minutes. 
% 4 people want to cross it before it will collapse. 
% It is a dark night and there is only one torch between them. 
% Only two people can cross at a time. 
% “A” takes 1 minute to cross. 
% “B” takes 2 minutes. 
% “C” takes 5 minutes. 
% “D” takes 10 minutes. 
% How do they cross the bridge.


line(bridge).
point(near;far).
&horizontal(bridge) :- &initial.
&fromTo(bridge, near, far) :- &initial.
person(a,1;b,2;c,5;d,10).
point(near; far;P) :- person(P,_).

torch(17):- &initial.

torch(T-Duration) :- person(P, Duration), torch(T),
                     &samePlace(P, near), &next(&samePlace(P, far)).


% side(near;far).
% rect(bridge; side(R)):- side(R).
% person(a,1;b,2;c,5;d,10).
% point(P) :- person(P,_).

% &extConnected(side(far),bridge):- &initial. 
% &extConnected(side(near),bridge):- &initial. 
% &disconnected(side(near),side(far)):- &initial. 

% torch(17).






