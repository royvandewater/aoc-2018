:- use_module(board).

:- begin_tests(board).

test(export_when_one_item) :-
  new_board([1], 1, B),
  assertion(B.export() == [1]).

test(export_when_three_items) :-
  new_board([0, 2, 1], 2, B),
  assertion(B.export() == [0, 2, 1]).

test(insert_at_when_one_item) :-
  new_board([0], 0, B),
  X = B.insert_at(2, 1),
  assertion(X.export() == [0, 1]).

test(insert_at_when_two_items) :-
  new_board([0, 1], 1, B),
  X = B.insert_at(2, 2),
  assertion(X.export() == [0, 2, 1]).

test(delete_at_when_two_items) :-
  new_board([0, 1], 1, B),
  X = B.delete_at(-7, V),
  assertion(X.export() == [1]),
  assertion(V == 0).

test(delete_at_when_22_items) :-
  new_board([0, 16, 8, 17, 4, 18, 9, 19, 2, 20, 10, 21, 5, 22, 11, 1, 12, 6, 13, 3, 14, 7, 15], 22, B),
  X = B.delete_at(-7, V),
  assertion(V == 9),
  assertion(X.export() == [0, 16, 8, 17, 4, 18, 19, 2, 20, 10, 21, 5, 22, 11, 1, 12, 6, 13, 3, 14, 7, 15]).

:- end_tests(board).