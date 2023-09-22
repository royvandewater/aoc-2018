:- use_module(serial_grid).
:- use_module(grid_sum_table).
:- use_module(sum_table_coord_square).

:- begin_tests(serial_sum_table_integration).

test(when_example_1) :-
  serial_grid(18, PowerGrid),
  grid_sum_table(PowerGrid, SumTable),
  sum_table_coord_square(SumTable, 3, c(33,45), square(Power, _, _)),
  assertion(Power == 29).

test(when_example_2) :-
  serial_grid(42, PowerGrid),
  grid_sum_table(PowerGrid, SumTable),
  sum_table_coord_square(SumTable, 3, c(21,61), square(Power, _, _)),
  assertion(Power == 30).

test(when_actual) :-
  serial_grid(7511, PowerGrid),
  grid_sum_table(PowerGrid, SumTable),
  sum_table_coord_square(SumTable, 13, c(235, 288), square(Power, _, _)),
  assertion(Power == 147).

:- end_tests(serial_sum_table_integration).
