:- module(part_1, [part_1/2]).

:- use_module(count_naps_containing_minute).

part_1([], _) :- !, false.
part_1(Guards, Answer) :-
  most_sleepy_guard(Guards, SleepyGuard),

  naps_minute_most_asleep(SleepyGuard.naps, Minute),
  Answer is SleepyGuard.id * Minute.

most_sleepy_guard([], _) :- !, fail.

most_sleepy_guard(Guards, SleepyGuard) :-
  [ Guard | Rest ] = Guards,
  most_sleepy_guard(Rest, SleepyGuard, Guard).

most_sleepy_guard([], SleepyGuard, Candidate) :- !, SleepyGuard = Candidate.

most_sleepy_guard(Guards, SleepyGuard, Candidate) :-
  [ Guard | Rest ] = Guards,
  minutes_asleep(Guard.naps, GuardMinutes),
  minutes_asleep(Candidate.naps, CandidateMinutes),
  (GuardMinutes > CandidateMinutes
   -> most_sleepy_guard(Rest, SleepyGuard, Guard)
   ;  most_sleepy_guard(Rest, SleepyGuard, Candidate)).

minutes_asleep(Naps, Minutes) :- minutes_asleep(Naps, Minutes, 0).
minutes_asleep([], Minutes, Acc) :- !, Minutes = Acc.
minutes_asleep(Naps, Minutes, Acc) :-
  [ Nap | Rest ] = Naps,
  [ Begin, End ] = Nap,
  NapMinutes is End - Begin,
  NewAcc is Acc + NapMinutes,
  minutes_asleep(Rest, Minutes, NewAcc).

naps_minute_most_asleep(Naps, MinuteMostAsleep) :-
  findall(
    [Minute, Count],
    (between(0, 59, Minute), count_naps_containing_minute(Naps, Minute, Count), Count > 0),
    MinuteNapCounts
  ),

  minute_with_max_count(MinuteNapCounts, MinuteMostAsleep).

minute_with_max_count(MinuteNapCounts, MinuteWithMaxCount) :-
  [ Head | Rest ] = MinuteNapCounts,
  minute_with_max_count(Rest, MinuteWithMaxCount, Head).

minute_with_max_count([], MinuteWithMaxCount, Acc) :- !, [ MinuteWithMaxCount, _ ] = Acc.
minute_with_max_count(MinuteNapCounts, MinuteWithMaxCount, Acc) :-
  [ Head | Rest ] = MinuteNapCounts,
  [ _, HeadCount ] = Head,
  [ _, AccCount ] = Acc,
  (HeadCount > AccCount
   -> minute_with_max_count(Rest, MinuteWithMaxCount, Head)
   ;  minute_with_max_count(Rest, MinuteWithMaxCount, Acc)).



:- begin_tests(part_1).

test(part_1_when_empty, fail) :-
  part_1([], _).

test(part_1_when_one_minute, true(Actual==Expected)) :-
  Expected = 30,
  part_1([guard{id: 1, naps:[[30,31]]}], Actual).

test(part_1_when_different_minute, true(Actual==Expected)) :-
  Expected = 15,
  part_1([guard{id: 1, naps:[[15,16]]}], Actual).

test(part_1_when_different_id, true(Actual==Expected)) :-
  Expected = 45,
  part_1([guard{id: 3, naps:[[15,16]]}], Actual).

test(part_1_when_guard_has_overlapping_naps, true(Actual==Expected)) :-
  Expected = 19,
  part_1([guard{id: 1, naps:[[10,20], [19, 25]]}], Actual).

test(part_1_when_two_guards, true(Actual==Expected)) :-
  Expected = 38,
  part_1([
    guard{id: 1, naps:[[10,20]]},
    guard{id: 2, naps:[[10,20], [19, 25]]}
  ], Actual).

test(part_1_when_guard_has_three_naps_and_one_no_overlap, true(Actual==Expected)) :-
  Expected = 19,
  part_1([guard{id: 1, naps:[[10,20], [19, 25], [40, 45]]}], Actual).

:- end_tests(part_1).