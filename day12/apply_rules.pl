:- module(apply_rules, [apply_rules/3]).

:- use_module(debug).

apply_rules(Plants, Rules, NextPlants) :-
  min_potential_plant(Plants, Min),
  max_potential_plant(Plants, Max),
  findall(Plant, (between(Min, Max, Plant), survives(Plants, Rules, Plant)), NextPlants).

min_potential_plant([], 0) :- !.
min_potential_plant(Plants, MinPotentialPlant) :-
  min_list(Plants, MinPlant),
  MinPotentialPlant is MinPlant - 2.

max_potential_plant([], 0) :- !.
max_potential_plant(Plants, MaxPotentialPlant) :-
  max_list(Plants, MaxPlant),
  MaxPotentialPlant is MaxPlant + 2.

survives(Plants, Rules, Plant) :-
  plant_state(Plants, Plant, State),
  member(State, Rules).

plant_state(Plants, Plant, State) :-
  N0 is Plant - 2,
  N1 is Plant - 1,
  N2 is Plant,
  N3 is Plant + 1,
  N4 is Plant + 2,
  maplist(n_char(Plants), [N0, N1, N2, N3, N4], Chars),
  atomic_list_concat(Chars, State).

n_char(Plants, N, C) :-
  member(N, Plants)
  -> C = '#'
  ;  C = '.'.


