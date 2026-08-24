%*
metasp solve flingo --meta-config config.yaml \
                    --project=show \
                    --warn=no-atom-undefined \
                    instances/STATIC/3_points_abc.lp  0 \
                    -c display_time=7  
*%

point(a;b;c). 
&left_pp(a,b).
&left_pp(b,c).
p :- &left_pp(a,c).



