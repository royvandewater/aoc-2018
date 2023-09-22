:- use_module(serial_grid).

:- begin_tests(serial_grid).

test(when_example_1) :-
  serial_grid(57, Grid),
  X = Grid.get('c(122,79)'),
  assertion(X == -5).

test(when_example_2) :-
  serial_grid(39, Grid),
  X = Grid.get('c(217,196)'),
  assertion(X == 0).

test(when_example_3) :-
  serial_grid(71, Grid),
  X = Grid.get('c(101,153)'),
  assertion(X == 4).

:- end_tests(serial_grid).