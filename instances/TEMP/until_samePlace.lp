%*
metasp solve flingo --meta-config config.yaml \
                    --warn=no-atom-undefined \
                    instances/TEMP/until_samePlace.lp  0 \
                    -c display_time=7  \
                    --project=show \
                    -c n=10
*%


point(a;b).

&eq(x(a),1) :- &initial.
&eq(y(a),1) :- &initial.
&eq(x(b),6) :- &initial.
&eq(y(b),6) :- &initial.

%&until(&move(a), &samePlace(a,b)) :- go.  % without not not, the rel's support allows points to jump to a same place. 
&until(&move(a), &not(&not(&samePlace(a,b)))) :- go.


&next(&next(go)) :- &initial.





