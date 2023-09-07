#!/usr/bin/env swipl

:- use_module(debug).
:- use_module(input_points).
:- use_module(part_1).
:- use_module(part_2).

:- initialization(main, main).

main() :- main(["input.txt"]).
main(Argv) :-
  [Filename | _] = Argv,
  read_file_to_string(Filename, Input, []),
  input_points(Input, Points),

  iteration(0, Points).

  % part_1(Points, Part1Answer),
  % debug("Part 1 Answer: ~w", [Part1Answer]),

  % part_2(Points, Part2Answer),
  % debug("Part 2 Answer: ~w", [Part2Answer]).

iteration(N, Points) :-
  part_1(Points, N, OutStr),
  debug("Iteration: ~w\n\n~w\n", [ N, OutStr ]),
  get_code(Code),
  Code \= -1,
  N1 is N + 1,
  iteration(N1, Points).
