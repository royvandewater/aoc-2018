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

:- end_tests(part_1).
