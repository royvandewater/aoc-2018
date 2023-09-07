:- use_module(exists_closer_coordinate_to_pixel).

:- begin_tests(exists_closer_coordinate_to_pixel).

test(when_example_1_and_none, fail) :-
  exists_closer_coordinate_to_pixel(
    [
      coordinate(1, 1), % A
      coordinate(1, 6), % B
      coordinate(8, 3), % C
      coordinate(3, 4), % D - finite
      coordinate(5, 5), % E - finite
      coordinate(8, 9)  % F
    ],
    coordinate(3, 4),
    coordinate(2, 4)
  ).

test(when_example_1_and_A_is_closer) :-
  exists_closer_coordinate_to_pixel(
    [
      coordinate(1, 1), % A
      coordinate(3, 4) % D - finite
    ],
    coordinate(3, 4),
    coordinate(1, 3)
  ).

test(when_example_1_and_B_is_same_distance) :-
  exists_closer_coordinate_to_pixel(
    [
      coordinate(1, 6), % B
      coordinate(3, 4) % D - finite
    ],
    coordinate(3, 4),
    coordinate(1, 4)
  ).


:- end_tests(exists_closer_coordinate_to_pixel).