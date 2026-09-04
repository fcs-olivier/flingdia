
%*
metasp solve flingo --meta-config config.yaml \
                    --project=show \
                    --warn=no-atom-undefined \
                    instances/STATIC/distance.lp  0 \
                    -c display_time=10  \
*%


%point(a;b).
%&far(a,b).
rect(a;b).
&far(a,b).

