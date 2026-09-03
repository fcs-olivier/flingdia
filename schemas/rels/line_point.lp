%%% LINE POINT

%# `startsAt(L,P)`
%
% Line `L` starts at point `P` exactly when its start coordinates equal
% the coordinates of `P`.
%
% ![`&startsAt`](../../assets/relations/startsAt_lp.svg)
%
&sus{xstart(L,K)} = x(P,K) :- true(&startsAt(L,P),K), rel_startsAt_lp(L,P,K).
&sus{ystart(L,K)} = y(P,K) :- true(&startsAt(L,P),K), rel_startsAt_lp(L,P,K).

true(&startsAt(L,P),K) :- formula(spatial, &startsAt(L,P)),
                             &sus{xstart(L,K)} = x(P,K),
                             &sus{ystart(L,K)} = y(P,K),
                             time(K), rel_startsAt_lp(L,P,K).

%# `endsAt(L,P)`
%
% Line `L` ends at point `P` exactly when its end coordinates equal
% the coordinates of `P`.
%
% ![`&endsAt`](../../assets/relations/endsAt_lp.svg)
%
&sus{xend(L,K)} = x(P,K) :- true(&endsAt(L,P),K), rel_endsAt_lp(L,P,K).
&sus{yend(L,K)} = y(P,K) :- true(&endsAt(L,P),K), rel_endsAt_lp(L,P,K).

true(&endsAt(L,P),K) :- formula(spatial, &endsAt(L,P)),
                           &sus{xend(L,K)} = x(P,K),
                           &sus{yend(L,K)} = y(P,K),
                           time(K), rel_endsAt_lp(L,P,K).


