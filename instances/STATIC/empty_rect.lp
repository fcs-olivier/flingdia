%*
metasp solve flingo --meta-config config.yaml \
                    --warn=no-atom-undefined \
                    instances/STATIC/empty_rect.lp  0 \
                    -c display_time=7  \
                    --project=show \
                    -c n=2 \
                    -t 4 \
                    --configuration=trendy
*%

point(a;b).
rect(c;d). 

&disconnected_rr(c,d) :- &initial.

&in_pr(a,c) :- &initial.
ok :- &empty_r(d).
hello.

{&move(a)}.


