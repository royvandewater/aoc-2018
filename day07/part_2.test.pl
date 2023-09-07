:- use_module(part_2).

:- begin_tests(part_2).

test(when_empty, true(X == 0)) :-
  part_2(1, 0, [], X).

test(when_duration_one_and_one_step, true(X == 2)) :-
  part_2(1, 1, [step('A', [])], X).

test(when_duration_two_and_one_step, true(X == 3)) :-
  part_2(1, 2, [step('A', [])], X).

test(when_duration_two_and_two_linear_steps, true(X == 7)) :-
  part_2(1, 2, [step('A', []),
                step('B', ['A'])], X).

test(when_2_workers_with_parallel_steps, true(X == 4)) :-
  part_2(2, 2, [step('A', []),
                step('B', [])], X).

test(when_example_1, true(X == 15), fixme) :-
  part_2(2, 0, [step('C', []),
                step('A', ['C']),
                step('F', ['C']),
                step('B', ['A']),
                step('D', ['A']),
                step('E', ['B', 'D', 'F'])], X).

:- end_tests(part_2).