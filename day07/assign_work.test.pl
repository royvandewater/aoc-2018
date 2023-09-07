:- use_module(assign_work).

:- begin_tests(assign_work).

test(when_empty_steps, true([X, Y] == [[], [worker(1, none)]])) :-
  Steps = [],
  Workers = [worker(1, none)],
  % If there's no work to be done, then workers in and workers out are the same
  assign_work(0, Steps, Workers, X, Y).

test(when_one_step_idle_worker, true([X, Y] == [ExpectX, ExpectY])) :-
  ExpectX = [],
  ExpectY = [worker(1, work('A', 1))],

  Steps = [step('A', [])],
  Workers = [worker(1, none)],
  % If there's no work to be done, then workers in and workers out are the same
  assign_work(0, Steps, Workers, X, Y).

test(when_one_step_two_idle_workers) :-
  Steps = [step('A', [])],
  Workers = [worker(1, none), worker(2, none)],

  assign_work(0, Steps, Workers, X, Y),

  assertion(X == []),
  assertion(order_independent_equals(Y, [worker(1, work('A', 1)), worker(2, none)])).

test(when_one_step_busy_worker) :-
  Steps = [step('B', [])],
  Workers = [worker(1, work('B', 2))],

  assign_work(0, Steps, Workers, X, Y),

  assertion(X == Steps),
  assertion(order_independent_equals(Y, Workers)).

test(when_one_step_one_busy_worker_one_idle) :-
  Steps = [step('B', [])],
  Workers = [worker(1, work('A', 2)), worker(2, none)],

  assign_work(0, Steps, Workers, X, Y),

  assertion(X == []),
  assertion(order_independent_equals(Y, [worker(1, work('A', 2)), worker(2, work('B', 2))])).

test(when_one_blocked_step_one_idle_worker) :-
  Steps = [step('B', [])],
  Workers = [worker(1, work('A', 2)), worker(2, none)],

  assign_work(0, Steps, Workers, X, Y),

  assertion(X == []),
  assertion(order_independent_equals(Y, [worker(1, work('A', 2)), worker(2, work('B', 2))])).

order_independent_equals(A, B) :-
  list_to_set(A, Aset),
  list_to_set(B, Bset),
  subset(Aset, Bset),
  subset(Bset, Aset).

:- end_tests(assign_work).