
%%%%%%%%%%%%%% MODULES %%%%%%%%%%%%%

% Countries, alphabetically ordered.
point(paris).
rect(austria;belgium;france;germany;italy;netherlands;poland;portugal;spain;switzerland;united_kingdom).


&in(paris, france).

% West/east relations.
&left(portugal,spain).
&left(spain,france).
&left(france,germany).
&left(france,italy).
&left(france,switzerland).
&left(france,belgium).
&left(belgium,germany).
&left(belgium,netherlands).
&left(netherlands,germany).
&left(germany,poland).
&left(switzerland,austria).
&left(switzerland,italy).
&left(united_kingdom,netherlands).
&left(united_kingdom,belgium).
&left(united_kingdom,germany).

% North/south relations.
&above(united_kingdom,france).
&above(netherlands,belgium).
&above(netherlands,france).
&above(belgium,france).
&above(germany,switzerland).
&above(germany,austria).
&above(poland,austria).
&above(france,spain).
&above(france,italy).
&above(switzerland,italy).
&above(austria,italy).
&above(spain,portugal).


% Land-border adjacency, both directions.
% &extConnected(portugal,spain).
% &extConnected(spain,france).
&extConnected(france,belgium).
% &extConnected(france,germany).
% &extConnected(france,italy).
% &extConnected(france,switzerland).
% &extConnected(belgium,netherlands).
% &extConnected(belgium,germany).
% &extConnected(netherlands,germany).
% &extConnected(germany,switzerland).
% &extConnected(germany,austria).
% &extConnected(germany,poland).
% &extConnected(switzerland,austria).
% &extConnected(switzerland,italy).
% &extConnected(austria,italy).

% % Clear disconnected/discrete examples.
&disconnected(united_kingdom,france).
&disconnected(united_kingdom,belgium).
% &disconnected(united_kingdom,netherlands).
% &disconnected(portugal,france).
% &disconnected(spain,germany).
% &disconnected(portugal,germany).
% &disconnected(italy,belgium).
% &disconnected(italy,netherlands).
% &disconnected(portugal,italy).
