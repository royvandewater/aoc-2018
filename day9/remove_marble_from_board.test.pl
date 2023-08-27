:- use_module(remove_marble_from_board).
:- begin_tests(remove_marble_from_board).

test(when_2_marbles_on_board) :-
  remove_marble_from_board([0, 1], 1, Board1, RemovedMarble, CurrentMarble1),
  assertion(Board1 == [1]),
  assertion(RemovedMarble == 0),
  assertion(CurrentMarble1 == 1).

test(when_22_marbles_on_board) :-
  remove_marble_from_board([0, 16, 8, 17, 4, 18, 9, 19, 2, 20, 10, 21, 5, 22, 11, 1, 12, 6, 13, 3, 14, 7, 15],
                           22, Board1, RemovedMarble, CurrentMarble1),
  assertion(Board1 == [0, 16, 8, 17, 4, 18, 19, 2, 20, 10, 21, 5, 22, 11, 1, 12, 6, 13, 3, 14, 7, 15]),
  assertion(RemovedMarble == 9),
  assertion(CurrentMarble1 == 19).

:- end_tests(remove_marble_from_board).