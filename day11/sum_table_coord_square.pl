:- module(sum_table_coord_square, [sum_table_coord_square/4]).

sum_table_coord_square(SumTable, Size, Coord, Square) :-
  c(X, Y) = Coord,
  X0 is X - 1,
  Y0 is Y - 1,
  X1 is X + Size - 1,
  Y1 is Y + Size - 1,
  sum_table_coord_value(SumTable, c(X0, Y0), A),
  sum_table_coord_value(SumTable, c(X1, Y0), B),
  sum_table_coord_value(SumTable, c(X0, Y1), C),
  sum_table_coord_value(SumTable, c(X1, Y1), D),
  V is D + A - B - C,
  Square = square(V, Coord, Size).

sum_table_coord_value(_SumTable, c(0, _), 0) :- !.
sum_table_coord_value(_SumTable, c(_, 0), 0) :- !.
sum_table_coord_value(_SumTable, c(X, _), 0) :- X > 300, !.
sum_table_coord_value(_SumTable, c(_, Y), 0) :- Y > 300, !.
sum_table_coord_value(SumTable, Coord, Value) :-
  term_to_atom(Coord, Key),
  Value = SumTable.get(Key).
