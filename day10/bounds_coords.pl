:- module(bounds_coords, [bounds_coords/2]).

bounds_coords([Xmin, Xmax, Ymin, Ymax], Coords) :- bounds_coords([Xmin, Xmax, Ymin, Ymax], Coords, Xmin, Ymax, [[]]).

bounds_coords([_, Xmax, Ymin, _], Coords, X, Y, Acc) :-
  X > Xmax,
  Y =< Ymin,
  !,
  maplist(reverse, Acc, Coords).

bounds_coords(Bounds, Coords, X, Y, Acc) :-
  [Xmin, Xmax, _, _] = Bounds,
  X > Xmax,
  !,
  Y1 is Y - 1,
  bounds_coords(Bounds, Coords, Xmin, Y1, [ [] | Acc ]).

bounds_coords(Bounds, Coords, X, Y, Acc) :-
  [ Line | Rest ] = Acc,
  X1 is X + 1,
  Line1 = [ vector(X, Y) | Line ],
  bounds_coords(Bounds, Coords, X1, Y, [ Line1 | Rest ]).
