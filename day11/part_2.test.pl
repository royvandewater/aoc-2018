:- use_module(part_2).

:- begin_tests(part_2).

test(example_1) :-
  part_2(18, X),
  assertion(X == answer(90, 269, 16)).

test(example_2) :-
  part_2(42, X),
  assertion(X == answer(232, 251, 12)).

:- end_tests(part_2).