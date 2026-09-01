


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

point(a;landmark).
rect(b).

players(a;b).

&left(landmark, P):- players(P).
%&left(b,c):- &initial.



