:- module(part_1, [part_1/2]).

:- use_module(grid_sum_table).
:- use_module(serial_grid).
:- use_module(sum_table_max_square).

part_1(Serial, Answer) :-
  serial_grid(Serial, PowerGrid),
  grid_sum_table(PowerGrid, SumTable),
  sum_table_max_square(SumTable, 3, square(_, Answer, _)).
