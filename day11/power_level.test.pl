:- use_module(power_level).

:- begin_tests(power_level).

test(coordinate_3_5_with_serial_8) :-
  power_level(8, c(3, 5), X),
  assertion(X == 4).

test(coordinate_122_79_with_serial_57) :-
  power_level(57, c(122,79), X),
  assertion(X == -5).

test(coordinate_217_196_with_serial_39) :-
  power_level(39, c(217,196), X),
  assertion(X == 0).

test(coordinate_101_153_with_serial_71) :-
  power_level(71, c(101,153), X),
  assertion(X == 4).


:- end_tests(power_level).