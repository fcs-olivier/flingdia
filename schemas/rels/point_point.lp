%# Point-point relations
%
% Relations between two points. Each relation comes with three rules: one propagating
% the constraint on the coordinates when the relation is asserted, one deriving the
% relation from the coordinates, and one reporting arguments of the wrong sort.

%*! invalid_relation_arg(A)

Reports that the atom `A` is applied to arguments of the wrong geometric sort.

For instance `&left_pp(P,R)` where `R` is a rectangle rather than a point.

Args:
    - A: the offending relation atom
*%

%*! left_pp(P1,P2)

Theory atom `&left_pp/2`: point `P1` is strictly to the left of point `P2`.

Args:
    - P1: the point that is to the left
    - P2: the reference point
*%

%*! right_pp(P1,P2)

Theory atom `&right_pp/2`: point `P1` is strictly to the right of point `P2`.

Args:
    - P1: the point that is to the right
    - P2: the reference point
*%

%*! alignedY_pp(P1,P2)

Theory atom `&alignedY_pp/2`: points `P1` and `P2` have the same `y` coordinate.

Unlike the other relations here, this one also holds for a point and itself.

Args:
    - P1: the first point
    - P2: the second point
*%

%*! samePlace_pp(P1,P2)

Theory atom `&samePlace_pp/2`: distinct points `P1` and `P2` occupy the same position.

Args:
    - P1: the first point
    - P2: the second point
*%

%## `&left_pp`
%
% True cases for `P1`:
%
%![Examples of left_pp](../../assets/relations/left_pp.svg)
&sus{x(P1,K)} < x(P2,K) :- true(&left_pp(P1,P2),K).
                 
true(&left_pp(P1,P2),K) :- formula(spatial, &left_pp(P1,P2)), P1!=P2, &sus{x(P1,K)} < x(P2,K), time(K).
                         

invalid_relation_arg(&left_pp(P1,P2)) :- formula(spatial, &left_pp(P1,P2)),
                                         #count {valid_arg_1 : true(point(P1),K);
                                                 valid_arg_2 : true(point(P2),K)} != 2, 
                                                 time(K).

%## `&right_pp`
%
% True cases for `P1`:
%
%```text
% y                     y                     y
% 3 | .   .   P1  .    3 | .   .   .   .    3 | .   .   .   .
% 2 | .   .   .   .    2 | .   .   .   .    2 | .   .   .   .
% 1 | .   P2  .   .    1 | .   P2  .   P1   1 | .   .   .   .
% 0 | .   .   .   .    0 | .   .   .   .    0 | .   .   .   .
%   +----------------    +----------------    +----------------
%     0   1   2   3  x     0   1   2   3  x     0   1   2   3  x
%```
&sus{x(P1,K)} > x(P2,K) :- true(&right_pp(P1,P2),K).

true(&right_pp(P1,P2),K) :- formula(spatial, &right_pp(P1,P2)), P1!=P2, &sus{x(P1,K)} > x(P2,K), time(K).

invalid_relation_arg(&right_pp(P1,P2)) :- formula(spatial, &right_pp(P1,P2)),
                                         #count {valid_arg_1 : true(point(P1),K);
                                                 valid_arg_2 : true(point(P2),K)} != 2,
                                                 time(K).

%## `&alignedY_pp`
%
% True cases for `P1`:
%
%```text
% y                     y                     y
% 3 | .   .   .   .    3 | .   .   .   .    3 | .   .   .   .
% 2 | .   .   .   .    2 | .   .   .   .    2 | .   .   .   .
% 1 | .   P1/2.   .    1 | .   P1  .   P2   1 | .   .   .   .
% 0 | .   .   .   .    0 | .   .   .   .    0 | .   .   .   .
%   +----------------    +----------------    +----------------
%     0   1   2   3  x     0   1   2   3  x     0   1   2   3  x
%```
&sus{y(P1,K)} = y(P2,K) :- true(&alignedY_pp(P1,P2),K).

true(&alignedY_pp(P1,P2),K) :- formula(spatial, &alignedY_pp(P1,P2)), &sus{y(P1,K)} = y(P2,K), time(K).

invalid_relation_arg(&alignedY_pp(P1,P2)) :- formula(spatial, &alignedY_pp(P1,P2)),
                                         #count {valid_arg_1 : true(point(P1),K);
                                                 valid_arg_2 : true(point(P2),K)} != 2,
                                                 time(K).

%## `&samePlace_pp`
%
% True cases for `P1`:
%
%```text
% y                     y                     y
% 3 | .   .   .   .    3 | .   .   .   .    3 | .   .   .   .
% 2 | .   .   .   .    2 | .   .   .   .    2 | .   .   .   .
% 1 | .   P1/2.   .    1 | .   .   .   .    1 | .   .   .   .
% 0 | .   .   .   .    0 | .   .   .   .    0 | .   .   .   .
%   +----------------    +----------------    +----------------
%     0   1   2   3  x     0   1   2   3  x     0   1   2   3  x
%```
&sus{x(P1,K)}=x(P2,K) :- true(&samePlace_pp(P1,P2),K), P1!=P2.
&sus{y(P1,K)}=y(P2,K) :- true(&samePlace_pp(P1,P2),K), P1!=P2.

true(&samePlace_pp(P1,P2),K) :- formula(spatial, &samePlace_pp(P1,P2)), P1!=P2,
                              &sus{x(P1,K)}=x(P2,K), &sus{y(P1,K)}=y(P2,K), time(K).

invalid_relation_arg(&samePlace_pp(P1,P2)) :- formula(spatial, &samePlace_pp(P1,P2)),
                                         #count {valid_arg_1 : true(point(P1),K);
                                                 valid_arg_2 : true(point(P2),K)} != 2,
                                                 time(K).
