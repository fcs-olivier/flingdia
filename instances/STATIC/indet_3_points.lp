%*
metasp solve flingo --meta-config config.yaml \
                    --project=show \
                    --warn=no-atom-undefined \
                    instances/STATIC/indet_3_points.lp  0 \
                    -c display_time=7 
*%


%&partial.
point(a;b;c).

&left_pp(a,b).
&left_pp(a,c).

{&left_pp(P1,P2): point(P1), point(P2)}. 








% Example CLI bounds: -c xmin=0 -c xmax=18 -c ymin=0 -c ymax=12 -c zmin=0 -c zmax=10

% rect(d;e).
% &ntpp_rr(d,e).

% &in_pr(a,d).

