%*
metasp solve flingo --meta-config config.yaml \
                    --project=show \
                    --warn=no-atom-undefined \
                    instances/STATIC/3_points_abc.lp  0 \
                    -c display_time=7  \
                    --printer table_printer
*%

point(a;b;c). 
&left(a,b).

% 1) transitive relation
%&left(b,c).
%p :- &left(a,c).

% 2) indeterminate configuration between b and c
&left(a,c).
{&left(P1,P2): point(P1), point(P2)}. 

% 3) remove the possibility of b and c being the same place
:- &samePlace(b,c).

% 4) c is the rightmost point
&rightmost(c).






