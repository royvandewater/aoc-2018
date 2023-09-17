:- module(grid_max_square, [grid_max_square/3]).

:- use_module(debug).
:- use_module(grid_coord_square).

grid_max_square(Grid, Size, MaxSquare) :-
  grid_coord_square(Grid, Size, c(1, 1), Square),
  grid_max_square(Grid, Size, MaxSquare, c(1, 1), Square).

grid_max_square(_Grid, Size, MaxSquare, c(X, Y), Acc) :-
  X + Size >= 300,
  Y + Size >= 299,
  !,
  MaxSquare = Acc.

grid_max_square(Grid, Size, MaxSquare, c(X, Y), Acc) :-
  X + Size >= 300,
  !,
  Y1 is Y + 1,
  grid_max_square(Grid, Size, MaxSquare, c(0, Y1), Acc).

grid_max_square(Grid, Size, MaxSquare, Coord, Acc) :-
  grid_coord_square(Grid, Size, Coord, Square),
  square(Pcur, _, _) = Square,
  square(Pacc, _, _) = Acc,
  c(X, Y) = Coord,
  X1 is X + 1,
  % debug("Coord: ~w, Pcur: ~w, Pacc: ~w", [Coord, Pcur, Pacc]),
  (Pcur > Pacc
   -> grid_max_square(Grid, Size, MaxSquare, c(X1, Y), square(Pcur, Coord, Size))
   ;  grid_max_square(Grid, Size, MaxSquare, c(X1, Y), Acc)).


