:- module(part_1, [part_1/3]).

:- use_module(apply_rules_n_times).

part_1(Plants, Rules, Answer) :-
  apply_rules_n_times(Plants, Rules, 20, NthPlants),
  sum_list(NthPlants, Answer).
