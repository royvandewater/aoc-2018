:- use_module(part_1).

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