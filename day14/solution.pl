#!/usr/bin/env swipl

% answer part 2: 20,221,334
?- set_prolog_flag(stack_limit, 8_589_934_592).

:- use_module(debug).
:- use_module(part_1).
:- use_module(part_2).

:- initialization(main, main).

main(_) :-
  Input = 236021,

  part_1(Input, Part1Answer),
  debug("Part 1 Answer: ~w", [Part1Answer]),

  atom_string(Input, InputStr),
  part_2(InputStr, Part2Answer),
  debug("Part 2 Answer: ~w", [Part2Answer]).

