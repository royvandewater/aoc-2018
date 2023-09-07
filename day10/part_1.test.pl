:- use_module(part_1).

:- begin_tests(part_1).

test(when_empty) :-
  part_1([], 0, X),
  assertion(X == "").

test(when_1_point_n_0) :-
  part_1([ point{position: vector(0, 0), velocity: vector(1, 1)} ], 0, X),
  assertion(X == "#").

test(when_1_point_n_1) :-
  part_1([ point{position: vector(0, 0), velocity: vector(1, 1)} ], 1, X),
  assertion(X == "#").

test(when_2_points_n_0) :-
  part_1([
    point{position: vector(0, 0), velocity: vector(-1, 0)},
    point{position: vector(1, 0), velocity: vector( 1, 0)}
  ], 0, X),
  assertion(X == "##").

test(when_2_points_n_1) :-
  part_1([
    point{position: vector(0, 0), velocity: vector(-1, 0)},
    point{position: vector(1, 0), velocity: vector( 1, 0)}
  ], 1, X),
  assertion(X == "#..#").

:- end_tests(part_1).
