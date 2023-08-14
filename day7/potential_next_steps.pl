:- module(potential_next_steps, [potential_next_steps/3]).

:- use_module(steps_with_requirements_met).

potential_next_steps(Steps, Path, PotentialNextSteps) :-
  steps_with_requirements_met(Steps, PotentialNextSteps).
  % nl, format("Steps: ~w, ValidSteps: ~w", [Steps, ValidSteps]), nl,
  % findall(
  %   [ A, B ],
  %   (member([ A, B ], ValidSteps), member(A, Path)),
  %   PotentialNextSteps
  % ).