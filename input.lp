


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

point(a;b;c).
% &left_pp(a,b).
% &left_pp(a,c).
%:- &samePlace_pp(b,c).
&rightmost_p(b).

