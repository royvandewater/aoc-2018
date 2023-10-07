:- module(part_1, [part_1/2]).

:- use_module(join).
:- use_module(sequence_up_to).
:- use_module(tail).

part_1(N, Answer) :-
  Min = N,
  Max is N + 10,
  sequence_up_to(Max, Sequence),
  tail(Min, Sequence, Values),
  join(Values, Answer).
