%*
metasp solve flingo --meta-config config.yaml \
                    --warn=no-atom-undefined \
                    instances/input.lp  0 \
                    -c display_time=7  \
                    --project=show \
                    -c n=2 \
                    -c xmin=0 \
                    -c xmax=10 \
                    -c ymin=0 \
                    -c ymax=10 \
                    --stats
*%


rect(a;b).
&left_rr(a,b) :- &initial.
&next(&on_rr(b,a)) :- &initial.



