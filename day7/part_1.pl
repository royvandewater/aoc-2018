:- module(part_1, [part_1/2]).

:- use_module(exists_step_less_than).
:- use_module(steps_with_requirements_met).

part_1([], _) :- !, false.
% part_1([[A, B]], X) :- !, string_concat(A, B, X).
part_1(Steps, X) :-
  % leash(-all), visible(+exception), trace,
  find_root(Steps, Root),
  walk_tree(Steps, PathBack, [ Root ]),
  reverse(PathBack, Path),
  atomics_to_string(Path, X).

walk_tree([], PathBack, Acc) :- !, PathBack = Acc.

walk_tree(Steps, PathBack, Acc) :-
  find_next_step(Steps, Acc, Next),
  select(Next, Steps, Rest),
  [ _, Destination ] = Next,
  % format("Steps: ~w, Acc: ~w, Next: ~w, Rest: ~w", [Steps, Acc, Next, Rest]), nl,
  walk_tree(Rest, PathBack, [ Destination | Acc ]).

find_next_step(Steps, Path, NextStep) :-
  steps_with_requirements_met(Steps, PotentialNextSteps),
  print_state(Steps, Path, PotentialNextSteps),
  select(NextStep, PotentialNextSteps, OtherPotentials),
  not(exists_step_less_than(NextStep, OtherPotentials)),
  !.

print_state(Steps, PathBack, PotentialNextSteps) :-
  reverse(PathBack, Path),
  format("Steps: ~w, Path: ~w, PotentialNextSteps: ~w", [Steps, Path, PotentialNextSteps]), nl.


destinations_equal([_, A], [_, B]) :- A == B.

find_root(Steps, Root) :-
  select(Step, Steps, Rest),
  [ A, _ ] = Step,
  not(member([ _, A ], Rest)),
  !,
  Root = A.




  % member(step(B, C), Rest),
  % OrderedSteps = [A, B, C]
  % atomics_to_string([ A, B, C ], X).
