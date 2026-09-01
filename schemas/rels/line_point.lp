

%%%%%%%%%  LINE-POINT  %%%%%%%%%%%%%

%%%%%%%%%%%%%% startsAt  %%%%%%%%%%%%%
&sus{xstart(L,K)} = x(P,K) :- true(&startsAt(L,P),K), rel_startsAt_lp(L,P,K).
&sus{ystart(L,K)} = y(P,K) :- true(&startsAt(L,P),K), rel_startsAt_lp(L,P,K).

true(&startsAt(L,P),K) :- formula(spatial, &startsAt(L,P)),
                             &sus{xstart(L,K)} = x(P,K),
                             &sus{ystart(L,K)} = y(P,K),
                             time(K), rel_startsAt_lp(L,P,K).


%%%%%%%%%%%%%% endsAt  %%%%%%%%%%%%%
&sus{xend(L,K)} = x(P,K) :- true(&endsAt(L,P),K), rel_endsAt_lp(L,P,K).
&sus{yend(L,K)} = y(P,K) :- true(&endsAt(L,P),K), rel_endsAt_lp(L,P,K).

true(&endsAt(L,P),K) :- formula(spatial, &endsAt(L,P)),
                           &sus{xend(L,K)} = x(P,K),
                           &sus{yend(L,K)} = y(P,K),
                           time(K), rel_endsAt_lp(L,P,K).


