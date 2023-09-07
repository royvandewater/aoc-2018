:- module(exists_closer_coordinate_to_pixel, [exists_closer_coordinate_to_pixel/3]).

:- use_module(distance).

% :- table exists_closer_coordinate_to_pixel/3.

exists_closer_coordinate_to_pixel(Cs, Target, Pixel) :-
  % format('exists_closer_coordinate_to_pixel Target: ~w, Pixel: ~w\n', [Target, Pixel]),
  member(C, Cs),
  C \== Target,
  distance(Pixel, Target, Dtarget),
  distance(Pixel, C, Dc),
  Dc =< Dtarget,
  !.
