:- use_module(part_1).

:- begin_tests(part_1).

test(when_empty, true(X == "")) :-
  part_1([], X).

test(when_one_item, true(X == "AB")) :-
  part_1([['A', 'B']], X).

test(when_two_items, true(X == "ABC")) :-
  part_1([['A', 'B'],
          ['B', 'C']], X).

test(when_two_items_out_of_order, true(X == "ABC")) :-
  part_1([['B', 'C'],
          ['A', 'B']], X).

test(when_linear_three_items, true(X == "ABCD")) :-
  part_1([['A', 'B'],
          ['B', 'C'],
          ['C', 'D']], X).

test(when_example_1, true(X == "CABDFE")) :-
  part_1([['C', 'A'],
          ['C', 'F'],
          ['A', 'B'],
          ['A', 'D'],
          ['B', 'E'],
          ['D', 'E'],
          ['F', 'E']], X).

:- end_tests(part_1).
