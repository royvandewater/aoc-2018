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
