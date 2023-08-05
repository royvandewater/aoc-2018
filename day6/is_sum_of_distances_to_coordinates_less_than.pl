:- module(is_sum_of_distances_to_coordinates_less_than, [is_sum_of_distances_to_coordinates_less_than/3]).

:- use_module(distance).

is_sum_of_distances_to_coordinates_less_than(_Distance, _Target, []) :- !, fail.

is_sum_of_distances_to_coordinates_less_than(Distance, Target, Coordinates) :-
  maplist(distance(Target), Coordinates, Distances),
  sumlist(Distances, SumOfDistances),
  SumOfDistances < Distance.

