:- use_module(bounds_coords).

:- begin_tests(bounds_coords).

test(when_single_point) :-
  bounds_coords([0, 0, 0, 0], X),
  assertion(X == [[vector(0, 0)]]).

test(when_2_columns) :-
  bounds_coords([0, 1, 0, 0], X),
  assertion(X == [[vector(0, 0), vector(1, 0)]]).

test(when_2_rows) :-
  bounds_coords([0, 0, 0, 1], X),
  assertion(X == [[vector(0, 0)],
                  [vector(0, 1)]]).

test(when_2_rows_2_columns) :-
  bounds_coords([0, 1, 0, 1], X),
  assertion(X == [[vector(0, 0), vector(1, 0)],
                  [vector(0, 1), vector(1, 1)]]).

:- end_tests(bounds_coords).