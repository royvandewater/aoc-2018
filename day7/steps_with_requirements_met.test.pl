:- use_module(steps_with_requirements_met).


:- begin_tests(steps_with_requirements_met).

test(when_steps_empty, true(X == [])) :-
  steps_with_requirements_met([], X).

test(when_one_step, true(X == [['A', 'B']])) :-
  steps_with_requirements_met([['A', 'B']], X).

test(when_two_steps_go_to_same_destination, true(X == [['A', 'C'], ['B', 'C']])) :-
  steps_with_requirements_met([['A', 'C'], ['B', 'C']] , X).

test(when_two_steps_come_from_same_source, true(X == [['A', 'B'], ['A', 'C']])) :-
  steps_with_requirements_met([['A', 'B'], ['A', 'C']] , X).

test(when_two_steps_are_linear, true(X == [['A', 'B']])) :-
  steps_with_requirements_met([['A', 'B'], ['B', 'C']] , X).

test(when_question, true(X == [[['C','F']]])) :-
  steps_with_requirements_met([['C','F'], ['B','E'], ['D','E'], ['F','E']], X)

:- end_tests(steps_with_requirements_met).