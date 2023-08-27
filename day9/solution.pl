#!/usr/bin/env swipl

:- use_module(debug).
:- use_module(part_1).
:- use_module(part_2).

:- initialization(main, main).

main() :-
  PlayerCount = 470,
  Iterations = 72170,

  part_1(PlayerCount, Iterations, Part1Answer),
  debug("Part 1 Answer: ~w", [Part1Answer]),

  part_2(_, Part2Answer),
  debug("Part 2 Answer: ~w", [Part2Answer]).

