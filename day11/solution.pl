#!/usr/bin/env swipl

:- use_module(debug).
:- use_module(part_1).
:- use_module(part_2).

:- initialization(main, main).

main() :- main(["input.txt"]).
main(_) :-
  Input = 7511,

  part_1(Input, Part1Answer),
  debug("Part 1 Answer: ~w", [Part1Answer]),

  part_2(Input, Part2Answer),
  debug("Part 2 Answer: ~w", [Part2Answer]).

