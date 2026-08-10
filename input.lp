


%*
metasp solve flingo --meta-config config.yaml \
                    --warn=no-atom-undefined \
                    input.lp  0 \
                    -c display_time=7  \
                    --project=show \
                    -c n=2 \
                    -c xmin=0 \
                    -c xmax=15 \
                    -c ymin=0 \
                    -c ymax=10 
*%


rect(a;b).
% &eq(left_side(b),xmax-1) :- &initial.
% &next(&eq(left_side(b),6)) :- &initial.



