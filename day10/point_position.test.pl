:- use_module(point_position).
:- begin_tests(point_position).

test(when_still_point_at_origin_n_0) :-
  point_position(0, point{position: vector(0, 0), velocity: vector(0, 0)}, X),
  assertion(X == vector(0, 0)).

test(when_still_point_at_origin_n_1) :-
  point_position(1, point{position: vector(0, 0), velocity: vector(0, 0)}, X),
  assertion(X == vector(0, 0)).

test(when_point_at_origin_moves_n_0) :-
  point_position(0, point{position: vector(0, 0), velocity: vector(1, 2)}, X),
  assertion(X == vector(0, 0)).

test(when_point_at_origin_moves_n_1) :-
  point_position(1, point{position: vector(0, 0), velocity: vector(1, 2)}, X),
  assertion(X == vector(1, 2)).

test(when_point_at_location_moves_n_0) :-
  point_position(0, point{position: vector(1, 2), velocity: vector(2, 1)}, X),
  assertion(X == vector(1, 2)).

test(when_point_at_location_moves_n_1) :-
  point_position(1, point{position: vector(1, 2), velocity: vector(2, 1)}, X),
  assertion(X == vector(3, 3)).

:- end_tests(point_position).