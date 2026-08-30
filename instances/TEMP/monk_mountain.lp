%*
metasp solve flingo --meta-config config.yaml \
                    --warn=no-atom-undefined \
                    --project=show \
                    instances/TEMP/monk_mountain.lp  1 \
                    -c display_time=10  \
                    -c n=10 
*%


point(bottom; monastary; monk1; monk2). 

line(mountain).

&eq(x(bottom),1). &eq(y(bottom),1).
&eq(x(monastary),9). &eq(y(monastary),9).

&fromTo(mountain, bottom, monastary) :- &initial.

{&move(monk1); &move(monk2)}.

&samePlace(monk1, bottom) :- &initial.
&samePlace(monk2, monastary) :- &initial.

:- &final, not &samePlace(monk1, monastary).
:- &final, not &samePlace(monk2, bottom).

:- not &on(monk1, mountain).
:- not &on(monk2, mountain).


yes :- &samePlace(monk1, monk2).
yes :- &samePlace(monk1, monk2).


