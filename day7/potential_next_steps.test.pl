:- use_module(potential_next_steps).

:- begin_tests(potential_next_steps).

test(when_empty) :-
  potential_next_steps([], [], []).

test(when_path_and_one_step, true(X == [['A', 'B']])) :-
  potential_next_steps([['A', 'B']], ['A'], X).

test(when_path_and_two_steps, true(X == [['A', 'B']])) :-
  potential_next_steps([['A', 'B'], ['B', 'C']], ['A'], X).

test(when_path_and_two_steps_both_match, true(X == [['A', 'B'], ['A', 'C']])) :-
  potential_next_steps([['A', 'B'], ['A', 'C']], ['A'], X).

test(when_a_step_has_requirements_not_fully_met, true(X == [])) :-
  % C is dependent on both A & B, but only has A
  potential_next_steps([['A', 'C'], ['B', 'C']], ['A'], X).

test(when_requirements_are_in_the_path, true(X=[['B','C']])) :-
  potential_next_steps([['B', 'C']], ['A'], X).
% test(when_requirements_are_in_the_path, true(X=[['B','E'],['D','E'],['F','E']])) :-
%   potential_next_steps([['B','E'],['D','E'],['F','E']], ['F','D','B','A','C'], X).

test(when_one_requirement_is_not_met, true(X == [[['C','F']]])) :-
  steps_with_requirements_met([['C','F'], ['B','E'], ['D','E'], ['F','E']], [], X)


:- end_tests(potential_next_steps).