:- module(stream_coordinates, [stream_coordinates/2]).

stream_coordinates(In, Coordinates) :- stream_coordinates(In, Coordinates, []).

stream_coordinates(In, Coordinates, Acc) :-
  read_line_to_string(In, Line),
  stream_coordinates(In, Coordinates, Acc, Line).

stream_coordinates(_In, Coordinates, Acc, end_of_file) :- !, Coordinates = Acc.

stream_coordinates(In, Coordinates, Acc, Line) :-
  split_string(Line, ",", " ", [Xstr, Ystr]),
  atom_number(Xstr, X),
  atom_number(Ystr, Y),
  append(Acc, [coordinate(X, Y)], NewAcc),
  stream_coordinates(In, Coordinates, NewAcc).