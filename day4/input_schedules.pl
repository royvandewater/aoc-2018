:- module(input_schedules, [input_schedules/2]).

input_schedules(In, Schedules) :- input_schedules(In, Schedules, []).

input_schedules(In, Schedules, Acc) :-
  read_line_to_string(In, Line),
  input_schedules(In, Schedules, Acc, Line).

input_schedules(_, Schedules, Acc, end_of_file) :-
  sort(date, @=<, Acc, Schedules), !.

input_schedules(In, Schedules, Acc, Line) :-
  sub_string(Line, _, _, After, "] "), !,
  sub_atom(Line, _, After, 0, Message),
  input_schedules(In, Schedules, Acc, Line, Message).

input_schedules(In, Schedules, Acc, Line, 'falls asleep') :- !,
  line_minutes(Line, Start),
  [ S | Rest ] = Acc,
  Naps = [ [Start] | S.naps ],
  Schedule = S.put(naps, Naps),
  NewAcc = [ Schedule | Rest ],
  input_schedules(In, Schedules, NewAcc).

input_schedules(In, Schedules, Acc, Line, 'wakes up') :- !,
  line_minutes(Line, End),
  [ Schedule | RestSchedules ] = Acc,
  [ Nap | RestNaps ] = Schedule.naps,
  append(Nap, [End], NewNap),
  NewNaps = [ NewNap | RestNaps ],
  NewSchedule = Schedule.put(naps, NewNaps),
  NewAcc = [ NewSchedule | RestSchedules ],
  input_schedules(In, Schedules, NewAcc).

input_schedules(In, Schedules, Acc, Line, _) :- % Guard #123 begins shift
  split_string(Line, " -", "[]# ", Parts),
  [_, MonthStr, DayStr, _, _, GuardIdStr | _] = Parts,
  atom_number(MonthStr, Month),
  atom_number(DayStr, Day),
  atom_number(GuardIdStr, GuardId),
  Schedule = schedule{date: [Month, Day], guard_id: GuardId, naps: []},
  NewAcc = [ Schedule | Acc ],
  input_schedules(In, Schedules, NewAcc).

line_minutes(Line, Minutes) :-
  split_string(Line, " :", "] ", Parts),
  [_, _, MinutesStr | _] = Parts,
  atom_number(MinutesStr, Minutes).

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