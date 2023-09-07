:- use_module(positions_string).

:- begin_tests(positions_string).

test(when_empty) :-
  positions_string([], X),
  assertion(X == "").

test(when_one_position_at_origin) :-
  positions_string([vector(0, 0)], X),
  assertion(X == "#").

test(when_one_position) :-
  positions_string([vector(1, 2)], X),
  assertion(X == "#").

test(when_two_positions_on_y_0) :-
  positions_string([vector(-1, 0), vector(1, 0)], X),
  assertion(X == "#.#").

:- end_tests(positions_string).