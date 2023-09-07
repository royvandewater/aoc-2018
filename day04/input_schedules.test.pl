:- use_module(input_schedules).

:- begin_tests(input_schedules).

test(input_schedules_when_empty, true(X==[])) :-
  open_string("", Stream),
  input_schedules(Stream, X).

test(input_schedules_when_one_line, true(X==[schedule{date: [7, 18], guard_id: 157, naps: []}])) :-
  open_string("[1518-07-18 23:57] Guard #157 begins shift", Stream),
  input_schedules(Stream, X).

test(input_schedules_when_three_lines_and_guard_sleeps, true(X==Expected)) :-
  Expected = [schedule{date: [1, 19], guard_id: 1021, naps: [[19, 55]]}],
  % leash(-all), leash(+fail), trace,
  split_string("
    [1518-01-19 00:03] Guard #1021 begins shift
    [1518-01-19 00:19] falls asleep
    [1518-01-19 00:55] wakes up
  ", "", " \r\n", [Trimmed]),

  open_string(Trimmed, Stream),
  input_schedules(Stream, X).

test(input_schedules_when_two_lines_two_guards, true(X==Expected)) :-
    Expected = [
      schedule{date: [1, 19], guard_id: 1021, naps: []},
      schedule{date: [1, 20], guard_id: 1022, naps: []}
    ],
    split_string("
      [1518-01-19 00:03] Guard #1021 begins shift
      [1518-01-20 00:03] Guard #1022 begins shift
    ", "", " \r\n", [Trimmed]),

    open_string(Trimmed, Stream),
    input_schedules(Stream, X).


:- end_tests(input_schedules).