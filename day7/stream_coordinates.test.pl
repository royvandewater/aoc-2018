:- use_module(stream_coordinates).

:- begin_tests(stream_coordinates).

test(stream_coordinates_when_empty, true(Actual == Expected)) :-
  Expected = [],
  open_string("", Stream),
  stream_coordinates(Stream, Actual).

test(stream_coordinates_when_one_coordinate, true(Actual == Expected)) :-
  Expected = [coordinate(1, 1)],
  open_string("1, 1", Stream),
  stream_coordinates(Stream, Actual).

:- end_tests(stream_coordinates).