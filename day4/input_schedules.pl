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
