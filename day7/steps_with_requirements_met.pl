:- module(steps_with_requirements_met, [steps_with_requirements_met/2]).

steps_with_requirements_met(Steps, ValidSteps) :-
  findall(Step,
          (destination_has_no_unmet_prerequisites(Step, Steps),
           no_other_steps_go_to_step_origin(Step, Steps)),
          ValidSteps).

destination_has_no_unmet_prerequisites(Step, Steps) :- true.
  [ _, Destination ] = Step,
  findall([ Origin, Destination ], member([ Origin, Destination ], Steps), PreReqs),
  % select(Step, Steps, Rest),
  % [ _, Destination ] = Step,
  % not(member([ _, Destination ], Rest)).

no_other_steps_go_to_step_origin(Step, Steps) :-
  select(Step, Steps, Rest),
  [ Origin, _ ] = Step,
  not(member([ _, Origin ], Rest)).

:- begin_tests(step_has_no_unmet_prerequisites).

test(when_empty) :-
  step_has_no_unmet_prerequisites(['A', 'B'], []).

test(when_steps_contain_unsatisfied_prerequisite, fail) :-
  step_has_no_unmet_prerequisites(['A', 'D'], [['B', 'C'], ['C', 'D']]).

:- end_tests(step_has_no_unmet_prerequisites).