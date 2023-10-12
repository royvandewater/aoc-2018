:- use_module(mutdict).

:- begin_tests(mutdict).

test(insert_1) :-
  X = mutdict{},
  Y = X.insert(0, 3),
  assertion(3 == Y.get(0)).

test(insert_all) :-
  X = mutdict{},
  Y = X.insert_all(0, [3, 4, 5]),
  assertion(3 == Y.get(0)),
  assertion(4 == Y.get(1)),
  assertion(5 == Y.get(2)).


:- end_tests(mutdict).