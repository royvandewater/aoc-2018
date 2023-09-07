:- use_module(part_1).

:- begin_tests(part_1).

test(when_empty) :-
  part_1(node([], []), X),
  assertion(X == 0).

test(when_one_metadata) :-
  part_1(node([], [2]), X),
  assertion(X == 2).

test(when_nested_node) :-
  part_1(node([node([], [1, 2])], []), X),
  assertion(X == 3).

:- end_tests(part_1).