%# Line relations
%
%## `&horizontal_l`
%
% True: `horizontal_l(l1)`; true: `horizontal_l(l2)`; false: not `horizontal_l(l3)`.
%
%```text
% y                                  y                                  y
% 3 | .   .   .   .                  3 | .   .   .   .                  3 | .   .   E   .   yend(l3)=3
% 2 | S-------E   .   ystart(l1)=2   2 | E-------S   .   ystart(l2)=2   2 | .   /   .   .
% 1 | .   .   .   .   yend(l1)=2     1 | .   .   .   .   yend(l2)=2     1 | S   .   .   .   ystart(l3)=1
% 0 | .   .   .   .                  0 | .   .   .   .                  0 | .   .   .   .
%   +----------------                  +----------------                  +----------------
%     0   1   2   3  x                  0   1   2   3  x                  0   1   2   3  x
%```

&sus{ystart(L,K)}=yend(L,K) :- true(&horizontal_l(L),K).

true(&horizontal_l(L),K) :- formula(spatial, &horizontal_l(L)), &sus{ystart(L,K)}=yend(L,K), time(K).


invalid_relation_arg(&horizontal_l(L)) :- formula(spatial, &horizontal_l(L)),
                                         #count {valid_arg_1 : true(line(L),K)} != 1,
                                         time(K).

%## `&vertical_l`
%
% True: `vertical_l(l1)`; true: `vertical_l(l2)`; false: not `vertical_l(l3)`.
%
%```text
% y                                  y                                  y
% 3 | .   E   .   .   xend(l1)=1     3 | .   S   .   .   xstart(l2)=1   3 | .   .   E   .   xend(l3)=2
% 2 | .   |   .   .                  2 | .   |   .   .                  2 | .   /   .   .
% 1 | .   S   .   .   xstart(l1)=1   1 | .   E   .   .   xend(l2)=1     1 | S   .   .   .   xstart(l3)=0
% 0 | .   .   .   .                  0 | .   .   .   .                  0 | .   .   .   .
%   +----------------                  +----------------                  +----------------
%     0   1   2   3  x                  0   1   2   3  x                  0   1   2   3  x
%```

&sus{xstart(L,K)}=xend(L,K) :- true(&vertical_l(L),K).

true(&vertical_l(L),K) :- formula(spatial, &vertical_l(L)), &sus{xstart(L,K)}=xend(L,K), time(K).


invalid_relation_arg(&vertical_l(L)) :- formula(spatial, &vertical_l(L)),
                                         #count {valid_arg_1 : true(line(L),K)} != 1,
                                         time(K).


