:- use_module(part_1).
:- use_module(input_state).

:- begin_tests(part_1).

test(crash_in_one_move) :-
  Input = "><",
  input_state(Input, State),
  part_1(State, X),
  assertion(X == c(1,0)).

test(crash_in_one_move_over_one) :-
  Input = "-><",
  input_state(Input, State),
  part_1(State, X),
  assertion(X == c(2,0)).

test(crash_in_one_move_north_south) :-
  Input = "\
v
^",
  input_state(Input, State),
  part_1(State, X),
  assertion(X == c(0,1)).

test(crash_in_two_moves) :-
  Input = ">-<",
  input_state(Input, State),
  part_1(State, X),
  assertion(X == c(1,0)).

test(crash_in_four_moves) :-
  Input = ">---<",
  input_state(Input, State),
  part_1(State, X),
  assertion(X == c(2,0)).

test(crash_in_two_moves_around_a_corner) :-
  Input = "\
/-<
|
|
^
",
  input_state(Input, State),
  part_1(State, X),
  assertion(X == c(0,1)).

test(crash_in_two_moves_around_a_ws_corner) :-
  Input = "\
>-O
  |
  |
  ^
",
  input_state(Input, State),
  part_1(State, X),
  assertion(X == c(2,1)).


:- end_tests(part_1).
