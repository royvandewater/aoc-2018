:- use_module(apply_rules).
:- begin_tests(apply_rules).

test(no_plants_no_rules) :-
  apply_rules([], [], X),
  assertion(X == []).

test(one_plant_no_rules) :-
  apply_rules([1], [], X),
  % our plant dies because the default rule is death
  assertion(X == []).

test(one_plant_one_rule_that_applies) :-
  apply_rules([1], ['..#..'], X),
  assertion(X == [1]).

test(one_plant_one_rule_that_doesnt_apply) :-
  apply_rules([1], ['#...#'], X),
  assertion(X == []).

test(one_plant_one_rule_that_applies_indirectly) :-
  apply_rules([1], ['....#'], X),
  assertion(X == [-1]).

:- end_tests(apply_rules).