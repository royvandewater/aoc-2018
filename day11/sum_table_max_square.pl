:- module(sum_table_max_square, [sum_table_max_square/3]).

:- use_module(sum_table_coord_square).

sum_table_max_square(SumTable, Size, MaxSquare) :-
  sum_table_coord_square(SumTable, Size, c(1, 1), Square),
  sum_table_max_square(SumTable, Size, MaxSquare, c(1, 1), Square).

sum_table_max_square(_SumTable, Size, MaxSquare, c(1, Y), Acc) :-
  Y + Size > 300,
  !,
  MaxSquare = Acc.

sum_table_max_square(SumTable, Size, MaxSquare, c(X, Y), Acc) :-
  X + Size > 300,
  !,
  Y1 is Y + 1,
  sum_table_max_square(SumTable, Size, MaxSquare, c(1, Y1), Acc).

sum_table_max_square(SumTable, Size, MaxSquare, Coord, Acc) :-
  sum_table_coord_square(SumTable, Size, Coord, Square),
  square(Pcur, _, _) = Square,
  square(Pacc, _, _) = Acc,
  c(X, Y) = Coord,
  X1 is X + 1,
  % debug("Coord: ~w, Pcur: ~w, Pacc: ~w", [Coord, Pcur, Pacc]),
  (Pcur > Pacc
   -> sum_table_max_square(SumTable, Size, MaxSquare, c(X1, Y), square(Pcur, Coord, Size))
   ;  sum_table_max_square(SumTable, Size, MaxSquare, c(X1, Y), Acc)).


