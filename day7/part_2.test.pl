:- use_module(part_2).

:- begin_tests(part_2).

test(when_given_empty_list, fail) :-
  part_2(1, [], _).

test(when_given_distance_one_and_one_coordinate, true(X == 1)) :-
  part_2(1, [coordinate(1, 1)], X).

test(when_a_box, true(X == 9)) :-
  part_2(9, [ coordinate(0, 0),
              coordinate(2, 0),
              coordinate(0, 2),
              coordinate(2, 2) ], X).

test(when_example_1, true(X == 16)) :-
  part_2(32, [ coordinate(1, 1),
               coordinate(1, 6),
               coordinate(8, 3),
               coordinate(3, 4),
               coordinate(5, 5),
               coordinate(8, 9) ], X).

:- end_tests(part_2).