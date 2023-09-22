:- use_module(part_1).
:- use_module(input_plants_rules).
:- use_module(debug).

:- begin_tests(part_1).

test(example) :-
  read_file_to_string("example_1.txt", Input, []),
  input_plants_rules(Input, Plants, Rules),
  part_1(Plants, Rules, X),
  assertion(X == 325).

:- end_tests(part_1).