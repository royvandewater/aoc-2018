:- module(part_1, [part_1/2]).

:- use_module(coordinates_finite).
:- use_module(finite_coordinate_sizes).

part_1([], _) :- !, false.
part_1(Coordinates, Answer) :-
  coordinates_finite(Coordinates, FiniteCoordinates),
  finite_coordinate_sizes(Coordinates, FiniteCoordinates, Sizes),
  max_list(Sizes, Answer).