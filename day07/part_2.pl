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
  available_steps(Steps, Path, AvailableSteps),
  subtract(Steps, AvailableSteps, UnAvailableSteps),
  assign_work(BaseDelay, AvailableSteps, Workers, RemainingAvailableSteps, AssignedWorkers),
  append(UnAvailableSteps, RemainingAvailableSteps, RemainingSteps),
  do_work(Path, AssignedWorkers, NewPath, TiredWorkers),
  NewAcc is Acc + 1,
  walk_steps(Result, BaseDelay, RemainingSteps, TiredWorkers, NewPath, NewAcc).

init_workers(NumWorkers, Workers) :-
  findall(X, between(1, NumWorkers, X), Ids),
  maplist(init_worker, Ids, Workers).

init_worker(Id, worker(Id, none)).

all_workers_idle(Workers) :-
  idle_workers(Workers, Workers).

idle_workers(Workers, IdleWorkers) :-
  findall(W, (member(W, Workers), idle(W)), IdleWorkers).

idle(worker(_, none)).
  % findall(W, (member(W, Workers), worker(_, none) = W), Workers)
