:- module(power_level, [power_level/3]).

:- use_module(debug).

power_level(Serial, Coordinate, PowerLevel) :-
  c(X, Y) = Coordinate,
  RackId is X + 10,
  P0 is RackId * Y,
  P1 is P0 + Serial,
  P2 is P1 * RackId,
  P3 is (P2 // 100) mod 10,
  PowerLevel is P3 - 5.
