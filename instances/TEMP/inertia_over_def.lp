%*
metasp solve flingo --meta-config config.yaml \
                    --warn=no-atom-undefined \
                    instances/ST/inertia_over_def.lp  1 \
                    -c display_time=7  \
                    --project=show \
                    -c n=2 
*%

% recall that implicit axioms about definedness and inertia are added by default (axioms.lp)


% 1) We declare the objects
rect(a;b).

% 2) We can set some quantitive values
&eq(width(R),1) :- rect(R).
&eq(height(R),1) :- rect(R).

% 3) We declare an initial situation
&left_rr(a,b) :- &initial.

% 4) If we declare relations positively, they overwrite inertia
%&next(&on_rr(a,b)) :- &initial.
%&right_rr(a,b) :- &final.

% 4') Correct declaration
:- not &next(&on_rr(a,b)), &initial.
:- not &right_rr(a,b), &final.

% 5) We have to enable rects to 'move' if the rels in 4' must be constructively satisfied. 
{&move(R): rect(R)}1.








