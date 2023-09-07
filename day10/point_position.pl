:- module(point_position, [point_position/3]).

point_position(N, Point, OutPosition) :-
  point{position: vector(Px, Py), velocity: vector(Vx, Vy)} = Point,
  X is Px + (N * Vx),
  Y is Py + (N * Vy),
  OutPosition = vector(X, Y).
