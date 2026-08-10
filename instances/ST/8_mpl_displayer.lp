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

&df.
point(a;b;c).
%{&left_pp(a,b) ; &left_pp(b,a)}=1 :- &initial.
&left_pp(a,b) :- &initial.
p :- &next(&left_pp(b,a)), &initial.
{q}.

%r :- &final. 

%&next(p) :- &initial.
%&next(&left_pp(b,a)) :- &initial.
%&next(&next(&left_pp(a,b))) :- &initial.


