%*
metasp solve flingo --meta-config config.yaml \
                    --warn=no-atom-undefined \
                    instances/TEMP/fill_empty_rect.lp  0 \
                    -c display_time=7  \
                    --project=show \
                    -c n=4 \
                    -t 4 \
                    --configuration=trendy
*%

point(a;b).
rect(c;d). 

&discrete_rr(c,d) :- &initial.
&in_pr(a,c) :- &initial.
&out_pr(b,d) :- &initial.

{&move(b)}.

%ok :- &empty_r(R), rect(R).



:- &final, &empty_r(R), rect(R).

%:- &initial, &empty_r(R), rect(R), not &eventually(&in_pr(a,R)).


