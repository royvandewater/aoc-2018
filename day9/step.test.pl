:- use_module(step).
:- use_module(debug).

:- begin_tests(step).

% play_game(Iterations, 1, Scores, [0], 0, HighScore), !.
test(when_1_player_iteration_1) :-
  step(state{ turn: 1,
              scores: [0],
              board: [0],
              currentMarble: 0 },
       X),

  assertion(X.turn == 2),
  assertion(X.scores == [0]),
  assertion(X.board == [0, 1]),
  assertion(X.currentMarble == 1).

test(when_1_player_iteration_2) :-
  step(state{ turn: 2,
              scores: [0],
              board: [0, 1],
              currentMarble: 1 },
       X),
  assertion(X.turn == 3),
  assertion(X.scores == [0]),
  assertion(X.board == [0, 2, 1]),
  assertion(X.currentMarble == 2 ).

test(when_1_player_iteration_23) :-
  step(state{ turn: 23,
              scores: [0],
              board: [0, 16, 8, 17, 4, 18, 9, 19, 2, 20, 10, 21, 5, 22, 11, 1, 12, 6, 13, 3, 14, 7, 15],
              currentMarble: 22 },
       X),
  assertion(X.turn == 24),
  assertion(X.scores == [32]),
  assertion(X.board == [0, 16, 8, 17, 4, 18, 19, 2, 20, 10, 21, 5, 22, 11, 1, 12, 6, 13, 3, 14, 7, 15]),
  assertion(X.currentMarble == 19 ).

test(when_2_player_iteration_23) :-
  step(state{ turn: 23,
              scores: [0, 0],
              board: [0, 16, 8, 17, 4, 18, 9, 19, 2, 20, 10, 21, 5, 22, 11, 1, 12, 6, 13, 3, 14, 7, 15],
              currentMarble: 22 },
       X),
  assertion(X.turn == 24),
  assertion(X.scores == [0, 32]),
  assertion(X.board == [0, 16, 8, 17, 4, 18, 19, 2, 20, 10, 21, 5, 22, 11, 1, 12, 6, 13, 3, 14, 7, 15]),
  assertion(X.currentMarble == 19).

:- end_tests(step).