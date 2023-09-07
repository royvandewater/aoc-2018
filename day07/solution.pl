#!/usr/bin/env swipl

:- use_module(stream_steps).
:- use_module(part_1).
:- use_module(part_2).

:- initialization(main, main).

main() :- main(["input.txt"]).
main(Argv) :-
  [Filename | _] = Argv,
  open(Filename, read, In),
  stream_steps(In, Steps),

  part_1(Steps, Part1Answer),
  log("Part 1 Answer", Part1Answer),

  part_2(5, 60, Steps, Part2Answer),
  log("Part 2 Answer", Part2Answer).


log(Label, Value) :- write(Label), write(": "), writeln(Value).
