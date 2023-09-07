:- use_module(part_2).

:- begin_tests(part_2).

test(part_2_when_empty, fail) :-
  part_2([], _).

test(part_2_when_one_minute, true(Actual==Expected)) :-
  Expected = 30,
  part_2([guard{id: 1, naps:[[30,31]]}], Actual).

test(part_2_when_one_minute_different_id, true(Actual==Expected)) :-
  Expected = 60,
  part_2([guard{id: 2, naps:[[30,31]]}], Actual).

test(part_2_when_different_minute, true(Actual==Expected)) :-
  Expected = 15,
  part_2([guard{id: 1, naps:[[15,16]]}], Actual).

test(part_2_when_two_guards, true(Actual==Expected)) :-
  Expected = 15,
  part_2([
    guard{id: 1, naps:[[14,16], [15, 16]]},
    guard{id: 2, naps:[[15,16]]}
  ], Actual).


:- end_tests(part_2).