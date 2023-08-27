:- module(remove_marble_from_board, [remove_marble_from_board/5]).

:- use_module(index_of).

remove_marble_from_board(Board, CurrentMarble, Board1, RemovedMarble, CurrentMarble1) :-
  index_of(Board, CurrentMarble, CurrentIndex),
  length(Board, BoardLength),
  IndexToRemove is (BoardLength + CurrentIndex - 7) mod BoardLength,

  nth0(IndexToRemove, Board, RemovedMarble),
  selectchk(RemovedMarble, Board, Board1),

  CurrentMarble1Index is IndexToRemove mod BoardLength,
  nth0(CurrentMarble1Index, Board1, CurrentMarble1).
