#!/usr/bin/env swipl

:- use_module(debug).
:- use_module(string_tree).
:- use_module(part_1).
:- use_module(part_2).

:- initialization(main, main).

main() :- main(["input.txt"]).
main(Argv) :-
  [Filename | _] = Argv,
  read_file_to_string(Filename, Input, []),
  string_tree(Input, Tree),

  part_1(Tree, Part1Answer),
  debug("Part 1 Answer: ~w", [Part1Answer]),

  part_2(Tree, Part2Answer),
  debug("Part 2 Answer: ~w", [Part2Answer]).

