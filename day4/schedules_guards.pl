:- module(schedules_guards, [schedules_guards/2]).

schedules_guards([], []) :- !, true.
schedules_guards(Schedules, Guards) :-
  group_by_guard_id(Schedules, Grouped),
  nl, write("Grouped: "), writeln(Grouped),
  maplist(schedule_guard, Schedules, Guards).

group_by_guard_id(Schedules, Grouped) :- group_by_guard_id(Schedules, Grouped, grouped{}).
group_by_guard_id([], Grouped, Acc) :- !, Grouped = Acc.
group_by_guard_id(Schedules, Grouped, Acc) :-
  [ Schedule | Rest ] = Schedules,
  Group = Acc.get(Schedule.id, guard{id: Schedule.GuardId, naps: []}),
  append(Group.naps, Schedule.naps, NewNaps),
  NewGroup = Group.put(naps, NewNaps),
  NewAcc = Acc.put(Schedule.id, NewGroup),
  group_by_guard_id(Rest, Grouped, NewAcc).

schedule_guard(Schedule, Guard) :-
  Guard = guard{id: Schedule.guard_id, naps: Schedule.naps}.

:- begin_tests(schedules_guards).

test(schedules_guards_when_empty, true(Actual == Expected)) :-
  Expected = [],
  schedules_guards([], Actual).

test(schedules_guards_when_one_schedule, true(Actual == Expected)) :-
  Expected = [guard{id: 1, naps: []}],
  schedules_guards([schedule{guard_id: 1, naps: []}], Actual).

test(schedules_guards_when_one_guard_two_schedules, true(Actual == Expected)) :-
  Expected = [guard{id: 1, naps: [[1, 2], [3, 4]]}],
  schedules_guards([
    schedule{guard_id: 1, naps: [[1, 2]]},
    schedule{guard_id: 1, naps: [[3, 4]]}
  ], Actual).

test(schedules_guards_when_two_guard_two_schedules, true(Actual == Expected)) :-
  Expected = [guard{id: 1, naps: [[1, 2]]},
              guard{id: 2, naps: [[3, 4]]}],
  schedules_guards([
    schedule{guard_id: 1, naps: [[1, 2]]},
    schedule{guard_id: 2, naps: [[3, 4]]}
  ], Actual).

:- end_tests(schedules_guards).