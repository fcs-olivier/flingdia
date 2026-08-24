%*
metasp solve flingo --meta-config config.yaml \
                    --project=show \
                    --warn=no-atom-undefined \
                    instances/STATIC/3_points_indet.lp  0 \
                    -c display_time=7
*%


point(a;b;c).

&left_pp(a,b).
&left_pp(a,c).

{&left_pp(P1,P2): point(P1), point(P2)}. 

