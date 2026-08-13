

point(a;b;c;d).
rect(r).

% Let say that all the points have to be on the diagonal to be valid

% 1) term with constants only
&eq(x(a),0+1).
&eq(y(a),2/2).

% 2) more complex terms with constants only
&eq(x(b),(2+2)-2).
&eq(y(b),10-(3*3)+1).

% 3) space bounds 
&eq(x(c),10).
&eq(y(c),xmax).  % both CLI and default

% 4) space bounds in terms
&eq(x(d),9).
&eq(y(d),xmax-1).  % BUG: only with CLI, 
                   % bug with default, comes too late. 

% 5) derived-quantity
&eq(top(r), 6).    % It assigns to top, but leave all other undefined.


%*
metasp solve flingo --meta-config config.yaml \
                    --project=show \
                    --warn=no-atom-undefined \
                    instances/STATIC/all_num_consts.lp  0 \
                    -c display_time=7 
*%

%*
metasp solve flingo --meta-config config.yaml \
                    --warn=no-atom-undefined \
                    instances/STATIC/all_num_consts.lp  0 \
                    -c display_time=7  \
                    --project=show \
                    -c n=2 \
                    -c xmin=0 \
                    -c xmax=10 \
                    -c ymin=0 \
                    -c ymax=10 
*%


