:- use_module(step_order).

:- begin_tests(step_order).

test(when_empty, X == []) :- step_order([], X).
test(when_one_step, X == ['A']) :- step_order([ step('A', []) ], X).
test(when_two_linear_steps, X == ['A', 'B']) :- step_order([ step('A', []),
                                                             step('B', ['A']) ], X).
test(when_two_parallel_steps, X == ['A', 'B']) :- step_order([ step('A', []),
                                                               step('B', []) ], X).
test(when_two_parallel_steps_out_of_order, X == ['A', 'B']) :-
  step_order([ step('B', []),
               step('A', []) ], X).
test(when_linear_steps_non_intuitive_order, X == ['B', 'A']) :-
  step_order([ step('B', []),
               step('A', ['B']) ], X).

:- end_tests(step_order).
