:- module(assign_work, [assign_work/5]).

debug(Str, Vars) :- nl, format(Str, Vars), nl.

assign_work(Delay, Steps, Workers, FinalRemainingSteps, FinalAssignedWorkers) :-
  % trace,
  assign_work(Delay, Steps, Workers, FinalRemainingSteps, FinalAssignedWorkers, []).


% When no more steps, incoming steps are the remaining steps and final workers becomes
% the combination of workers and assigned workers
assign_work(_Delay, [], Workers, FinalRemainingSteps, FinalAssignedWorkers, AccWorkers) :-
  !,
  FinalRemainingSteps = [],
  append(Workers, AccWorkers, FinalAssignedWorkers).

% When no more workers, incoming steps are the remaining steps and assigned workers becomes the workers
assign_work(_Delay, Steps, Workers, FinalRemainingSteps, FinalAssignedWorkers, AccWorkers) :-
  idle_workers(Workers, []),
  !,
  FinalRemainingSteps = Steps,
  append(Workers, AccWorkers, FinalAssignedWorkers).

assign_work(Delay, Steps, Workers, Rs, Rw, AccWorkers) :-
  idle_workers(Workers, IdleWorkers),
  member(Worker, IdleWorkers),
  select(Worker, Workers, RestWorkers),
  select(Step, Steps, RemainingSteps),
  !,
  assign_step_to_worker(Delay, Step, Worker, AssignedWorker),
  assign_work(Delay, RemainingSteps, RestWorkers, Rs, Rw, [ AssignedWorker | AccWorkers ]).

assign_step_to_worker(Delay, Step, Worker, AssignedWorker) :-
  step_duration(Delay, Step, Duration),
  step_name(Step, Name),
  worker_id(Worker, Id),
  AssignedWorker = worker(Id, work(Name, Duration)).

step_duration(Delay, Step, Duration) :-
  step( Origin, _ ) = Step,
  atom_codes( Origin, [ Code ] ),
  Duration is Delay + Code - 64. % A is 65, so we subtract 64 to make it 1

idle_workers(Workers, IdleWorkers) :-
  findall(W, (member(W, Workers), W = worker(_, none)), IdleWorkers).

step_name(step(Name, _), Name).
worker_id(worker(Id, _), Id).