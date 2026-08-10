


% grows for RECTANGLE
&sus{(height(R,T)+1)}=:height(R,T1) :- T1=T+1, true(&grows(R),T), true(rect(R),T), T < n.
&sus{(width(R,T)+1)}=:width(R,T1) :- T1=T+1, true(&grows(R),T), true(rect(R),T), T < n. 

% Actions label transitions, so they cannot occur in the final state.
:- true(&grows(R), n).
