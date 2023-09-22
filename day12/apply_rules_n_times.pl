:- module(apply_rules_n_times, [apply_rules_n_times/4]).

:- use_module(debug).
:- use_module(apply_rules).

apply_rules_n_times(_, _, N, _) :-
  0 is N mod 1000,
  debug("~w", [N]),
  false.

apply_rules_n_times(Plants, _, 0, Plants) :- !.
apply_rules_n_times(Plants, Rules, N, NthPlants) :-
  apply_rules(Plants, Rules, Plants1),
  N1 is N - 1,
  apply_rules_n_times(Plants1, Rules, N1, NthPlants).
