#!/usr/bin/env swipl

:- use_module(input_schedules).
:- initialization(main, main).

% A = 1, B = 2, X = 3, format('A: ~d, B: ~d, X: ~d', [A, B, X]), nl.

% main() :- main("input.txt").
main(Argv) :-
  [Filename | _] = Argv,
  open(Filename, read, In),
  input_schedules(In, Schedules),
  log("Schedules", Schedules),
  part_1(Schedules, Part1Answer),
  log("Part 1 Answer", Part1Answer),
  close(In).

log(Label, Value) :- write(Label), write(": "), writeln(Value).
