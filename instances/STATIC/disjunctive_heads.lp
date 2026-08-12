

%*
metasp solve flingo --meta-config config.yaml \
                    --project=show \
                    --warn=no-atom-undefined \
                    --printer=mpl_printer \
                    instances/STATIC/disjunctive_heads.lp  0 \
                    -c display_time=10  \
                    -c xmax=10 \
                    -c ymax=10
*%

&df.

rect(r1;r2).
point(p).

&touches_rp(r1,p).
&touches_rp(r2,p).

&extConnected_rr(r1,r2).
