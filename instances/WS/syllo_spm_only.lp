%*
metasp solve flingo --meta-config config.yaml \
                    --project=show \
                    --warn=no-atom-undefined \
                    --quiet=1 \
                    instances/input.lp  0 \
                    --enum-mode=cautious 
*%

&df.
% +--------+----+----+----+----+----+----+----+----+----+----+----+----+----+----+----+----+
% |Fig     |AA  |AE  |AI  |AO  |EA  |EE  |EI  |EO  |IA  |IE  |II  |IO  |OA  |OE  |OI  |OO  |
% +--------+----+----+----+----+----+----+----+----+----+----+----+----+----+----+----+----+
% |1 mp sm |A,I |    |I   |    |E,O |    |O   |    |    |    |    |    |    |    |    |    |
% |2 pm sm |    |E,O |    |O   |E,O |    |O   |    |    |    |    |    |    |    |    |    |
% |3 mp ms |I   |    |I   |    |O   |    |O   |    |I   |    |    |O   |    |    |    |    |
% |4 pm ms |I   |E,O |    |    |O   |    |O   |    |I   |    |    |    |    |    |    |    |
% +--------+----+----+----+----+----+----+----+----+----+----+----+----+----+----+----+----+

syll(a,a,4).  % <- chose the syllogism here
fig(1, m,p, s,m).  fig(2, p,m, s,m).  fig(3, m,p, m,s).  fig(4, p,m, m,s).
statement(Type1, Term1, Term2) :- syll(Type1, _, Fig), fig(Fig, Term1, Term2, _, _).
statement(Type2, Term1, Term2) :- syll(_, Type2, Fig), fig(Fig, _, _, Term1, Term2).
rect(s;p;m).

1{&properPart_rr(X,Y);&equal_rr(X,Y)}                                             :- statement(a, X, Y).
&discrete_rr(X,Y)                                                                 :- statement(e, X, Y).
1{&properPart_rr(X,Y);&equal_rr(X,Y);&partialOverlap_rr(X,Y);&properPart_rr(Y,X)} :- statement(i, X, Y).
1{&partialOverlap_rr(X,Y);&properPart_rr(Y,X);&discrete_rr(X,Y)}                  :- statement(o, X, Y).

conclusion(a) :- 1{&properPart_rr(s,p) ; &equal_rr(s,p)}.
conclusion(e) :- &discrete_rr(s,p).
conclusion(i) :- 1{&properPart_rr(s,p); &equal_rr(s,p); &partialOverlap_rr(s,p); &properPart_rr(p,s)}.
conclusion(o) :- 1{&partialOverlap_rr(s,p); &properPart_rr(p,s); &discrete_rr(s,p)}.

#show conclusion/1.

%#defined s/0.
%#defined p/0.

