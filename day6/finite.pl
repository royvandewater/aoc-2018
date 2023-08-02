:- module(finite, [finite/2]).
:- use_module(dimensions).
:- use_module(exists_closer_coordinate_to_pixel).

finite(AllCs, C) :-
  dimensions(AllCs, Dimensions),
  select(C, AllCs, Cs),
  exists_closer_coordinate_left(Dimensions, Cs, C),
  exists_closer_coordinate_right(Dimensions, Cs, C),
  exists_closer_coordinate_up(Dimensions, Cs, C),
  exists_closer_coordinate_down(Dimensions, Cs, C),
  !.

exists_closer_coordinate_left(Dimensions, Cs, Target) :-
  [MinX, _, _, _] = Dimensions,
  coordinate(MaxX, Y) = Target,
  between(MinX, MaxX, X),
  Pixel = coordinate(X, Y),
  exists_closer_coordinate_to_pixel(Cs, Target, Pixel), !.

exists_closer_coordinate_right(Dimensions, Cs, Target) :-
  [_, _, MaxX, _] = Dimensions,
  coordinate(MinX, Y) = Target,
  between(MinX, MaxX, X),
  Pixel = coordinate(X, Y),
  exists_closer_coordinate_to_pixel(Cs, Target, Pixel), !.

exists_closer_coordinate_up(Dimensions, Cs, Target) :-
  [_, MinY, _, _] = Dimensions,
  coordinate(X, MaxY) = Target,
  between(MinY, MaxY, Y),
  Pixel = coordinate(X, Y),
  exists_closer_coordinate_to_pixel(Cs, Target, Pixel), !.

exists_closer_coordinate_down(Dimensions, Cs, Target) :-
  [_, _, _, MaxY] = Dimensions,
  coordinate(X, MinY) = Target,
  between(MinY, MaxY, Y),
  Pixel = coordinate(X, Y),
  exists_closer_coordinate_to_pixel(Cs, Target, Pixel), !.
