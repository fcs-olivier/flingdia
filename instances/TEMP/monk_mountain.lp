%*
metasp solve flingo --meta-config config.yaml \
                    --warn=no-atom-undefined \
                    --project=show \
                    instances/TEMP/monk_mountain.lp  0 \
                    -c display_time=10  \
                    -c n=5 
*%


point(bottom; monastary; monk). 

line(mountain).

&eq(x(bottom),1). &eq(y(bottom),1).
&eq(x(monastary),9). &eq(y(monastary),9).

&fromTo_lpp(mountain, bottom, monastary).

{&move(monk)}.


