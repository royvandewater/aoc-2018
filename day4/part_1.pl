:- module(part_1, [part_1/2]).

part_1([], _) :- !, false.
part_1(Guards, Answer) :-
  most_sleepy_guard(Guards, SleepyGuard),

  minute_in_naps(SleepyGuard.naps, Minute), !,
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

minute_in_naps([], _) :- !, true.
minute_in_naps(Naps, Minute) :-
  [ Nap | Rest ] = Naps,
  [ Begin, End ] = Nap,
  between_non_inclusive_high(Begin, End, Minute),
  minute_in_naps(Rest, Minute).

between_non_inclusive_high(Low, High, Value) :-
  between(Low, High, Value),
  Value \= High.

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

test(part_1_when_guard_has_overlapping_namps, true(Actual==Expected)) :-
  Expected = 19,
  part_1([guard{id: 1, naps:[[10,20], [19, 25]]}], Actual).

test(part_1_when_two_guards, true(Actual==Expected)) :-
  Expected = 38,
  part_1([
    guard{id: 1, naps:[[10,20]]},
    guard{id: 2, naps:[[10,20], [19, 25]]}
  ], Actual).

:- end_tests(part_1).