#!/usr/bin/env swipl

:- use_module(stream_coordinates).
:- use_module(part_1).
% :- use_module(part_2).

:- initialization(main, main).

main() :- main(["input.txt"]).
main(Argv) :-
  [Filename | _] = Argv,
  open(Filename, read, In),
  stream_coordinates(In, Coordinates),

  part_1(Coordinates, Part1Answer),
  log("Part 1 Answer", Part1Answer).

  % part_2(In, Part2Answer),
  % log("Part 2 Answer", Part2Answer).


log(Label, Value) :- write(Label), write(": "), writeln(Value).
