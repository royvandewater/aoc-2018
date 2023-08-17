:- module(part_2, [part_2/4]).

:- use_module(assign_work).
:- use_module(available_steps).
:- use_module(do_work).

debug(Str, Vars) :- nl, format(Str, Vars), nl.

part_2(NumWorkers, BaseDelay, Steps, Result) :-
  init_workers(NumWorkers, Workers),
  walk_steps(Result, BaseDelay, Steps, Workers, [], 0).

walk_steps(Result, _BaseDelay, [], Workers, _Path, Acc) :-
  all_workers_idle(Workers),
  !, Result = Acc.

walk_steps(Result, BaseDelay, Steps, Workers, Path, Acc) :-
  % available_steps(Steps, Path, AvailableSteps),
  % available_workers(Workers, AvailableWorkers, BusyWorkers),
  available_steps(Steps, Path, AvailableSteps),
  subtract(Steps, AvailableSteps, UnAvailableSteps),
  assign_work(BaseDelay, AvailableSteps, Workers, RemainingAvailableSteps, AssignedWorkers),
  append(UnAvailableSteps, RemainingAvailableSteps, RemainingSteps),
  do_work(Path, AssignedWorkers, NewPath, TiredWorkers),
  NewAcc is Acc + 1,
  walk_steps(Result, BaseDelay, RemainingSteps, TiredWorkers, NewPath, NewAcc).

  % maplist(step_duration(BaseDelay), Steps, Durations),
  % sumlist(Durations, Result).

step_duration(Delay, Step, Duration) :-
  step( Origin, _ ) = Step,
  atom_codes( Origin, [ Code ] ),
  Duration is Delay + Code - 64. % A is 65, so we subtract 64 to make it 1

init_workers(NumWorkers, Workers) :-
  findall(Worker, (between(1, NumWorkers, Id), Worker = worker(Id, none)), Workers).

all_workers_idle(Workers) :-
  findall(worker(Id, none), member(worker(Id, _), Workers), Workers).
  % findall(W, (member(W, Workers), worker(_, none) = W), Workers)
