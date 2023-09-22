:- use_module(apply_rules_n_times).
:- begin_tests(apply_rules_n_times).

test(no_plants_no_rules_1_round) :-
  apply_rules_n_times([], [], 1, X),
  assertion(X == []).

test(one_plant_no_rules_1_round) :-
  apply_rules_n_times([1], [], 1, X),
  % our plant dies because the default rule is death
  assertion(X == []).

:- end_tests(apply_rules_n_times).