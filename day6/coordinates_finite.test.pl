:- use_module(coordinates_finite).

:- begin_tests(coordinates_finite).

test(coordinates_finite_when_empty, true(X == [])) :-
  coordinates_finite([], X).

test(coordinates_finite_when_single_coordinate, true(X == [])) :-
  coordinates_finite([coordinate(1, 1)], X).

test(coordinates_finite_when_one_boxed_in, true(X == [coordinate(1,1)])) :-
  coordinates_finite([
    coordinate(1, 0), % top
    coordinate(1, 2), % bottom
    coordinate(0, 1), % left
    coordinate(2, 1), % right
    coordinate(1, 1)  % boxed in
  ], X).

test(coordinates_finite_when_example_1, true(X == [coordinate(3, 4), coordinate(5, 5)])) :-
  coordinates_finite([
    coordinate(1, 1), % A
    coordinate(1, 6), % B
    coordinate(8, 3), % C
    coordinate(3, 4), % D - finite
    coordinate(5, 5), % E - finite
    coordinate(8, 9)  % F
  ], X).

:- end_tests(coordinates_finite).