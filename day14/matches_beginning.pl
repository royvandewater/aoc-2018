:- module(matches_beginning, [matches_beginning/2]).

matches_beginning([], _) :- true.

matches_beginning([C1 | R1], [C2 | R2]) :-
  C1 == C2,
  matches_beginning(R1, R2).
