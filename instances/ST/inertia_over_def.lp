%*
metasp solve flingo --meta-config config.yaml \
                    --warn=no-atom-undefined \
                    instances/ST/inertia_over_def.lp  1 \
                    -c display_time=7  \
                    --project=show \
                    -c n=2 
*%

&df:-&initial.
&inertia.


{&move(R): rect(R)}1.

&eq(width(R),1) :- rect(R).
&eq(height(R),1) :- rect(R).


rect(a;b).

&left_rr(a,b) :- &initial.
% &next(&on_rr(a,b)) :- &initial.
%&right_rr(a,b) :- &final.


:- not &next(&on_rr(a,b)), &initial.
:- not &right_rr(a,b), &final.







