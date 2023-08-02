:- module(exists_closer_coordinate_to_pixel, [exists_closer_coordinate_to_pixel/3]).

% :- table exists_closer_coordinate_to_pixel/3.

exists_closer_coordinate_to_pixel(Cs, Target, Pixel) :-
  % format('exists_closer_coordinate_to_pixel Target: ~w, Pixel: ~w\n', [Target, Pixel]),
  member(C, Cs),
  C \== Target,
  distance(Pixel, Target, Dtarget),
  distance(Pixel, C, Dc),
  Dc =< Dtarget,
  !.

% memoize distance
% :- table distance/3.

distance(C1, C2, D) :-
  % format('distance C1: ~w, C2: ~w\n', [C1, C2]),
  coordinate(X1, Y1) = C1,
  coordinate(X2, Y2) = C2,
  Dx is abs(X1 - X2),
  Dy is abs(Y1 - Y2),
  D is Dx + Dy.