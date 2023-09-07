:- use_module(part_2).

:- begin_tests(part_2).

test(part_2_when_empty, true(Actual == Expected)) :-
  Expected = 0,
  part_2("", Actual).

test(part_2_when_removing_c_helps, true(Actual == Expected)) :-
  Expected = 0,
  part_2("acA", Actual).

:- end_tests(part_2).