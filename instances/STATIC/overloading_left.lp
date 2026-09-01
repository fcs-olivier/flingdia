%*
metasp solve flingo --meta-config config.yaml \
                    --project=show \
                    --warn=no-atom-undefined \
                    instances/STATIC/overloading_left.lp  0 \
                    -c display_time=7  
*%

point(a;landmark).
rect(b).

players(a;b).

&left(landmark, P):- players(P).






