:- module(finite_coordinate_sizes, [finite_coordinate_sizes/3]).
:- use_module(dimensions).
:- use_module(exists_closer_coordinate_to_pixel).

finite_coordinate_sizes(Cs, FiniteCs, Sizes) :- maplist(finite_coordinate_size(Cs), FiniteCs, Sizes).

finite_coordinate_size(AllCs, FiniteC, Size) :-
  dimensions(AllCs, [MinX, MinY, MaxX, MaxY]),
  select(FiniteC, AllCs, Cs),
  aggregate_all(
    count,
    (
      between(MinX, MaxX, X),
      between(MinY, MaxY, Y),
      no_closer_coordinate(Cs, FiniteC, coordinate(X, Y))
    ),
    Size
  ), !.

no_closer_coordinate(Cs, C, Pixel) :- not(exists_closer_coordinate_to_pixel(Cs, C, Pixel)).