:- use_module(board).
:- use_module(debug).
:- use_module(state).
:- use_module(step).

:- begin_tests(step).

% play_game(Iterations, 1, Scores, [0], 0, HighScore), !.
test(when_1_player_iteration_1) :-
  new_board([0], 0, Board),
  step(state{ turn: 1,
              scores: [0],
              board: Board },
       X),

  assertion(X.turn == 2),
  assertion(X.scores == [0]),
  assertion(X.board.export() == [0, 1]),
  assertion(X.current() == 1).

test(when_1_player_iteration_2) :-
  new_board([0, 1], 1, Board),
  step(state{ turn: 2,
              scores: [0],
              board: Board },
       X),
  assertion(X.turn == 3),
  assertion(X.scores == [0]),
  assertion(X.board.export() == [0, 2, 1]),
  assertion(X.current() == 2).

test(when_1_player_iteration_23) :-
  new_board([0, 16, 8, 17, 4, 18, 9, 19, 2, 20, 10, 21, 5, 22, 11, 1, 12, 6, 13, 3, 14, 7, 15],
            22,
            Board),
  step(state{ turn: 23,
              scores: [0],
              board: Board },
       X),
  assertion(X.turn == 24),
  assertion(X.scores == [32]),
  assertion(X.board.export() == [0, 16, 8, 17, 4, 18, 19, 2, 20, 10, 21, 5, 22, 11, 1, 12, 6, 13, 3, 14, 7, 15]),
  assertion(X.current() == 19 ).

test(when_2_player_iteration_23) :-
  new_board([0, 16, 8, 17, 4, 18, 9, 19, 2, 20, 10, 21, 5, 22, 11, 1, 12, 6, 13, 3, 14, 7, 15],
            22,
            Board),
  step(state{ turn: 23,
              scores: [0, 0],
              board: Board },
       X),
  assertion(X.turn == 24),
  assertion(X.scores == [0, 32]),
  assertion(X.board.export() == [0, 16, 8, 17, 4, 18, 19, 2, 20, 10, 21, 5, 22, 11, 1, 12, 6, 13, 3, 14, 7, 15]),
  assertion(X.current() == 19).

:- end_tests(step).