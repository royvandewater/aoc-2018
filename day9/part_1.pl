:- module(part_1, [part_1/3]).

:- use_module(board).
:- use_module(debug).
:- use_module(generate_scores).
:- use_module(step).

part_1(NumPlayers, Iterations, HighScore) :-
  Capacity is Iterations + 1,
  generate_scores(NumPlayers, Scores),
  new_board([0], Capacity, 0, Board),
  play_game(Iterations, HighScore, state{turn: 1,
                                         scores: Scores,
                                         board: Board}).

% play_game(_MaxTurn, _HighScore, State) :-
%   0 is State.turn mod 1000,
%   debug("Turn: ~w", State.turn),
%   false.

play_game(MaxTurn, HighScore, State) :-
  MaxTurn < State.turn,
  !,
  max_list(State.scores, HighScore).

play_game(MaxTurn, HighScore, State) :-
  step(State, NextState),
  play_game(MaxTurn, HighScore, NextState).
