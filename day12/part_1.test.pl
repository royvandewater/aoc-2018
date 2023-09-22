:- use_module(part_1).
:- begin_tests(part_1).

test(example) :-
  read_file_to_string("example_1.pl", Input, []),
  input_state(Input, State),
  part_1(State, X),
  assertion(X == 325).

:- end_tests(part_1).