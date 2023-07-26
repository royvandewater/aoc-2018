:- module(part_2, [part_2/2]).

:- use_module(count_naps_containing_minute).
:- use_module(minute_with_max_count).

part_2([], _) :- !, false.

part_2(Guards, Answer) :-
  findall([G, M, C], (member(G, Guards), minute_count_most_asleep(G.naps, M, C)), GuardMinuteCounts),
  max_guard_minute_count(GuardMinuteCounts, GuardMinuteCount),

  [Guard, Minute, _] = GuardMinuteCount,
  Answer is Guard.id * Minute.

max_guard_minute_count(GuardMinuteCounts, Result) :-
  [ Head | Rest ] = GuardMinuteCounts,
  max_guard_minute_count(Rest, Result, Head).

max_guard_minute_count([], Result, Acc) :- !, Result = Acc.
max_guard_minute_count(GuardMinuteCounts, Result, Acc) :-
  [ Head | Rest ] = GuardMinuteCounts,
  [ _, _, HeadCount ] = Head,
  [ _, _, AccCount ] = Acc,
  (HeadCount > AccCount
   -> max_guard_minute_count(Rest, Result, Head)
   ;  max_guard_minute_count(Rest, Result, Acc)).

minute_count_most_asleep(Naps, MinuteMostAsleep, CountMostAsleep) :-
  findall(
    [M, C],
    (between(0, 59, M), count_naps_containing_minute(Naps, M, C), C > 0),
    MinuteNapCounts
  ),
  minute_with_max_count(MinuteNapCounts, [ MinuteMostAsleep, CountMostAsleep ]).