:- use_module(is_sum_of_distances_to_coordinates_less_than).

:- begin_tests(is_sum_of_distances_to_coordinates_less_than).

test(when_empty, fail) :-
  is_sum_of_distances_to_coordinates_less_than(1, coordinate(1, 1), []).

test(when_one_coordinate_equal) :-
  is_sum_of_distances_to_coordinates_less_than(1, coordinate(1, 1), [ coordinate(1, 1) ]).

test(when_one_coordinate_too_far_away, fail) :-
  is_sum_of_distances_to_coordinates_less_than(1, coordinate(1, 1), [ coordinate(3, 1) ]).

test(when_two_coordinates_close_enough) :-
  is_sum_of_distances_to_coordinates_less_than(2, coordinate(1, 1), [ coordinate(1, 1),
                                                                      coordinate(1, 2) ]).

test(when_two_coordinates_too_far, fail) :-
  is_sum_of_distances_to_coordinates_less_than(2, coordinate(1, 1), [ coordinate(1, 1),
                                                                      coordinate(1, 3) ]).

test(when_three_coordinates_too_far, fail) :-
  is_sum_of_distances_to_coordinates_less_than(2, coordinate(1, 1), [ coordinate(1, 1),
                                                                      coordinate(1, 2),
                                                                      coordinate(2, 1) ]).

test(when_a_box) :-
  % 1.2
  % .#.
  % 3.4
  is_sum_of_distances_to_coordinates_less_than(9, coordinate(1, 1), [ coordinate(0, 0),
                                                                      coordinate(2, 0),
                                                                      coordinate(0, 2),
                                                                      coordinate(2, 2) ]).

:- end_tests(is_sum_of_distances_to_coordinates_less_than).