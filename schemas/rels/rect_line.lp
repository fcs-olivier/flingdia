%%% RECT LINE

%# `on(R1,L2)`
%
% Line `L2` is horizontal at the bottom side of rectangle `R1`, starts at or
% left of its left side, and ends at or right of its right side.
%
% ![`&on`](../../assets/relations/on_rl.svg)
%

&sus{xstart(L2,K)}<= left_side(R1,K) :- true(&on(R1,L2),K), rel_on_rl(R1,L2,K).
&sus{xend(L2,K)}>= right_side(R1,K) :- true(&on(R1,L2),K), rel_on_rl(R1,L2,K).
&sus{ystart(L2,K)}= bottom(R1,K) :- true(&on(R1,L2),K), rel_on_rl(R1,L2,K).
:- true(&on(R1,L2),K), not &sus{ystart(L2,K)}=yend(L2,K), rel_on_rl(R1,L2,K).  % the line must be horizontal


true(&on(R1,L2),K) :- formula(spatial, &on(R1,L2)),
                        &sus{ystart(L2,K)}=yend(L2,K),    % the line must be horizontal
                        &sus{xstart(L2,K)}<= left_side(R1,K),
                        &sus{xend(L2,K)}>= right_side(R1,K),
                        &sus{ystart(L2,K)}= bottom(R1,K),
                        time(K), rel_on_rl(R1,L2,K).



