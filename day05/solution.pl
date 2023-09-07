#!/usr/bin/env swipl

:- use_module(part_1).
:- use_module(part_2).

:- initialization(main, main).

% A = 1, B = 2, X = 3, format('A: ~d, B: ~d, X: ~d', [A, B, X]), nl.

% main() :- main("input.txt").
main(Argv) :-
  [Filename | _] = Argv,
  read_file_to_string(Filename, In, []),

  part_1(In, Part1Answer),
  log("Part 1 Answer", Part1Answer),

  part_2(In, Part2Answer),
  log("Part 2 Answer", Part2Answer).


log(Label, Value) :- write(Label), write(": "), writeln(Value).
