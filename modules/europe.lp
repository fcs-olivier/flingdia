
%%%%%%%%%%%%%% MODULES %%%%%%%%%%%%%

% Countries, alphabetically ordered.
point(paris).
rect(austria;belgium;france;germany;italy;netherlands;poland;portugal;spain;switzerland;united_kingdom).


&in_pr(paris, france).

% West/east relations.
&left_rr(portugal,spain).
&left_rr(spain,france).
&left_rr(france,germany).
&left_rr(france,italy).
&left_rr(france,switzerland).
&left_rr(france,belgium).
&left_rr(belgium,germany).
&left_rr(belgium,netherlands).
&left_rr(netherlands,germany).
&left_rr(germany,poland).
&left_rr(switzerland,austria).
&left_rr(switzerland,italy).
&left_rr(united_kingdom,netherlands).
&left_rr(united_kingdom,belgium).
&left_rr(united_kingdom,germany).

% North/south relations.
&above_rr(united_kingdom,france).
&above_rr(netherlands,belgium).
&above_rr(netherlands,france).
&above_rr(belgium,france).
&above_rr(germany,switzerland).
&above_rr(germany,austria).
&above_rr(poland,austria).
&above_rr(france,spain).
&above_rr(france,italy).
&above_rr(switzerland,italy).
&above_rr(austria,italy).
&above_rr(spain,portugal).


% Land-border adjacency, both directions.
% &extConnected_rr(portugal,spain).
% &extConnected_rr(spain,france).
&extConnected_rr(france,belgium).
% &extConnected_rr(france,germany).
% &extConnected_rr(france,italy).
% &extConnected_rr(france,switzerland).
% &extConnected_rr(belgium,netherlands).
% &extConnected_rr(belgium,germany).
% &extConnected_rr(netherlands,germany).
% &extConnected_rr(germany,switzerland).
% &extConnected_rr(germany,austria).
% &extConnected_rr(germany,poland).
% &extConnected_rr(switzerland,austria).
% &extConnected_rr(switzerland,italy).
% &extConnected_rr(austria,italy).

% % Clear disconnected/discrete examples.
&disconnected_rr(united_kingdom,france).
&disconnected_rr(united_kingdom,belgium).
% &disconnected_rr(united_kingdom,netherlands).
% &disconnected_rr(portugal,france).
% &disconnected_rr(spain,germany).
% &disconnected_rr(portugal,germany).
% &disconnected_rr(italy,belgium).
% &disconnected_rr(italy,netherlands).
% &disconnected_rr(portugal,italy).
