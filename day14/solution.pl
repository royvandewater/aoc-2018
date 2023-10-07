#!/usr/bin/env swipl

:- use_module(debug).
:- use_module(part_1).
:- use_module(part_2).

:- initialization(main, main).

main(_) :-
  Input = 236021,

  % part_1(Input, Part1Answer),
  % debug("Part 1 Answer: ~w", [Part1Answer]),

  atom_string(Input, InputStr),
  part_2(InputStr, Part2Answer),
  debug("Part 2 Answer: ~w", [Part2Answer]).

