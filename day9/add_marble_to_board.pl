:- module(add_marble_to_board, [add_marble_to_board/4]).

:- use_module(index_of).
:- use_module(split_at).

add_marble_to_board(Turn, CurrentMarble, Board, BoardWithMarble) :-
  BoardWithMarble = Board.insert_at(2, CurrentMarble)

  index_of(Board, CurrentMarble, CurrentMarbleIndex),

  length(Board, BoardLength),
  Index is (CurrentMarbleIndex + 2) mod BoardLength,

  insert_marble_at(Index, Turn, Board, BoardWithMarble).

insert_marble_at(Index, Marble, Board, Result) :-
  split_at(Index, Board, FirstN, Rest),
  append([FirstN, [Marble], Rest], Result).

shift_board_so_min_marble_is_start([X|Xs], [X|Xs]) :- min_list([X|Xs], X), !.
shift_board_so_min_marble_is_start([X|Xs], Shifted) :- append([Xs, [X]], Shifted).