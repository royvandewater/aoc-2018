:- use_module(count_naps_containing_minute).

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