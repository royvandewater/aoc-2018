:- module(index_of, [index_of/3]).

index_of(Board, Element, Index) :-
  % using nth0 to find the Index of Element generates a choicepoint because in theory,
  % there could be multiple instances of the Element in the List. However, we know our Board
  % only contains unique Elements
  nth0(Index, Board, Element), !.