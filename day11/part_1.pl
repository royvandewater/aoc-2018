:- module(part_1, [part_1/2]).

:- use_module(grid_max_square).
:- use_module(serial_grid).

part_1(Serial, Answer) :-
  serial_grid(Serial, PowerGrid),
  grid_max_square(PowerGrid, 3, square(_, Answer, _)).
