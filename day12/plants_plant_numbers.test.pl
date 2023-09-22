:- use_module(plants_plant_numbers).

:- begin_tests(plants_plant_numbers).

test(empty_dict) :-
  plants_plant_numbers(plants{}, X),
  assertion(X == []).

test(one_plant) :-
  plants_plant_numbers(plants{'1': true}, X),
  assertion(X == [1]).

:- end_tests(plants_plant_numbers).