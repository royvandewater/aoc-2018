:- module(tail, [tail/3]).

tail(0, Sequence, Values) :- !, Sequence = Values.
tail(Min, Sequence, Values) :-
  Min1 is Min - 1,
  [ _ | Rest ] = Sequence,
  tail(Min1, Rest, Values).