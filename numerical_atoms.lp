

%%%%%%%%%%%%% POINTS %%%%%%%%%%%%%
% 0) POINT parameters :
%    x, y

% 1) POINT set specific parameters and derived terms
&sus{Value}=:x(P,K)          :- true(&eq(x(P),Value),K).
&sus{Value}=:y(P,K)          :- true(&eq(y(P),Value),K).


%%%%%%%%%%%%% RECTANGLES %%%%%%%%%%%%%
% 0) RECATNGLE parameters :
%    left_side, bottom, width, height

% 1) RECATNGLE set specific parameters and derived terms
&sus{Value}=:left_side(R,K)  :- true(&eq(left_side(R),Value),K).
&sus{Value}=:right_side(R,K) :- true(&eq(right_side(R),Value),K).
&sus{Value}=:bottom(R,K)     :- true(&eq(bottom(R),Value),K).
&sus{Value}=:top(R,K)        :- true(&eq(top(R),Value),K).
&sus{Value}=:width(R,K)      :- true(&eq(width(R),Value),K).
&sus{Value}=:height(R,K)     :- true(&eq(height(R),Value),K).



%%%%%%%%%%%%% LINES %%%%%%%%%%%%%
% 0) LINE parameters :
%    xstart, xend, ystart, yend

% 1) LINE set specific parameters and derived terms
&sus{Value}=:xstart(L,K)     :- true(&eq(xstart(L),Value),K).
&sus{Value}=:xend(L,K)       :- true(&eq(xend(L),Value),K).
&sus{Value}=:ystart(L,K)     :- true(&eq(ystart(L),Value),K).
&sus{Value}=:yend(L,K)       :- true(&eq(yend(L),Value),K).