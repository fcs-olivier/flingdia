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

&discrete(c,d) :- &initial.
&in(a,c) :- &initial.
&out(b,d) :- &initial.

{&move(b)}.

%ok :- &empty(R), rect(R).



:- &final, &empty(R), rect(R).

%:- &initial, &empty(R), rect(R), not &eventually(&in(a,R)).


