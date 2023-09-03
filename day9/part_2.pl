:- module(part_2, [part_2/3]).

:- use_module(part_1).

part_2(PlayerCount, Iterations, Part2Answer) :-
  Iterations2 is Iterations * 100,
  part_1(PlayerCount, Iterations2, Part2Answer).
