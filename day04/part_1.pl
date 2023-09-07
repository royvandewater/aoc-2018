:- module(part_1, [part_1/2]).

:- use_module(count_naps_containing_minute).
:- use_module(minute_with_max_count).

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

  minute_with_max_count(MinuteNapCounts, [ MinuteMostAsleep, _Count]).

