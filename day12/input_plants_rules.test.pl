:- use_module(input_plants_rules).
:- begin_tests(input_plants_rules).

test(empty_initial_state) :-
  Input = "
    initial state: .

    #.##. => .
  ",
  input_plants_rules(Input, Plants, _),
  assertion(Plants == []).

test(one_plant_initial_state) :-
  Input = "
    initial state: .#.

    #.##. => .
  ",
  input_plants_rules(Input, Plants, _),
  assertion(Plants == [1]).

test(one_rule) :-
  Input = "
    initial state: .#.

    #.##. => #
  ",
  input_plants_rules(Input, _, Rules),
  assertion(Rules == ['#.##.']).

test(one_ignored_rule) :-
  Input = "
    initial state: .#.

    #.##. => .
  ",
  input_plants_rules(Input, _, Rules),
  assertion(Rules == []).

:- end_tests(input_plants_rules).