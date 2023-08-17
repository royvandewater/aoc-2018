:- module(do_work, [do_work/4]).

do_work(Path, Workers, NewPath, TiredWorkers) :-
  maplist(decrement_delay, Workers, TiredWorkers, CompletedNodes),
  findall(N, (member(N, CompletedNodes), N \= none), FilteredCompletedNodes),
  append(Path, FilteredCompletedNodes, NewPath).

decrement_delay(Worker, TiredWorker, none) :-
  worker(_, none) = Worker,
  !,
  TiredWorker = Worker.

decrement_delay(Worker, TiredWorker, CompletedNode) :-
  worker(Id, work(Node, 1)) = Worker,
  !,
  TiredWorker = worker(Id, none),
  CompletedNode = Node.

decrement_delay(Worker, TiredWorker, none) :-
  worker(Id, work(Node, Delay)) = Worker,
  NewDelay is Delay - 1,
  TiredWorker = worker(Id, work(Node, NewDelay)).

