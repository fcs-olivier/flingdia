%*
metasp solve flingo --meta-config config.yaml \
                    --project=show \
                    --warn=no-atom-undefined \
                    instances/STATIC/overloading_left.lp  1 \
                    -c display_time=7  
*%

point(ball;landmark).
rect(house).

objects(ball;house).

&left(landmark, P):- objects(P).






