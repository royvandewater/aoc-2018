:- module(dimensions, [dimensions/2]).

:- table dimensions/2.
dimensions(Coordinates, Dimensions) :-
  % format("dimensions\n"),
  aggregate_all(min(X), member(coordinate(X, _), Coordinates), MinX),
  aggregate_all(min(Y), member(coordinate(_, Y), Coordinates), MinY),
  aggregate_all(max(X), member(coordinate(X, _), Coordinates), MaxX),
  aggregate_all(max(Y), member(coordinate(_, Y), Coordinates), MaxY),
  Dimensions = [MinX, MinY, MaxX, MaxY].
