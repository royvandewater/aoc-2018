:- module(part_1, [part_1/2]).

:- use_module(instructions_steps).
:- use_module(step_order).

part_1(Steps, Result) :-
  step_order(Steps, Path),
  atomics_to_string(Path, Result).