%*
metasp solve flingo --meta-config config.yaml \
                    --warn=no-atom-undefined \
                    instances/STATIC/empty_rect.lp  1 \
                    -c display_time=7  \
                    --project=show \
                    -c n=12 \
                    -t 4 \
                    --configuration=trendy
*%

point(a).
rect(b;c). 

%&empty_r(b).

%&properPart_rr(b,c).
%&overlap_rr(b,c).

ok :- &empty_r(b).



