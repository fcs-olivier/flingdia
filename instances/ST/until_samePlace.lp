%*
metasp solve flingo --meta-config config.yaml \
                    --warn=no-atom-undefined \
                    instances/ST/until_samePlace.lp  0 \
                    -c display_time=7  \
                    --project=show \
                    -c n=10
*%


&df :- &initial.
&inertia.


point(a;b).

&eq(x(a),1) :- &initial.
&eq(y(a),1) :- &initial.
&eq(x(b),6) :- &initial.
&eq(y(b),6) :- &initial.

&until(&move(a), &not(&not(&samePlace_pp(a,b)))) :- go.
%&until(&move(a), &samePlace_pp(a,b)) :- go.  % PROB: support allows points to jump to a same place. 


&next(&next(go)) :- &initial.





