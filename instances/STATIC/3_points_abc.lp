%*
metasp solve flingo --meta-config config.yaml \
                    --project=show \
                    --warn=no-atom-undefined \
                    instances/STATIC/3_points_abc.lp  0 \
                    -c display_time=7  
*%

point(a;b;c). 
&left_pp(a,b).

% 1) transitive relation
%&left_pp(b,c).
%p :- &left_pp(a,c).

% 2) indeterminate configuration between b and c
&left_pp(a,c).
{&left_pp(P1,P2): point(P1), point(P2)}. 

% 3) remove the possibility of b and c being the same place
:- &samePlace_pp(b,c).

% 4) c is the rightmost point
&rightmost_p(c).






