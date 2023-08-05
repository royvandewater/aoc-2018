:- module(distance, [distance/3]).

distance(C1, C2, D) :-
  % format('distance C1: ~w, C2: ~w\n', [C1, C2]),
  coordinate(X1, Y1) = C1,
  coordinate(X2, Y2) = C2,
  Dx is abs(X1 - X2),
  Dy is abs(Y1 - Y2),
  D is Dx + Dy.