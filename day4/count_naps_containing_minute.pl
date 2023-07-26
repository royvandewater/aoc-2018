:- module(count_naps_containing_minute, [count_naps_containing_minute/3]).

count_naps_containing_minute(Naps, Minute, Count) :- count_naps_containing_minute(Naps, Minute, Count, 0).
count_naps_containing_minute([], _, Count, Acc) :- !, Count = Acc.
count_naps_containing_minute(Naps, Minute, Count, Acc) :-
  [ Nap | Rest ] = Naps,
  [ Low, High ] = Nap,
  (between_non_inclusive_high(Low, High, Minute)
   -> (NewAcc is Acc + 1, count_naps_containing_minute(Rest, Minute, Count, NewAcc))
   ;  count_naps_containing_minute(Rest, Minute, Count, Acc)).

between_non_inclusive_high(Low, High, Value) :-
  between(Low, High, Value),
  Value \= High.

:- begin_tests(count_naps_containing_minute).

test(count_naps_containing_minute_when_empty, true(Actual == Expected)) :-
  Expected = 0,
  count_naps_containing_minute([], 1, Actual).

test(count_naps_containing_minute_when_one_nap, true(Actual == Expected)) :-
  Expected = 1,
  count_naps_containing_minute([[0, 3]], 1, Actual).

test(count_naps_containing_minute_when_two_naps, true(Actual == Expected)) :-
  Expected = 2,
  count_naps_containing_minute([[0, 3], [1, 5]], 2, Actual).

:- end_tests(count_naps_containing_minute).