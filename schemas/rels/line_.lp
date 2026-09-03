%%% LINE

%# `horizontal(L)`
%
% Line `L` is horizontal exactly when its start and end have the same `y` coordinate.
%
% ![`&horizontal`](../../assets/relations/horizontal_l.svg)
%

&sus{ystart(L,K)}=yend(L,K) :- true(&horizontal(L),K), rel_horizontal_l(L,K).

true(&horizontal(L),K) :- formula(spatial, &horizontal(L)), &sus{ystart(L,K)}=yend(L,K), time(K), rel_horizontal_l(L,K).


%# `vertical(L)`
%
% Line `L` is vertical exactly when its start and end have the same `x` coordinate.
%
% ![`&vertical`](../../assets/relations/vertical_l.svg)
%

&sus{xstart(L,K)}=xend(L,K) :- true(&vertical(L),K), rel_vertical_l(L,K).

true(&vertical(L),K) :- formula(spatial, &vertical(L)), &sus{xstart(L,K)}=xend(L,K), time(K), rel_vertical_l(L,K).

%# `diagonal(L)`
%
% Line `L` is diagonal exactly when the absolute changes in its endpoint
% `x` and `y` coordinates are equal.
%
% ![`&diagonal`](../../assets/relations/diagonal_l.svg)
%


% diagonal_pos_l(L,K) |
% diagonal_neg_l(L,K) :- true(&diagonal(L),K).

% &sus{(xend(L,K)-xstart(L,K))} = (yend(L,K)-ystart(L,K)) :- diagonal_pos_l(L,K).
% &sus{(xend(L,K)-xstart(L,K))} = (ystart(L,K)-yend(L,K)) :- diagonal_neg_l(L,K).

% diagonal_pos_l(L,K) :- formula(spatial, &diagonal(L)),
%                        &sus{(xend(L,K)-xstart(L,K))} = (yend(L,K)-ystart(L,K)),
%                        time(K).

% diagonal_neg_l(L,K) :- formula(spatial, &diagonal(L)),
%                        &sus{(xend(L,K)-xstart(L,K))} = (ystart(L,K)-yend(L,K)),
%                        time(K).

% true(&diagonal(L),K) :- formula(spatial, &diagonal(L)),
%                           diagonal_pos_l(L,K),
%                           time(K).

% true(&diagonal(L),K) :- formula(spatial, &diagonal(L)),
%                           diagonal_neg_l(L,K),
%                           time(K).



