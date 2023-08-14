:- use_module(instructions_steps).

:- begin_tests(instructions_steps).

test(when_empty, true(X == [])) :- instructions_steps([], X).
test(when_one_instruction, true(X == [step('A', []), step('B', ['A'])])) :-
  instructions_steps([['A', 'B']], X).
test(when_two_instructions_diverge, true(X == [step('A', []), step('B', ['A']), step('C', ['A'])])) :-
  instructions_steps([['A', 'B'], ['A', 'C']], X).
test(when_two_instructions_converge, true(X == [step('A', []), step('B', []), step('C', ['A', 'B'])])) :-
  instructions_steps([['A', 'C'], ['B', 'C']], X).

:- end_tests(instructions_steps).