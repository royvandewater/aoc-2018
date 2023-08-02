:- module(coordinates_finite, [coordinates_finite/2]).
:- use_module(finite).

coordinates_finite(Coordinates, Finite) :-
  include(finite(Coordinates), Coordinates, Finite).
