:- module(available_steps, [available_steps/3]).

available_steps(Steps, Path, AvailableSteps) :-
  include(requirements_met(Path), Steps, UnsortedAvailableSteps),
  sort(UnsortedAvailableSteps, AvailableSteps).

requirements_met(Path, Step) :-
  step( _, Reqs) = Step,
  maplist(requirement_met(Path), Reqs).

requirement_met(Path, Req) :- member(Req, Path).