:- module(part_2, [part_2/3]).

:- use_module(dimensions).
:- use_module(is_sum_of_distances_to_coordinates_less_than).

part_2(Distance, Coordinates, X) :-
  dimensions(Coordinates, [MinX, MinY, MaxX, MaxY]),
  aggregate_all(
    count,
    ( between(MinX, MaxX, X),
      between(MinY, MaxY, Y),
      is_sum_of_distances_to_coordinates_less_than(Distance, coordinate(X, Y), Coordinates) ),
    X).
