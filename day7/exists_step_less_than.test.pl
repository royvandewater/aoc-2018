:- use_module(exists_step_less_than).

:- begin_tests(exists_step_less_than).

test(when_empty, fail) :-
  exists_step_less_than(['A', 'B'], []).

test(when_one_step_less) :-
  exists_step_less_than(['A', 'C'], [['A', 'B']]).

test(when_one_step_greater, fail) :-
  exists_step_less_than(['A', 'B'], [['A', 'C']]).


:- end_tests(exists_step_less_than).