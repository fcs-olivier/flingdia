%*
metasp solve flingo --meta-config config.yaml \
                    --warn=no-atom-undefined \
                    instances/ST/growing_rect.lp  1 \
                    -c display_time=9  \
                    --project=show \
                    -c n=7
*%

% Growth case: rectangle c grows until externally connected with d
% (double-negated endpoint). Tests temporal until, inertia, and spatial
% ramification (a may end up inside c). 

point(a;b).
rect(c;d).

%%%%%%% 1) Let 'a' and 'b' be two points, 'c' a rectangle with radius 1.5, and 'd' a rectangle of height 5.
&eq(width(c),1) :- &initial.
&eq(height(d),5) :- &initial.

%%%%%%% 2) Initially, point 'a' lies to the right of rectangle 'c' 
%                     point 'a' lies to the left of rectangle 'd', 
%                     point 'a' is horizontally aligned with rectangle 'c'.
&right(a,c) :- &initial.
&left(a,d) :- &initial.
&alignedY(a,c) :- &initial.

%%%%%%% 3) Point 'b' is initially horizontally aligned with point 'a'. 
%          At the next step, the future position of point 'b' lies to the left of the initial position of point 'a'.
&alignedY(b,a) :- &initial.
&next(&left(b,a)) :- &initial.


%%%%%%% 4) At any time, a propositional condition 'p' may become true, triggering an increase in the size of
%                       rectangle 'c' until external connection with rectangle 'd' is reached.

&until(&grows(c),&not(&not(&extConnected(c,d)))) :- p.


% Declare the propositional condition 'p' to start the growing process.
p :- &initial.

&eq(x(a),2).
&eq(y(a),1).
&eq(x(b),4) :- &initial.
&eq(y(b),1) :- &initial.







