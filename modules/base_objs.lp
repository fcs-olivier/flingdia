

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%  ground  : predefined line placed at the bottom of the space
%
% -------------------ground-------------------
%

&sus{ymin}=:ystart(ground,0):- true(predefined(ground),0).
&sus{ymin}=:yend(ground,0):-   true(predefined(ground),0).
&sus{xmin}=:xstart(ground,0):- true(predefined(ground),0).
&sus{xmax}=:xend(ground,0):-   true(predefined(ground),0).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%% table : a rectangle at the bottom of the space
%
% +----------------------------------------+
% |                  table                 |
% +----------------------------------------+
%


&sus{xmin}=:left_side(table,0):-  true(predefined(table), 0).
&sus{0}=:bottom(table,0):-        true(predefined(table), 0).
&sus{xmax-xmin}=:width(table,0):- true(predefined(table), 0).
&sus{1}=:height(table,0):-        true(predefined(table), 0).

