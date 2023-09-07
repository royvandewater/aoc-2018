:- module(split_at, [split_at/4]).

split_at(N, List, FirstN, Rest) :- split_at(N, List, FirstN, Rest, []).
split_at(0, List, FirstN, Rest, Acc) :- !, Rest = List, reverse(Acc, FirstN).
split_at(N, List, FirstN, Rest, Acc) :-
  [ First | List1 ] = List,
  N1 is N - 1,
  split_at(N1, List1, FirstN, Rest, [ First | Acc ]).
