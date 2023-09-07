:- module(input_points, [input_points/2]).

:- use_module(debug).

input_points(Input, Points) :-
  trim(Input, Trimmed),
  string_lines(Trimmed, Lines),
  input_points(Lines, Points, []).

input_points([], Points, Acc) :- !, reverse(Points, Acc).

input_points([ Line | Rest ], Points, Acc) :-
  line_point(Line, Point),
  input_points(Rest, Points, [ Point | Acc ]).

line_point(Line, Point) :-
  nl,
  split_string(Line, ",>", " abcdefghijklmnopqrstuvwxyz=<", [PosXStr, PosYStr, VelXStr, VelYStr, _]),
  maplist(atom_number, [PosXStr, PosYStr, VelXStr, VelYStr], [PosX, PosY, VelX, VelY]),
  Point = point{
    position: vector(PosX, PosY),
    velocity: vector(VelX, VelY)
  }.

trim(In, Out) :- split_string(In, "", "\s\t\n", [Out]).