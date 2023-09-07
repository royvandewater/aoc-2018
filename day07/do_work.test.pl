:- use_module(do_work).

:- begin_tests(do_work).

test(when_empty) :-
  do_work([], [], NewPath, NewWorkers),
  assertion(NewPath == []),
  assertion(NewWorkers == []).

test(when_worker_working) :-
  do_work([], [worker(1, work('A', 2))], NewPath, NewWorkers),
  assertion(NewPath == []),
  % it should decrement the remaining work
  assertion(NewWorkers == [worker(1, work('A', 1))]).

test(when_worker_idle) :-
  do_work([], [worker(1, none)], NewPath, NewWorkers),
  assertion(NewPath == []),
  assertion(NewWorkers == [worker(1, none)]).

test(when_worker_has_one_tick_left) :-
  do_work([], [worker(1, work('A', 1))], NewPath, NewWorkers),
  assertion(NewPath == ['A']),
  assertion(NewWorkers == [worker(1, none)]).

:- end_tests(do_work).