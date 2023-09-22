:- module(part_2, [part_2/2]).

:- use_module(debug).
:- use_module(grid_sum_table).
:- use_module(sum_table_max_square).
:- use_module(serial_grid).

part_2(Serial, Answer) :-
  serial_grid(Serial, PowerGrid),
  grid_sum_table(PowerGrid, SumTable),
  findall(Square, (between(1, 300, N), sum_table_max_square(SumTable, N, Square)), Squares),
  print_squares(Squares),
  max_square(Squares, MaxSquare),
  square(_, c(X, Y), Size) = MaxSquare,
  Answer = answer(X, Y, Size).

max_square(Squares, MaxSquare) :-
  [ Square | Rest ] = Squares,
  max_square(Rest, MaxSquare, Square).

max_square([], MaxSquare, Acc) :- !, MaxSquare = Acc.

max_square([ Square | Rest ], MaxSquare, Acc) :-
  square(Psquare, _, _) = Square,
  square(Pacc, _, _) = Acc,
  (Psquare > Pacc
   -> max_square(Rest, MaxSquare, Square)
   ;  max_square(Rest, MaxSquare, Acc)).

print_squares([]).
print_squares([ S | Rest ]) :- debug(S), print_squares(Rest).