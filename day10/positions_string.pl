:- module(positions_string, [positions_string/2]).

positions_string([], "") :- !.

positions_string(Positions, OutStr) :-
  maplist(position_x, Positions, Xs),
  min_list(Xs, Xmin),
  max_list(Xs, Xmax),
  maplist(position_y, Positions, Ys),
  min_list(Ys, Ymin),
  max_list(Ys, Ymax),
  positions_dict(Positions, Dict),
  bounds_coords(Xmin, Xmax, Ymin, Ymax, Coords),
  maplist(format_point(Dict), Coords, Pixels),
  string_chars(OutStr, Pixels).

position_x(vector(X, _), X).
position_y(vector(_, Y), Y).

bounds_coords(Xmin, Xmax, Ymin, Ymax, Coords) :- bounds_coords(Xmin, Xmax, Ymin, Ymax, Coords, Xmin, Ymax, [[]]).
bounds_coords(_   , Xmax, Ymin, _   , Coords, X, Y, Acc) :-
  X > Xmax,
  Y < Ymin,
  !,
  reverse(Acc, ReverseAcc),
  maplist(reverse, ReverseAcc, Coords).

bounds_coords(Xmin, Xmax, Ymin, Ymax, Coords, X, Y, Acc) :-
  X > Xmax,
  !,
  Ynext is Y - 1,
  bounds_coords(Xmin, Xmax, Ymin, Ymax, Coords, Xmin, Ynext, [ [] | Acc ]).

bounds_coords(Xmin, Xmax, Ymin, Ymax, Coords, X, Y, Acc) :-
  [ Line | Rest ] = Acc,
  X1 is X + 1,
  LineNew = [ vector(X, Y) | Line ],
  bounds_coords(Xmin, Xmax, Ymin, Ymax, Coords, X1, Y, [ LineNew | Rest ]).

format_point(Dict, Coord, Pixel) :-
  position_key(Coord, Key),
  Dict.get(Key)
  -> Pixel = '#'
  ;  Pixel = '.'.

positions_dict(Positions, Dict) :- positions_dict(Positions, Dict, positions{}).
positions_dict([], Dict, Dict) :- !.
positions_dict([ Position | Rest ], Dict, Acc) :-
  position_key(Position, Key),
  positions_dict(Rest, Dict, Acc.put(Key, true)).

position_key(Position, Key) :-
  vector(X, Y) = Position,
  format_string("~w,~w", [X, Y], String),
  atom_string(Key, String).

format_string(Format, Data, String) :- with_output_to(string(String), format(Format, Data)).