



%*
metasp solve flingo --meta-config config.yaml \
                    --project=show \
                    --warn=no-atom-undefined \
                    instances/input.lp  0 \
                    -c display_time=30  
*%


% beginning for propositional logic formalization. 
% We need to add a universe, and the fact that they can become points. 
% Without the frame and the shrinking cases, we simply have RCC5. 


rect(universe).

{point(a);rect(a)}=1.
{point(b);rect(b)}=1.

&eq(bottom(universe),0).
&eq(top(universe),9).
&eq(left_side(universe),0).
&eq(right_side(universe),9).

{&discrete_rr(R1,R2): rect(R1), rect(R2), R1!=R2, R1!=universe, R2!=universe}.
{&partialOverlap_rr(R1,R2): rect(R1), rect(R2), R1!=R2, R1!=universe, R2!=universe}.
{&equal_rr(R1,R2): rect(R1), rect(R2), R1!=R2, R1!=universe, R2!=universe}.
{&properPart_rr(R1,R2): rect(R1), rect(R2), R1!=R2, R1!=universe, R2!=universe}.
% I don't get why I have ERROR: Invalid relation >> properPart_rr(a,b) <<. Arguments have wrong sorts or use undeclared objects. Solving stopped.
