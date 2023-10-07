:- use_module(part_2).

:- begin_tests(part_2).

test(example_1) :-
  part_2("51589", X),
  assertion(X == 9).

test(example_2) :-
  part_2("01245", X),
  assertion(X == 5).

test(example_3) :-
  part_2("92510", X),
  assertion(X == 18).

test(example_3) :-
  part_2("59414", X),
  assertion(X == 2018).

:- end_tests(part_2).