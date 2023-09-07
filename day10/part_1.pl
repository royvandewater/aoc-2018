:- module(part_1, [part_1/3]).

:- use_module(point_position).
:- use_module(positions_string).

part_1([], 0, "").
part_1(Points, N, Out) :-
  maplist(point_position(N), Points, Positions),
  positions_string(Positions, Out).
