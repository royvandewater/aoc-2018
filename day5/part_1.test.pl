:- use_module(part_1).

:- begin_tests(part_1).

test(part_1_when_empty, true(Actual == Expected)) :-
  Expected = 0,
  part_1("", Actual).

test(part_1_when_no_cancels, true(Actual == Expected)) :-
  Expected = 2,
  part_1("ab", Actual).

test(part_1_when_immediate_cancel, true(Actual == Expected)) :-
  Expected = 0,
  part_1("aA", Actual).

test(part_1_when_secondary_cancel, true(Actual == Expected)) :-
  Expected = 0,
  part_1("abBA", Actual).

:- end_tests(part_1).