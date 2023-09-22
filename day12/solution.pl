#!/usr/bin/env swipl

:- use_module(debug).
:- use_module(input_plants_rules).
:- use_module(part_1).
:- use_module(part_2).

:- initialization(main, main).

parse_args([ Filename | _ ], Filename).
parse_args([], "input.txt").

main(Argv) :-
  parse_args(Argv, Filename),
  read_file_to_string(Filename, Input, []),
  input_plants_rules(Input, Plants, Rules),

  part_1(Plants, Rules, Part1Answer),
  debug("Part 1 Answer: ~w", [Part1Answer]),

  part_2(Plants, Rules, Part2Answer),
  debug("Part 2 Answer: ~w", [Part2Answer]).

