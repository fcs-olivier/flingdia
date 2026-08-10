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


point(a;b).
%&left_pp(a,b) :- &initial.


&move(a).
%&move(b).


% we displace only one object at a time, and only that for which we haven't proved they could not move. 
{&move(O):point(O), not cannot_move(O)}=1.




