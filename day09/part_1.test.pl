:- use_module('part_1').

:- begin_tests('part_1').

test(when_1_player_1_iteration) :-
  part_1(1, 1, X),
  assertion(X == 0).

test(when_1_player_23_iterations) :-
  part_1(1, 23, X),
  assertion(X == 32).

test(when_2_players_23_iterations) :-
  part_1(2, 23, X),
  assertion(X == 32).

test(when_2_players_47_iterations) :-
  part_1(2, 47, X),
  assertion(X == 63).

test(when_example_1) :-
  part_1(10, 1618, X),
  assertion(X == 8317).

test(when_example_2) :-
  part_1(13, 7999, X),
  assertion(X == 146373).

test(when_example_3) :-
  part_1(17, 1104, X),
  assertion(X == 2764).

test(when_example_4) :-
  part_1(21, 6111, X),
  assertion(X == 54718).

test(when_example_5) :-
  part_1(30, 5807, X),
  assertion(X == 37305).

:- end_tests('part_1').