:- use_module(schedules_guards).

:- begin_tests(schedules_guards).

test(schedules_guards_when_empty, true(Actual == Expected)) :-
  Expected = [],
  schedules_guards([], Actual).

test(schedules_guards_when_one_schedule, true(Actual == Expected)) :-
  Expected = [guard{id: 1, naps: []}],
  schedules_guards([schedule{guard_id: 1, naps: []}], Actual).

test(schedules_guards_when_one_guard_two_schedules, true(Actual == Expected)) :-
  Expected = [guard{id: 1, naps: [[1, 2], [3, 4]]}],
  schedules_guards([
    schedule{guard_id: 1, naps: [[1, 2]]},
    schedule{guard_id: 1, naps: [[3, 4]]}
  ], Actual).

test(schedules_guards_when_two_guard_two_schedules, true(Actual == Expected)) :-
  Expected = [guard{id: 1, naps: [[1, 2]]},
              guard{id: 2, naps: [[3, 4]]}],
  schedules_guards([
    schedule{guard_id: 1, naps: [[1, 2]]},
    schedule{guard_id: 2, naps: [[3, 4]]}
  ], Actual).

:- end_tests(schedules_guards).