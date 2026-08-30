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

% FIRST OPTION: compute on letters m, p, s
% syll(a,a,1).  % <- chose the syllogism here
% fig(1, m,p, s,m).  fig(2, p,m, s,m).  fig(3, m,p, m,s).  fig(4, p,m, m,s).
% statement(Type1, Term1, Term2) :- syll(Type1, _, Fig), fig(Fig, Term1, Term2, _, _).
% statement(Type2, Term1, Term2) :- syll(_, Type2, Fig), fig(Fig, _, _, Term1, Term2).
% target(s,p).

% SECOND OPTION: decide your own terms
statement(a, man, greek).
statement(a, greek, mortal).
target(mortal, man).

%%% spatial resolution
rect(Term) :- statement(_, Term, _).
rect(Term) :- statement(_, _, Term).

1{&properPart(X,Y);&equal(X,Y)}                                             :- statement(a, X, Y).
&discrete(X,Y)                                                                 :- statement(e, X, Y).
1{&properPart(X,Y);&equal(X,Y);&partialOverlap(X,Y);&properPart(Y,X)} :- statement(i, X, Y).
1{&partialOverlap(X,Y);&properPart(Y,X);&discrete(X,Y)}                  :- statement(o, X, Y).

conclusion(a,X,Y) :- target(X,Y), 1{&properPart(X,Y); &equal(X,Y)}.
conclusion(e,X,Y) :- target(X,Y), &discrete(X,Y).
conclusion(i,X,Y) :- target(X,Y), 1{&properPart(X,Y); &equal(X,Y); &partialOverlap(X,Y); &properPart(Y,X)}.
conclusion(o,X,Y) :- target(X,Y), 1{&partialOverlap(X,Y); &properPart(Y,X); &discrete(X,Y)}.

#show conclusion/3.

%#defined s/0.
%#defined p/0.

