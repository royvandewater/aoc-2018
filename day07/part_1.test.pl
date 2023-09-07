:- use_module(part_1).

:- begin_tests(part_1).

test(when_empty, true(X == "")) :-
  part_1([], X).

test(when_two_steps, true(X == "AB")) :-
  part_1([step('A', []),
          step('B', ['A'])], X).

test(when_three_linear_steps, true(X == "ABC")) :-
  part_1([step('A', []),
          step('B', ['A']),
          step('C', ['B'])], X).

test(when_three_steps_out_of_order, true(X == "ABC")) :-
  part_1([step('C', ['B']),
          step('B', ['A']),
          step('A', [])], X).

test(when_four_linear_steps, true(X == "ABCD")) :-
  part_1([step('A', []),
          step('B', ['A']),
          step('C', ['B']),
          step('D', ['C'])], X).

test(when_example_1, true(X == "CABDFE")) :-
  part_1([step('C', []),
          step('A', ['C']),
          step('F', ['C']),
          step('B', ['A']),
          step('D', ['A']),
          step('E', ['B', 'D', 'F'])], X).

:- end_tests(part_1).
