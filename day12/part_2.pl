:- module(part_2, [part_2/3]).

:- use_module(apply_rules_n_times).

part_2(Plants, Rules, Answer) :-
  apply_rules_n_times(Plants, Rules, 50000000000, NthPlants),
  sum_list(NthPlants, Answer).
