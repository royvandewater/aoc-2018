:- use_module(part_1).

:- begin_tests(part_1).

test(example_1) :-
  part_1(18, X),
  assertion(X == c(33, 45)).

test(example_2) :-
  part_1(42, X),
  assertion(X == c(21, 61)).

:- end_tests(part_1).