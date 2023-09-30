#!/usr/bin/env swipl

:- use_module(debug).
:- use_module(stream_tree).
:- use_module(part_1).
:- use_module(part_2).

:- initialization(main, main).

parse_args([ Filename | _ ], Filename).
parse_args([], "input.txt").

main() :- main(["input.txt"]).
main(Argv) :-
  parse_args(Argv, Filename),
  open(Filename, read, In),
  stream_tree(In, Tree),

  part_1(Tree, Part1Answer),
  debug("Part 1 Answer: ~w", [Part1Answer]),

  part_2(Tree, Part2Answer),
  debug("Part 2 Answer: ~w", [Part2Answer]).

