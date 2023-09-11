:- module(grid_max_square, [grid_max_square/2]).

:- use_module(debug).
:- use_module(grid_coord_square).

grid_max_square(Grid, MaxSquare) :-
  grid_coord_square(Grid, c(1, 1), Square),
  grid_max_square(Grid, MaxSquare, c(1, 1), Square).

grid_max_square(_Grid, MaxSquare, c(X, Y), Acc) :-
  X + 2 > 300,
  Y + 2 > 299,
  !,
  MaxSquare = Acc.

grid_max_square(Grid, MaxSquare, c(X, Y), Acc) :-
  X + 2 > 300,
  !,
  Y1 is Y + 1,
  grid_max_square(Grid, MaxSquare, c(0, Y1), Acc).

grid_max_square(Grid, MaxSquare, Coord, Acc) :-
  grid_coord_square(Grid, Coord, Square),
  square(Pcur, _) = Square,
  square(Pacc, _) = Acc,
  c(X, Y) = Coord,
  X1 is X + 1,
  % debug("Coord: ~w, Pcur: ~w, Pacc: ~w", [Coord, Pcur, Pacc]),
  (Pcur > Pacc
   -> grid_max_square(Grid, MaxSquare, c(X1, Y), square(Pcur, Coord))
   ;  grid_max_square(Grid, MaxSquare, c(X1, Y), Acc)).


