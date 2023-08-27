:- module(step, [step/2]).

:- use_module(add_marble_to_board).
:- use_module(debug).
:- use_module(remove_marble_from_board).
:- use_module(split_at).

step(State, NextState) :-
  is_divisible_by_23(State.turn), !,

  add_marble_to_score(State.turn, State.scores, Scores1),
  remove_marble_from_board(State.board, State.currentMarble, Board1, RemovedMarble, CurrentMarble1),
  add_marble_to_score(RemovedMarble, Scores1, Scores2),

  increment_turn(State.turn, Turn1),
  shift_scores(Scores2, Scores3),

  NextState = state{turn: Turn1,
                    scores: Scores3,
                    board: Board1,
                    currentMarble: CurrentMarble1}.

step(State, NextState) :-
  Turn = State.turn,

  add_marble_to_board(Turn, State.currentMarble, State.board, Board1),
  increment_turn(Turn, Turn1),
  shift_scores(State.scores, Scores1),

  NextState = State.put(turn, Turn1)
                   .put(scores, Scores1)
                   .put(board, Board1)
                   .put(currentMarble, Turn).

add_marble_to_score(Marble, [ X | Xs ], [ X1 | Xs ]) :- X1 is X + Marble.

increment_turn(Turn, NextTurn) :- NextTurn is Turn + 1.

shift_scores([ X | Xs ], Scores1) :- append(Xs, [ X ], Scores1).

is_divisible_by_23(N) :- 0 is N mod 23.