:- module(schedules_guards, [schedules_guards/2]).

:- use_module(library(dicts)).
:- use_module(library(pairs)).

schedules_guards([], []) :- !, true.
schedules_guards(Schedules, Guards) :-
  group_by_guard_id(Schedules, Grouped),
  maplist(schedule_group_guard, Grouped, Guards).

group_by_guard_id(Schedules, Grouped) :- group_by_guard_id(Schedules, Grouped, grouped{}).
group_by_guard_id([], Grouped, Acc) :- !, dict_values(Acc, Grouped).
group_by_guard_id(Schedules, Grouped, Acc) :-
  [ Schedule | Rest ] = Schedules,
  Key = Schedule.guard_id,
  Group = Acc.get(Key, guard{id: Schedule.guard_id, naps: []}), !,
  append(Group.naps, Schedule.naps, NewNaps),
  NewGroup = Group.put(naps, NewNaps),
  NewAcc = Acc.put(Key, NewGroup),
  group_by_guard_id(Rest, Grouped, NewAcc).

schedule_group_guard(Group, Guard) :- Guard = guard{id: Group.id, naps: Group.naps}.

dict_values(Dict, Values) :-
  dict_pairs(Dict,_,Pairs),
  pairs_values(Pairs,Values).

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