%# Derived quantities
%
% A rectangle is represented by its bottom-left corner, width, and height.
% Its `right_side` and `top` parameters are derived from these values.
%
&sus{(left_side(R,K)+width(R,K))}=:right_side(R,K) :- true(rect(R),K).
&sus{(bottom(R,K)+height(R,K))}=:top(R,K)          :- true(rect(R),K).


