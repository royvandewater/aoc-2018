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

test(when_more_than_100_columns) :-
  positions_string([vector(0, 0), vector(101, 0)], X),
  assertion(X == "More than 100 columns (101), skipping").

test(when_more_than_100_rows) :-
  positions_string([vector(0, 0),
                    vector(0, 101)], X),
  assertion(X == "More than 100 rows (101), skipping").

:- end_tests(positions_string).