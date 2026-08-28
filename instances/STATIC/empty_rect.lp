%*
metasp solve flingo --meta-config config.yaml \
                    --warn=no-atom-undefined \
                    instances/STATIC/empty_rect.lp  0 \
                    -c display_time=7  \
                    --project=show \
                    -c n=2 \
                    -t 4 \
                    --configuration=trendy
*%

point(a).
rect(b;c). 

%&empty_r(b).

%&properPart_rr(b,c).
%&overlap_rr(b,c).

ok :- &empty_r(b).

&in_pr(a,b) :- &initial.
&discrete_rr(b,c) :- &initial.

:- not &in_pr(a,b).

:- not &discrete_rr(b,c).



